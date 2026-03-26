class Update {
  final int id;
  final String topic;
  final String status;
  final String title;
  final String summary;
  final String publishedAt;
  final String whatChanged;
  final String whatItMeans;
  final String whatToDo;
  final String source;


  const Update({
    required this.id,
    required this.topic,
    required this.status,
    required this.title,
    required this.summary,
    required this.publishedAt, required this.whatChanged, required this.whatItMeans, required this.whatToDo, required this.source,
  });

  factory Update.fromJson(Map<String, dynamic> json) {
    return Update(
      id: json['id'] as int,
      topic: json['topic'] as String,
      status: json['status'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      publishedAt: json['published_at'] as String,
      whatChanged: json['what_changed'] as String,
      whatItMeans: json['what_it_means'] as String,
      whatToDo: json['what_to_do'] as String,
      source: json['source'] as String,
    );
  }
}


