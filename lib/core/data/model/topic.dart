class Topic {
  String? id;
  String? label;

  factory Topic.fromJson(Map<String, dynamic> json) {
    print('This is the json: $json');
    return Topic(id: json["id"], label: json["label"]);
  }

  Topic({this.id, this.label});
}
