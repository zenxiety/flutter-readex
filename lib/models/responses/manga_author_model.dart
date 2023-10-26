import 'dart:convert';

MangaAuthorModel mangaAuthorModelFromJson(String str) =>
    MangaAuthorModel.fromJson(json.decode(str));

String mangaAuthorModelToJson(MangaAuthorModel data) =>
    json.encode(data.toJson());

class MangaAuthorModel {
  String result;
  String response;
  Data data;

  MangaAuthorModel({
    required this.result,
    required this.response,
    required this.data,
  });

  factory MangaAuthorModel.fromJson(Map<String, dynamic> json) =>
      MangaAuthorModel(
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
  List<dynamic> relationships;

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
        relationships: List<dynamic>.from(json["relationships"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
        "relationships": List<dynamic>.from(relationships.map((x) => x)),
      };
}

class Attributes {
  String name;
  dynamic imageUrl;
  Biography biography;
  dynamic twitter;
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
  DateTime createdAt;
  DateTime updatedAt;
  int version;

  Attributes({
    required this.name,
    required this.imageUrl,
    required this.biography,
    required this.twitter,
    required this.pixiv,
    required this.melonBook,
    required this.fanBox,
    required this.booth,
    required this.nicoVideo,
    required this.skeb,
    required this.fantia,
    required this.tumblr,
    required this.youtube,
    required this.weibo,
    required this.naver,
    required this.website,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        name: json["name"],
        imageUrl: json["imageUrl"] ?? "",
        biography: Biography.fromJson(json["biography"] ?? ""),
        twitter: json["twitter"] ?? "",
        pixiv: json["pixiv"] ?? "",
        melonBook: json["melonBook"] ?? "",
        fanBox: json["fanBox"] ?? "",
        booth: json["booth"] ?? "",
        nicoVideo: json["nicoVideo"] ?? "",
        skeb: json["skeb"] ?? "",
        fantia: json["fantia"] ?? "",
        tumblr: json["tumblr"] ?? "",
        youtube: json["youtube"] ?? "",
        weibo: json["weibo"] ?? "",
        naver: json["naver"] ?? "",
        website: json["website"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "biography": biography.toJson(),
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "version": version,
      };
}

class Biography {
  Biography();

  factory Biography.fromJson(Map<String, dynamic> json) => Biography();

  Map<String, dynamic> toJson() => {};
}
