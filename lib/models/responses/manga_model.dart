// To parse this JSON data, do
//
//     final mangaModel = mangaModelFromJson(jsonString);

import 'dart:convert';

MangaModel mangaModelFromJson(String str) =>
    MangaModel.fromJson(json.decode(str));

String mangaModelToJson(MangaModel data) => json.encode(data.toJson());

class MangaModel {
  String? result;
  String? response;
  Data? data;

  MangaModel({
    this.result,
    this.response,
    this.data,
  });

  factory MangaModel.fromJson(Map<String, dynamic> json) => MangaModel(
        result: json["result"],
        response: json["response"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "response": response,
        "data": data?.toJson(),
      };
}

class Data {
  String? id;
  String? type;
  DataAttributes? attributes;
  List<Relationship>? relationships;

  Data({
    this.id,
    this.type,
    this.attributes,
    this.relationships,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
        attributes: json["attributes"] == null
            ? null
            : DataAttributes.fromJson(json["attributes"]),
        relationships: json["relationships"] == null
            ? []
            : List<Relationship>.from(
                json["relationships"]!.map((x) => Relationship.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes?.toJson(),
        "relationships": relationships == null
            ? []
            : List<dynamic>.from(relationships!.map((x) => x.toJson())),
      };
}

class DataAttributes {
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

  DataAttributes({
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

  factory DataAttributes.fromJson(Map<String, dynamic> json) => DataAttributes(
        title:
            json["title"] == null ? null : TitleClass.fromJson(json["title"]),
        altTitles: json["altTitles"] == null
            ? []
            : List<AltTitle>.from(
                json["altTitles"]!.map((x) => AltTitle.fromJson(x))),
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
            : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
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
                    json["availableTranslatedLanguages"]!.map((x) => x)),
        latestUploadedChapter: json["latestUploadedChapter"],
      );

  Map<String, dynamic> toJson() => {
        "title": title?.toJson(),
        "altTitles": altTitles == null
            ? []
            : List<dynamic>.from(altTitles!.map((x) => x.toJson())),
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
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
        "state": state,
        "chapterNumbersResetOnNewVolume": chapterNumbersResetOnNewVolume,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "version": version,
        "availableTranslatedLanguages": availableTranslatedLanguages == null
            ? []
            : List<dynamic>.from(availableTranslatedLanguages!.map((x) => x)),
        "latestUploadedChapter": latestUploadedChapter,
      };
}

class AltTitle {
  String? ja;
  String? jaRo;
  String? zhHk;
  String? ru;

  AltTitle({
    this.ja,
    this.jaRo,
    this.zhHk,
    this.ru,
  });

  factory AltTitle.fromJson(Map<String, dynamic> json) => AltTitle(
        ja: json["ja"],
        jaRo: json["ja-ro"],
        zhHk: json["zh-hk"],
        ru: json["ru"],
      );

  Map<String, dynamic> toJson() => {
        "ja": ja,
        "ja-ro": jaRo,
        "zh-hk": zhHk,
        "ru": ru,
      };
}

class TitleClass {
  String? en;

  TitleClass({
    this.en,
  });

  factory TitleClass.fromJson(Map<String, dynamic> json) => TitleClass(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class Links {
  String? al;
  String? ap;
  String? bw;
  String? kt;
  String? mu;
  String? amz;
  String? cdj;
  String? ebj;
  String? mal;
  String? raw;

  Links({
    this.al,
    this.ap,
    this.bw,
    this.kt,
    this.mu,
    this.amz,
    this.cdj,
    this.ebj,
    this.mal,
    this.raw,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        al: json["al"],
        ap: json["ap"],
        bw: json["bw"],
        kt: json["kt"],
        mu: json["mu"],
        amz: json["amz"],
        cdj: json["cdj"],
        ebj: json["ebj"],
        mal: json["mal"],
        raw: json["raw"],
      );

  Map<String, dynamic> toJson() => {
        "al": al,
        "ap": ap,
        "bw": bw,
        "kt": kt,
        "mu": mu,
        "amz": amz,
        "cdj": cdj,
        "ebj": ebj,
        "mal": mal,
        "raw": raw,
      };
}

class Tag {
  String? id;
  String? type;
  TagAttributes? attributes;
  List<dynamic>? relationships;

  Tag({
    this.id,
    this.type,
    this.attributes,
    this.relationships,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        type: json["type"],
        attributes: json["attributes"] == null
            ? null
            : TagAttributes.fromJson(json["attributes"]),
        relationships: json["relationships"] == null
            ? []
            : List<dynamic>.from(json["relationships"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes?.toJson(),
        "relationships": relationships == null
            ? []
            : List<dynamic>.from(relationships!.map((x) => x)),
      };
}

class TagAttributes {
  TitleClass? name;
  PurpleDescription? description;
  String? group;
  int? version;

  TagAttributes({
    this.name,
    this.description,
    this.group,
    this.version,
  });

  factory TagAttributes.fromJson(Map<String, dynamic> json) => TagAttributes(
        name: json["name"] == null ? null : TitleClass.fromJson(json["name"]),
        description: json["description"] == null
            ? null
            : PurpleDescription.fromJson(json["description"]),
        group: json["group"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "name": name?.toJson(),
        "description": description?.toJson(),
        "group": group,
        "version": version,
      };
}

class PurpleDescription {
  PurpleDescription();

  factory PurpleDescription.fromJson(Map<String, dynamic> json) =>
      PurpleDescription();

  Map<String, dynamic> toJson() => {};
}

class Relationship {
  String? id;
  String? type;
  RelationshipAttributes? attributes;

  Relationship({
    this.id,
    this.type,
    this.attributes,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
        id: json["id"],
        type: json["type"],
        attributes: json["attributes"] == null
            ? null
            : RelationshipAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes?.toJson(),
      };
}

class RelationshipAttributes {
  String? name;
  dynamic imageUrl;
  TitleClass? biography;
  String? twitter;
  dynamic pixiv;
  dynamic melonBook;
  dynamic fanBox;
  dynamic booth;
  dynamic nicoVideo;
  dynamic skeb;
  dynamic fantia;
  dynamic tumblr;
  dynamic youtube;
  dynamic weibo;
  dynamic naver;
  dynamic website;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? version;
  String? description;
  String? volume;
  String? fileName;
  String? locale;

  RelationshipAttributes({
    this.name,
    this.imageUrl,
    this.biography,
    this.twitter,
    this.pixiv,
    this.melonBook,
    this.fanBox,
    this.booth,
    this.nicoVideo,
    this.skeb,
    this.fantia,
    this.tumblr,
    this.youtube,
    this.weibo,
    this.naver,
    this.website,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.description,
    this.volume,
    this.fileName,
    this.locale,
  });

  factory RelationshipAttributes.fromJson(Map<String, dynamic> json) =>
      RelationshipAttributes(
        name: json["name"],
        imageUrl: json["imageUrl"],
        biography: json["biography"] == null
            ? null
            : TitleClass.fromJson(json["biography"]),
        twitter: json["twitter"],
        pixiv: json["pixiv"],
        melonBook: json["melonBook"],
        fanBox: json["fanBox"],
        booth: json["booth"],
        nicoVideo: json["nicoVideo"],
        skeb: json["skeb"],
        fantia: json["fantia"],
        tumblr: json["tumblr"],
        youtube: json["youtube"],
        weibo: json["weibo"],
        naver: json["naver"],
        website: json["website"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        version: json["version"],
        description: json["description"],
        volume: json["volume"],
        fileName: json["fileName"],
        locale: json["locale"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "biography": biography?.toJson(),
        "twitter": twitter,
        "pixiv": pixiv,
        "melonBook": melonBook,
        "fanBox": fanBox,
        "booth": booth,
        "nicoVideo": nicoVideo,
        "skeb": skeb,
        "fantia": fantia,
        "tumblr": tumblr,
        "youtube": youtube,
        "weibo": weibo,
        "naver": naver,
        "website": website,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "version": version,
        "description": description,
        "volume": volume,
        "fileName": fileName,
        "locale": locale,
      };
}
