import 'dart:convert';

MangaChapterModel mangaChapterModelFromJson(String str) =>
    MangaChapterModel.fromJson(json.decode(str));

String mangaChapterModelToJson(MangaChapterModel data) =>
    json.encode(data.toJson());

class MangaChapterModel {
  String result;
  String response;
  Data data;

  MangaChapterModel({
    required this.result,
    required this.response,
    required this.data,
  });

  factory MangaChapterModel.fromJson(Map<String, dynamic> json) =>
      MangaChapterModel(
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
            json["relationships"].map((x) => Relationship.fromJson(x)) ?? []),
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
  // dynamic volume;
  String? chapter;
  // dynamic title;
  String translatedLanguage;
  // dynamic externalUrl;
  DateTime publishAt;
  DateTime readableAt;
  DateTime createdAt;
  DateTime updatedAt;
  int pages;
  int version;

  Attributes({
    // required this.volume,
    required this.chapter,
    // required this.title,
    required this.translatedLanguage,
    // required this.externalUrl,
    required this.publishAt,
    required this.readableAt,
    required this.createdAt,
    required this.updatedAt,
    required this.pages,
    required this.version,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        // volume: json["volume"] ?? "",
        chapter: json["chapter"] ?? "",
        // title: json["title"] ?? "",
        translatedLanguage: json["translatedLanguage"],
        // externalUrl: json["externalUrl"] ?? "",
        publishAt: DateTime.parse(json["publishAt"]),
        readableAt: DateTime.parse(json["readableAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        pages: json["pages"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        // "volume": volume ?? "",
        "chapter": chapter ?? "",
        // "title": title ?? "",
        "translatedLanguage": translatedLanguage,
        // "externalUrl": externalUrl ?? "",
        "publishAt": publishAt.toIso8601String(),
        "readableAt": readableAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "pages": pages,
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
