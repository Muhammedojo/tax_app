class OfflinePack {
  String? version;
  String? generatedAt;
  String? source;
  String? disclaimer;
  Map<String, LawRegistry>? registry;
  Map<String, List<LawEntry>>? laws;

  OfflinePack({
    this.version,
    this.generatedAt,
    this.source,
    this.disclaimer,
    this.registry,
    this.laws,
  });

  factory OfflinePack.fromJson(Map<String, dynamic> json) {
    return OfflinePack(
      version: json['version'] as String?,
      generatedAt: json['generated_at'] as String?,
      source: json['source'] as String?,
      disclaimer: json['disclaimer'] as String?,
      registry: (json['registry'] as Map<String, dynamic>?)?.map(
        (key, value) =>
            MapEntry(key, LawRegistry.fromJson(value as Map<String, dynamic>)),
      ),
      laws: (json['laws'] as Map<String, dynamic>?)?.map(
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
    'registry': registry?.map((k, v) => MapEntry(k, v.toJson())),
    'laws': laws?.map((k, v) => MapEntry(k, v.map((e) => e.toJson()).toList())),
  };
}

class LawRegistry {
  String? id;
  String? name;
  String? shortName;
  int? year;
  int? pageSize;

  LawRegistry({this.id, this.name, this.shortName, this.year, this.pageSize});

  factory LawRegistry.fromJson(Map<String, dynamic> json) {
    return LawRegistry(
      id: json['id'] as String?,
      name: json['name'] as String?,
      shortName: json['short_name'] as String?,
      year: json['year'] as int?,
      pageSize: json['page_size'] as int?,
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
  int? id;
  String? lawId;
  String? section;
  String? content;

  LawEntry({this.id, this.lawId, this.section, this.content});

  factory LawEntry.fromJson(Map<String, dynamic> json) {
    return LawEntry(
      id: json['id'] as int?,
      lawId: json['law_id'] as String?,
      section: json['section'] as String?,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'law_id': lawId,
    'section': section,
    'content': content,
  };
}
