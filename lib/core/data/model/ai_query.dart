class AiQuery {
  String? question;
  String? lawID;
  AdditionalProp1? prop;
  String? answer;
  String? legalStatus;
  String? confidence;
  Sources? sources;

  AiQuery({this.lawID, this.question});

  factory AiQuery.fromJson(Map<String, dynamic> json) =>
      _$AiQueryFromJson(json);
  Map<String, dynamic> toJson() => _$AiQueryToJson(this);
}

AiQuery _$AiQueryFromJson(Map<String, dynamic> json) {
  var obj = AiQuery();


  obj.answer = json['answer'];
  obj.legalStatus = json['legal_status'];
  obj.confidence = json['confidence'];
  obj.prop = json['additionalProp1'] != null
      ? AdditionalProp1.fromJson(json['additionalProp1'])
      : null;

  obj.sources = json['sources'] != null
      ? Sources.fromJson(json['sources'])
      : null;


  return obj;
}

Map<String, dynamic> _$AiQueryToJson(AiQuery obj) => <String, dynamic>{
  'question': obj.question,
  'law_id': obj.lawID,
  'additionalProp1': obj.prop ?? {},
};

class AdditionalProp1 {
  String? prop;

  factory AdditionalProp1.fromJson(Map<String, dynamic> json) =>
      _$AdditionalProp1FromJson(json);

  AdditionalProp1({this.prop});
}

AdditionalProp1 _$AdditionalProp1FromJson(Map<String, dynamic> json) {
  var obj = AdditionalProp1();

  obj.prop = json['prop'];

  return obj;
}

class Sources {
  String? lawId;
  String? section;
  AdditionalProp1? prop;

  Sources({this.lawId, this.section, this.prop});

  factory Sources.fromJson(Map<String, dynamic> json) =>
      _$SourcesFromJson(json);
}

Sources _$SourcesFromJson(Map<String, dynamic> json) {
  var obj = Sources();
  obj.lawId = json['law_id'];
  obj.section = json['section'];
  obj.prop = json['additionalProp1'];
  return obj;
}
