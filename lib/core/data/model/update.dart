class Update {
   int? id;
   String? topic;
   String? status;
   String? title;
   String? summary;
   String? publishedAt;
  // final String whatChanged;
  // final String whatItMeans;
  // final String whatToDo;
  // final String source;

   Update({
     this.id,
     this.topic,
     this.status,
     this.title,
     this.summary,
     this.publishedAt,
    // required this.whatChanged,
    // required this.whatItMeans,
    // required this.whatToDo,
    // required this.source,
  });

  factory Update.fromJson(Map<String, dynamic> json) {
    return Update(
      id: json['id'] as int,
      topic: json['topic'] as String,
      status: json['status'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      publishedAt: json['published_at'] as String,
      // whatChanged: json['what_changed'] as String,
      // whatItMeans: json['what_it_means'] as String,
      // whatToDo: json['what_to_do'] as String,
      // source: json['source'] as String,
    );
  }
}
