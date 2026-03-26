class Role {
  String? id;
  String? label;

  factory Role.fromJson(Map<String, dynamic> json) =>
      Role(id: json["id"], label: json["label"]);

  Role({this.id, this.label});
}
