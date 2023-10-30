import 'dart:convert';

MangaRandomModel mangaRandomModelFromJson(String str) =>
    MangaRandomModel.fromJson(json.decode(str));

String mangaRandomModelToJson(MangaRandomModel data) =>
    json.encode(data.toJson());

class MangaRandomModel {
  String result;
  String response;
  Data data;

  MangaRandomModel({
    required this.result,
    required this.response,
    required this.data,
  });

  factory MangaRandomModel.fromJson(Map<String, dynamic> json) =>
      MangaRandomModel(
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
  DataAttributes attributes;
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
        attributes: DataAttributes.fromJson(json["attributes"]),
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

class DataAttributes {
  Description title;
  List<Description> altTitles;
  bool isLocked;
  String originalLanguage;
  String lastVolume;
  String lastChapter;
  String status;
  dynamic year;
  String contentRating;
  List<Tag> tags;
  String state;
  bool chapterNumbersResetOnNewVolume;
  DateTime createdAt;
  DateTime updatedAt;
  int version;
  List<String> availableTranslatedLanguages;
  String latestUploadedChapter;

  DataAttributes({
    required this.title,
    required this.altTitles,
    required this.isLocked,
    required this.originalLanguage,
    required this.lastVolume,
    required this.lastChapter,
    required this.status,
    required this.year,
    required this.contentRating,
    required this.tags,
    required this.state,
    required this.chapterNumbersResetOnNewVolume,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.availableTranslatedLanguages,
    required this.latestUploadedChapter,
  });

  factory DataAttributes.fromJson(Map<String, dynamic> json) => DataAttributes(
        title: Description.fromJson(json["title"] ?? ""),
        altTitles: List<Description>.from(
            json["altTitles"].map((x) => Description.fromJson(x)) ?? []),
        isLocked: json["isLocked"],
        originalLanguage: json["originalLanguage"] ?? "",
        lastVolume: json["lastVolume"] ?? "",
        lastChapter: json["lastChapter"] ?? "",
        status: json["status"] ?? "",
        year: json["year"] ?? 0,
        contentRating: json["contentRating"] ?? "",
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x)) ?? []),
        state: json["state"] ?? "",
        chapterNumbersResetOnNewVolume: json["chapterNumbersResetOnNewVolume"],
        createdAt: DateTime.parse(json["createdAt"] ?? ""),
        updatedAt: DateTime.parse(json["updatedAt"] ?? ""),
        version: json["version"] ?? 0,
        availableTranslatedLanguages: List<String>.from(
            json["availableTranslatedLanguages"].map((x) => x) ?? []),
        latestUploadedChapter: json["latestUploadedChapter"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "title": title.toJson(),
        "altTitles": List<dynamic>.from(altTitles.map((x) => x.toJson())),
        "isLocked": isLocked,
        "originalLanguage": originalLanguage,
        "lastVolume": lastVolume,
        "lastChapter": lastChapter,
        "status": status,
        "year": year,
        "contentRating": contentRating,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "state": state,
        "chapterNumbersResetOnNewVolume": chapterNumbersResetOnNewVolume,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "version": version,
        "availableTranslatedLanguages":
            List<dynamic>.from(availableTranslatedLanguages.map((x) => x)),
        "latestUploadedChapter": latestUploadedChapter,
      };
}

class Description {
  String en;

  Description({
    required this.en,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        en: json["en"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class Tag {
  String id;
  String type;
  TagAttributes attributes;
  List<dynamic> relationships;

  Tag({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        type: json["type"],
        attributes: TagAttributes.fromJson(json["attributes"]),
        relationships: List<dynamic>.from(json["relationships"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
        "relationships": List<dynamic>.from(relationships.map((x) => x)),
      };
}

class TagAttributes {
  Description name;
  List<dynamic> description;
  String group;
  int version;

  TagAttributes({
    required this.name,
    required this.description,
    required this.group,
    required this.version,
  });

  factory TagAttributes.fromJson(Map<String, dynamic> json) => TagAttributes(
        name: Description.fromJson(json["name"] ?? ""),
        description:
            List<dynamic>.from(json["description"].map((x) => x) ?? []),
        group: json["group"] ?? "",
        version: json["version"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "description": List<dynamic>.from(description.map((x) => x)),
        "group": group,
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
        id: json["id"] ?? "",
        type: json["type"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}
