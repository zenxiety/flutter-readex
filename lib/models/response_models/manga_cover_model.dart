import 'dart:convert';

MangaCoverModel mangaCoverModelFromJson(String str) =>
    MangaCoverModel.fromJson(json.decode(str));

String mangaCoverModelToJson(MangaCoverModel data) =>
    json.encode(data.toJson());

class MangaCoverModel {
  String result;
  String response;
  Data data;

  MangaCoverModel({
    required this.result,
    required this.response,
    required this.data,
  });

  factory MangaCoverModel.fromJson(Map<String, dynamic> json) =>
      MangaCoverModel(
        result: json["result"],
        response: json["response"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "response": response,
        "data": data.toJson(),
      };
}

class Data {
  String id;
  String type;
  Attributes attributes;
  List<Relationship> relationships;

  Data({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
        attributes: Attributes.fromJson(json["attributes"]),
        relationships: List<Relationship>.from(
            json["relationships"].map((x) => Relationship.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
        "relationships":
            List<dynamic>.from(relationships.map((x) => x.toJson())),
      };
}

class Attributes {
  String description;
  dynamic volume;
  String fileName;
  String locale;
  DateTime createdAt;
  DateTime updatedAt;
  int version;

  Attributes({
    required this.description,
    required this.volume,
    required this.fileName,
    required this.locale,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        description: json["description"],
        volume: json["volume"],
        fileName: json["fileName"],
        locale: json["locale"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "volume": volume,
        "fileName": fileName,
        "locale": locale,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "version": version,
      };
}

class Relationship {
  String id;
  String type;

  Relationship({
    required this.id,
    required this.type,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}
