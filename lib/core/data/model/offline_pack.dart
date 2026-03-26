class OfflinePack {
  final String version;
  final String generatedAt;
  final String source;
  final String disclaimer;
  final Map<String, LawRegistry> registry;
  final Map<String, List<LawEntry>> laws;

  const OfflinePack({
    required this.version,
    required this.generatedAt,
    required this.source,
    required this.disclaimer,
    required this.registry,
    required this.laws,
  });

  factory OfflinePack.fromJson(Map<String, dynamic> json) {
    return OfflinePack(
      version: json['version'] as String,
      generatedAt: json['generated_at'] as String,
      source: json['source'] as String,
      disclaimer: json['disclaimer'] as String,
      registry: (json['registry'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          LawRegistry.fromJson(value as Map<String, dynamic>),
        ),
      ),
      laws: (json['laws'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>)
              .map((e) => LawEntry.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'version': version,
        'generated_at': generatedAt,
        'source': source,
        'disclaimer': disclaimer,
        'registry': registry.map((k, v) => MapEntry(k, v.toJson())),
        'laws': laws.map((k, v) => MapEntry(k, v.map((e) => e.toJson()).toList())),
      };
}

class LawRegistry {
  final String id;
  final String name;
  final String shortName;
  final int year;
  final int pageSize;

  const LawRegistry({
    required this.id,
    required this.name,
    required this.shortName,
    required this.year,
    required this.pageSize,
  });

  factory LawRegistry.fromJson(Map<String, dynamic> json) {
    return LawRegistry(
      id: json['id'] as String,
      name: json['name'] as String,
      shortName: json['short_name'] as String,
      year: json['year'] as int,
      pageSize: json['page_size'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'short_name': shortName,
        'year': year,
        'page_size': pageSize,
      };
}

class LawEntry {
  final int id;
  final String lawId;
  final String section;
  final String content;

  const LawEntry({
    required this.id,
    required this.lawId,
    required this.section,
    required this.content,
  });

  factory LawEntry.fromJson(Map<String, dynamic> json) {
    return LawEntry(
      id: json['id'] as int,
      lawId: json['law_id'] as String,
      section: json['section'] as String,
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'law_id': lawId,
        'section': section,
        'content': content,
      };
}
