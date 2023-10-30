import 'dart:convert';

import 'package:flutter_manga_app_test/models/response_models/manga_model.dart';

MangaSearchModel mangaSearchModelFromJson(String str) =>
    MangaSearchModel.fromJson(json.decode(str));

String mangaSearchModelToJson(MangaSearchModel data) =>
    json.encode(data.toJson());

class MangaSearchModel {
  String? result;
  String? response;
  List<Datum>? data;
  int? limit;
  int? offset;
  int? total;

  MangaSearchModel({
    this.result,
    this.response,
    this.data,
    this.limit,
    this.offset,
    this.total,
  });

  factory MangaSearchModel.fromJson(Map<String, dynamic> json) =>
      MangaSearchModel(
        result: json["result"],
        response: json["response"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(
                json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        limit: json["limit"],
        offset: json["offset"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "response": response,
        "data": data == null
            ? []
            : List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
        "limit": limit,
        "offset": offset,
        "total": total,
      };
}

class Datum {
  String? id;
  String? type;
  DatumAttributes? attributes;
  List<Relationship>? relationships;

  Datum({
    this.id,
    this.type,
    this.attributes,
    this.relationships,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
        attributes: json["attributes"] == null
            ? null
            : DatumAttributes.fromJson(json["attributes"]),
        relationships: json["relationships"] == null
            ? []
            : List<Relationship>.from(
                json["relationships"]?.map((x) => Relationship.fromJson(x)) ??
                    []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes?.toJson(),
        "relationships": relationships == null
            ? []
            : List<dynamic>.from(relationships?.map((x) => x.toJson()) ?? []),
      };
}

class DatumAttributes {
  TitleClass? title;
  List<AltTitle>? altTitles;
  TitleClass? description;
  bool? isLocked;
  Links? links;
  String? originalLanguage;
  String? lastVolume;
  String? lastChapter;
  String? publicationDemographic;
  String? status;
  int? year;
  String? contentRating;
  List<Tag>? tags;
  String? state;
  bool? chapterNumbersResetOnNewVolume;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? version;
  List<String>? availableTranslatedLanguages;
  String? latestUploadedChapter;

  DatumAttributes({
    this.title,
    this.altTitles,
    this.description,
    this.isLocked,
    this.links,
    this.originalLanguage,
    this.lastVolume,
    this.lastChapter,
    this.publicationDemographic,
    this.status,
    this.year,
    this.contentRating,
    this.tags,
    this.state,
    this.chapterNumbersResetOnNewVolume,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.availableTranslatedLanguages,
    this.latestUploadedChapter,
  });

  factory DatumAttributes.fromJson(Map<String, dynamic> json) =>
      DatumAttributes(
        title:
            json["title"] == null ? null : TitleClass.fromJson(json["title"]),
        altTitles: json["altTitles"] == null
            ? []
            : List<AltTitle>.from(
                json["altTitles"]?.map((x) => AltTitle.fromJson(x)) ?? []),
        description: json["description"] == null
            ? null
            : TitleClass.fromJson(json["description"]),
        isLocked: json["isLocked"],
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        originalLanguage: json["originalLanguage"],
        lastVolume: json["lastVolume"],
        lastChapter: json["lastChapter"],
        publicationDemographic: json["publicationDemographic"],
        status: json["status"],
        year: json["year"],
        contentRating: json["contentRating"],
        tags: json["tags"] == null
            ? []
            : List<Tag>.from(json["tags"]?.map((x) => Tag.fromJson(x)) ?? []),
        state: json["state"],
        chapterNumbersResetOnNewVolume: json["chapterNumbersResetOnNewVolume"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        version: json["version"],
        availableTranslatedLanguages:
            json["availableTranslatedLanguages"] == null
                ? []
                : List<String>.from(
                    json["availableTranslatedLanguages"]?.map((x) => x) ?? []),
        latestUploadedChapter: json["latestUploadedChapter"],
      );

  Map<String, dynamic> toJson() => {
        "title": title?.toJson(),
        "altTitles": altTitles == null
            ? []
            : List<dynamic>.from(altTitles?.map((x) => x.toJson()) ?? []),
        "description": description?.toJson(),
        "isLocked": isLocked,
        "links": links?.toJson(),
        "originalLanguage": originalLanguage,
        "lastVolume": lastVolume,
        "lastChapter": lastChapter,
        "publicationDemographic": publicationDemographic,
        "status": status,
        "year": year,
        "contentRating": contentRating,
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags?.map((x) => x.toJson()) ?? []),
        "state": state,
        "chapterNumbersResetOnNewVolume": chapterNumbersResetOnNewVolume,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "version": version,
        "availableTranslatedLanguages": availableTranslatedLanguages == null
            ? []
            : List<dynamic>.from(
                availableTranslatedLanguages?.map((x) => x) ?? []),
        "latestUploadedChapter": latestUploadedChapter,
      };
}
