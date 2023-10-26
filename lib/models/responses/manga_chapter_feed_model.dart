// To parse this JSON data, do
//
//     final mangaChapterFeedModel = mangaChapterFeedModelFromJson(jsonString);

import 'dart:convert';

MangaChapterFeedModel mangaChapterFeedModelFromJson(String str) =>
    MangaChapterFeedModel.fromJson(json.decode(str));

String mangaChapterFeedModelToJson(MangaChapterFeedModel data) =>
    json.encode(data.toJson());

class MangaChapterFeedModel {
  String result;
  String response;
  List<Datum> data;
  int limit;
  int offset;
  int total;

  MangaChapterFeedModel({
    required this.result,
    required this.response,
    required this.data,
    required this.limit,
    required this.offset,
    required this.total,
  });

  factory MangaChapterFeedModel.fromJson(Map<String, dynamic> json) =>
      MangaChapterFeedModel(
        result: json["result"],
        response: json["response"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        limit: json["limit"],
        offset: json["offset"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "response": response,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "limit": limit,
        "offset": offset,
        "total": total,
      };
}

class Datum {
  String id;
  DatumType type;
  Attributes attributes;
  List<Relationship> relationships;

  Datum({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: datumTypeValues.map[json["type"]] ?? DatumType.CHAPTER,
        attributes: Attributes.fromJson(json["attributes"]),
        relationships: List<Relationship>.from(
            json["relationships"].map((x) => Relationship.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": datumTypeValues.reverse[type],
        "attributes": attributes.toJson(),
        "relationships":
            List<dynamic>.from(relationships.map((x) => x.toJson())),
      };
}

class Attributes {
  String volume;
  String chapter;
  String title;
  TranslatedLanguage translatedLanguage;
  dynamic externalUrl;
  DateTime publishAt;
  DateTime readableAt;
  DateTime createdAt;
  DateTime updatedAt;
  int pages;
  int version;

  Attributes({
    required this.volume,
    required this.chapter,
    required this.title,
    required this.translatedLanguage,
    required this.externalUrl,
    required this.publishAt,
    required this.readableAt,
    required this.createdAt,
    required this.updatedAt,
    required this.pages,
    required this.version,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        volume: json["volume"] ?? "",
        chapter: json["chapter"] ?? "",
        title: json["title"] ?? "",
        translatedLanguage:
            translatedLanguageValues.map[json["translatedLanguage"]] ??
                TranslatedLanguage.EN,
        externalUrl: json["externalUrl"] ?? "",
        publishAt: DateTime.parse(json["publishAt"] ?? 0),
        readableAt: DateTime.parse(json["readableAt"] ?? 0),
        createdAt: DateTime.parse(json["createdAt"] ?? 0),
        updatedAt: DateTime.parse(json["updatedAt"] ?? 0),
        pages: json["pages"] ?? 0,
        version: json["version"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "volume": volume,
        "chapter": chapter,
        "title": title,
        "translatedLanguage":
            translatedLanguageValues.reverse[translatedLanguage],
        "externalUrl": externalUrl,
        "publishAt": publishAt.toIso8601String(),
        "readableAt": readableAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "pages": pages,
        "version": version,
      };
}

enum TranslatedLanguage { EN }

final translatedLanguageValues = EnumValues({"en": TranslatedLanguage.EN});

class Relationship {
  String id;
  RelationshipType type;

  Relationship({
    required this.id,
    required this.type,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
        id: json["id"],
        type:
            relationshipTypeValues.map[json["type"]] ?? RelationshipType.MANGA,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": relationshipTypeValues.reverse[type],
      };
}

enum RelationshipType { MANGA, SCANLATION_GROUP, USER }

final relationshipTypeValues = EnumValues({
  "manga": RelationshipType.MANGA,
  "scanlation_group": RelationshipType.SCANLATION_GROUP,
  "user": RelationshipType.USER
});

enum DatumType { CHAPTER }

final datumTypeValues = EnumValues({"chapter": DatumType.CHAPTER});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
