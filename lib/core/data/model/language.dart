class Language {
  String? code;
  String? label;

  factory Language.fromJson(Map<String, dynamic> json) =>
      Language(code: json["code"], label: json["label"]);

  Language({this.code, this.label});
}