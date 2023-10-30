import 'dart:convert';

import 'package:flutter_manga_app_test/models/response_models/manga_model.dart';

MangaListModel mangaListModelFromJson(String str) =>
    MangaListModel.fromJson(json.decode(str));

String mangaListModelToJson(MangaListModel data) => json.encode(data.toJson());

class MangaListModel {
  String result;
  String response;
  List<Datum> data;
  int limit;
  int offset;
  int total;

  MangaListModel({
    required this.result,
    required this.response,
    required this.data,
    required this.limit,
    required this.offset,
    required this.total,
  });

  factory MangaListModel.fromJson(Map<String, dynamic> json) => MangaListModel(
        result: json["result"],
        response: json["response"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        limit: json["limit"] ?? 0,
        offset: json["offset"] ?? 0,
        total: json["total"] ?? 0,
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
  RelationshipType type;
  DatumAttributes attributes;
  List<Relationship> relationships;

  Datum({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type:
            relationshipTypeValues.map[json["type"]] ?? RelationshipType.artist,
        attributes: DatumAttributes.fromJson(json["attributes"]),
        relationships: List<Relationship>.from(
            json["relationships"].map((x) => Relationship.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": relationshipTypeValues.reverse[type],
        "attributes": attributes.toJson(),
        "relationships":
            List<dynamic>.from(relationships.map((x) => x.toJson())),
      };
}

class DatumAttributes {
  Title title;
  List<AltTitle> altTitles;
  PurpleDescription description;
  bool isLocked;
  Links? links;
  OriginalLanguage originalLanguage;
  String? lastVolume;
  String? lastChapter;
  String? publicationDemographic;
  Status status;
  int? year;
  ContentRating contentRating;
  List<Tag> tags;
  MangaState state;
  bool chapterNumbersResetOnNewVolume;
  DateTime createdAt;
  DateTime updatedAt;
  int version;
  List<String?> availableTranslatedLanguages;
  String latestUploadedChapter;

  DatumAttributes({
    required this.title,
    required this.altTitles,
    required this.description,
    required this.isLocked,
    required this.links,
    required this.originalLanguage,
    required this.lastVolume,
    required this.lastChapter,
    required this.publicationDemographic,
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

  factory DatumAttributes.fromJson(Map<String, dynamic> json) =>
      DatumAttributes(
        title: Title.fromJson(json["title"]),
        altTitles: List<AltTitle>.from(
            json["altTitles"].map((x) => AltTitle.fromJson(x))),
        description: PurpleDescription.fromJson(json["description"]),
        isLocked: json["isLocked"],
        links: Links.fromJson(json["links"]),
        originalLanguage:
            originalLanguageValues.map[json["originalLanguage"]] ??
                OriginalLanguage.ja,
        lastVolume: json["lastVolume"] ?? "",
        lastChapter: json["lastChapter"] ?? "",
        publicationDemographic: json["publicationDemographic"] ?? "",
        status: statusValues.map[json["status"]] ?? Status.completed,
        year: json["year"] ?? 0,
        contentRating: contentRatingValues.map[json["contentRating"]] ??
            ContentRating.safe,
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        state: stateValues.map[json["state"]] ?? MangaState.published,
        chapterNumbersResetOnNewVolume: json["chapterNumbersResetOnNewVolume"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        version: json["version"] ?? 0,
        availableTranslatedLanguages: List<String?>.from(
            json["availableTranslatedLanguages"].map((x) => x)),
        latestUploadedChapter: json["latestUploadedChapter"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "title": title.toJson(),
        "altTitles": List<dynamic>.from(altTitles.map((x) => x.toJson())),
        "description": description.toJson(),
        "isLocked": isLocked,
        "links": links?.toJson() ?? [],
        "originalLanguage": originalLanguageValues.reverse[originalLanguage],
        "lastVolume": lastVolume,
        "lastChapter": lastChapter,
        "publicationDemographic": publicationDemographic ?? "",
        "status": statusValues.reverse[status],
        "year": year ?? 0,
        "contentRating": contentRatingValues.reverse[contentRating],
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "state": stateValues.reverse[state],
        "chapterNumbersResetOnNewVolume": chapterNumbersResetOnNewVolume,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "version": version,
        "availableTranslatedLanguages":
            List<dynamic>.from(availableTranslatedLanguages.map((x) => x)),
        "latestUploadedChapter": latestUploadedChapter,
      };
}

enum ContentRating { erotica, safe, suggestive }

final contentRatingValues = EnumValues({
  "erotica": ContentRating.erotica,
  "safe": ContentRating.safe,
  "suggestive": ContentRating.suggestive
});

class PurpleDescription {
  String? en;
  String? ru;
  String? ja;
  String? esLa;
  String? de;
  String? es;
  String? fr;
  String? it;
  String? pt;
  String? tr;
  String? uk;
  String? vi;
  String? ptBr;
  String? zhHk;

  PurpleDescription({
    this.en,
    this.ru,
    this.ja,
    this.esLa,
    this.de,
    this.es,
    this.fr,
    this.it,
    this.pt,
    this.tr,
    this.uk,
    this.vi,
    this.ptBr,
    this.zhHk,
  });

  factory PurpleDescription.fromJson(Map<String, dynamic> json) =>
      PurpleDescription(
        en: json["en"],
        ru: json["ru"],
        ja: json["ja"],
        esLa: json["es-la"],
        de: json["de"],
        es: json["es"],
        fr: json["fr"],
        it: json["it"],
        pt: json["pt"],
        tr: json["tr"],
        uk: json["uk"],
        vi: json["vi"],
        ptBr: json["pt-br"],
        zhHk: json["zh-hk"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "ru": ru,
        "ja": ja,
        "es-la": esLa,
        "de": de,
        "es": es,
        "fr": fr,
        "it": it,
        "pt": pt,
        "tr": tr,
        "uk": uk,
        "vi": vi,
        "pt-br": ptBr,
        "zh-hk": zhHk,
      };
}

class Links {
  String? al;
  String? ap;
  String? bw;
  String? kt;
  String? mu;
  String? amz;
  String? ebj;
  String? mal;
  String? engtl;
  String? raw;
  String? cdj;
  String? nu;

  Links({
    this.al,
    this.ap,
    this.bw,
    this.kt,
    this.mu,
    this.amz,
    this.ebj,
    this.mal,
    this.engtl,
    this.raw,
    this.cdj,
    this.nu,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        al: json["al"],
        ap: json["ap"],
        bw: json["bw"],
        kt: json["kt"],
        mu: json["mu"],
        amz: json["amz"],
        ebj: json["ebj"],
        mal: json["mal"],
        engtl: json["engtl"],
        raw: json["raw"],
        cdj: json["cdj"],
        nu: json["nu"],
      );

  Map<String, dynamic> toJson() => {
        "al": al,
        "ap": ap,
        "bw": bw,
        "kt": kt,
        "mu": mu,
        "amz": amz,
        "ebj": ebj,
        "mal": mal,
        "engtl": engtl,
        "raw": raw,
        "cdj": cdj,
        "nu": nu,
      };
}

enum OriginalLanguage { ja, zh }

final originalLanguageValues =
    EnumValues({"ja": OriginalLanguage.ja, "zh": OriginalLanguage.zh});

enum MangaState { published }

final stateValues = EnumValues({"published": MangaState.published});

enum Status { completed, ongoing }

final statusValues =
    EnumValues({"completed": Status.completed, "ongoing": Status.ongoing});

class Title {
  String en;

  Title({
    required this.en,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        en: json["en"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

enum RelationshipType { artist, author, coverArt, creator, manga }

final relationshipTypeValues = EnumValues({
  "artist": RelationshipType.artist,
  "author": RelationshipType.author,
  "cover_art": RelationshipType.coverArt,
  "creator": RelationshipType.creator,
  "manga": RelationshipType.manga
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
