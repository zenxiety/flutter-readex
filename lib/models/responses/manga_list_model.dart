import 'dart:convert';

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
            relationshipTypeValues.map[json["type"]] ?? RelationshipType.ARTIST,
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
  List<ListAltTitle> altTitles;
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
        altTitles: List<ListAltTitle>.from(
            json["altTitles"].map((x) => ListAltTitle.fromJson(x))),
        description: PurpleDescription.fromJson(json["description"]),
        isLocked: json["isLocked"],
        links: Links.fromJson(json["links"]),
        originalLanguage:
            originalLanguageValues.map[json["originalLanguage"]] ??
                OriginalLanguage.JA,
        lastVolume: json["lastVolume"] ?? "",
        lastChapter: json["lastChapter"] ?? "",
        publicationDemographic: json["publicationDemographic"] ?? "",
        status: statusValues.map[json["status"]] ?? Status.COMPLETED,
        year: json["year"] ?? 0,
        contentRating: contentRatingValues.map[json["contentRating"]] ??
            ContentRating.SAFE,
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        state: stateValues.map[json["state"]] ?? MangaState.PUBLISHED,
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

class ListAltTitle {
  String? pl;
  String? ru;
  String? zhHk;
  String? ja;
  String? zh;
  String? ko;
  String? jaRo;
  String? en;
  String? vi;
  String? esLa;
  String? fr;
  String? ptBr;
  String? ar;
  String? he;
  String? tl;
  String? tr;
  String? uk;
  String? th;
  String? it;
  String? ms;
  String? zhRo;

  ListAltTitle({
    this.pl,
    this.ru,
    this.zhHk,
    this.ja,
    this.zh,
    this.ko,
    this.jaRo,
    this.en,
    this.vi,
    this.esLa,
    this.fr,
    this.ptBr,
    this.ar,
    this.he,
    this.tl,
    this.tr,
    this.uk,
    this.th,
    this.it,
    this.ms,
    this.zhRo,
  });

  factory ListAltTitle.fromJson(Map<String, dynamic> json) => ListAltTitle(
        pl: json["pl"],
        ru: json["ru"],
        zhHk: json["zh-hk"],
        ja: json["ja"],
        zh: json["zh"],
        ko: json["ko"],
        jaRo: json["ja-ro"],
        en: json["en"],
        vi: json["vi"],
        esLa: json["es-la"],
        fr: json["fr"],
        ptBr: json["pt-br"],
        ar: json["ar"],
        he: json["he"],
        tl: json["tl"],
        tr: json["tr"],
        uk: json["uk"],
        th: json["th"],
        it: json["it"],
        ms: json["ms"],
        zhRo: json["zh-ro"],
      );

  Map<String, dynamic> toJson() => {
        "pl": pl,
        "ru": ru,
        "zh-hk": zhHk,
        "ja": ja,
        "zh": zh,
        "ko": ko,
        "ja-ro": jaRo,
        "en": en,
        "vi": vi,
        "es-la": esLa,
        "fr": fr,
        "pt-br": ptBr,
        "ar": ar,
        "he": he,
        "tl": tl,
        "tr": tr,
        "uk": uk,
        "th": th,
        "it": it,
        "ms": ms,
        "zh-ro": zhRo,
      };
}

enum ContentRating { EROTICA, SAFE, SUGGESTIVE }

final contentRatingValues = EnumValues({
  "erotica": ContentRating.EROTICA,
  "safe": ContentRating.SAFE,
  "suggestive": ContentRating.SUGGESTIVE
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

enum OriginalLanguage { JA, ZH }

final originalLanguageValues =
    EnumValues({"ja": OriginalLanguage.JA, "zh": OriginalLanguage.ZH});

enum MangaState { PUBLISHED }

final stateValues = EnumValues({"published": MangaState.PUBLISHED});

enum Status { COMPLETED, ONGOING }

final statusValues =
    EnumValues({"completed": Status.COMPLETED, "ongoing": Status.ONGOING});

class Tag {
  String id;
  TagType type;
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
        type: tagTypeValues.map[json["type"]] ?? TagType.TAG,
        attributes: TagAttributes.fromJson(json["attributes"]),
        relationships: List<dynamic>.from(json["relationships"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": tagTypeValues.reverse[type],
        "attributes": attributes.toJson(),
        "relationships": List<dynamic>.from(relationships.map((x) => x)),
      };
}

class TagAttributes {
  Title name;
  FluffyDescription description;
  Group group;
  int version;

  TagAttributes({
    required this.name,
    required this.description,
    required this.group,
    required this.version,
  });

  factory TagAttributes.fromJson(Map<String, dynamic> json) => TagAttributes(
        name: Title.fromJson(json["name"]),
        description: FluffyDescription.fromJson(json["description"]),
        group: groupValues.map[json["group"]] ?? Group.CONTENT,
        version: json["version"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "description": description.toJson(),
        "group": groupValues.reverse[group],
        "version": version,
      };
}

class FluffyDescription {
  FluffyDescription();

  factory FluffyDescription.fromJson(Map<String, dynamic> json) =>
      FluffyDescription();

  Map<String, dynamic> toJson() => {};
}

enum Group { CONTENT, FORMAT, GENRE, THEME }

final groupValues = EnumValues({
  "content": Group.CONTENT,
  "format": Group.FORMAT,
  "genre": Group.GENRE,
  "theme": Group.THEME
});

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

enum TagType { TAG }

final tagTypeValues = EnumValues({"tag": TagType.TAG});

class Relationship {
  String id;
  RelationshipType type;
  String? related;

  Relationship({
    required this.id,
    required this.type,
    this.related,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
        id: json["id"],
        type:
            relationshipTypeValues.map[json["type"]] ?? RelationshipType.ARTIST,
        related: json["related"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": relationshipTypeValues.reverse[type],
        "related": related,
      };
}

enum RelationshipType { ARTIST, AUTHOR, COVER_ART, CREATOR, MANGA }

final relationshipTypeValues = EnumValues({
  "artist": RelationshipType.ARTIST,
  "author": RelationshipType.AUTHOR,
  "cover_art": RelationshipType.COVER_ART,
  "creator": RelationshipType.CREATOR,
  "manga": RelationshipType.MANGA
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
