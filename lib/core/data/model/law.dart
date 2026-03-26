class Law {
  int? id;
  String? lawID;
  String? section;
  String? title;

  factory Law.fromJson(Map<String, dynamic> json) => Law(
        id: json["id"],
        lawID: json["law_id"],
        section: json["section"],
        title: json["title"],
      );

  Law({this.id, this.lawID, this.section, this.title});
}
