import 'dart:convert';

MangaPagesModel mangaChapterImagesModelFromJson(String str) =>
    MangaPagesModel.fromJson(json.decode(str));

String mangaChapterImagesModelToJson(MangaPagesModel data) =>
    json.encode(data.toJson());

class MangaPagesModel {
  String result;
  String baseUrl;
  Chapter chapter;

  MangaPagesModel({
    required this.result,
    required this.baseUrl,
    required this.chapter,
  });

  factory MangaPagesModel.fromJson(Map<String, dynamic> json) =>
      MangaPagesModel(
        result: json["result"],
        baseUrl: json["baseUrl"],
        chapter: Chapter.fromJson(json["chapter"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "baseUrl": baseUrl,
        "chapter": chapter.toJson(),
      };
}

class Chapter {
  String hash;
  List<String> data;
  List<String> dataSaver;

  Chapter({
    required this.hash,
    required this.data,
    required this.dataSaver,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        hash: json["hash"],
        data: List<String>.from(json["data"].map((x) => x)),
        dataSaver: List<String>.from(json["dataSaver"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "hash": hash,
        "data": List<dynamic>.from(data.map((x) => x)),
        "dataSaver": List<dynamic>.from(dataSaver.map((x) => x)),
      };
}
