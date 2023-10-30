import 'dart:convert';

MangaStatsModel mangaStatsModelFromJson(String str, String id) =>
    MangaStatsModel.fromJson(json.decode(str), id);

String mangaStatsModelToJson(MangaStatsModel data, String id) =>
    json.encode(data.toJson(id));

class MangaStatsModel {
  String result;
  Statistics statistics;

  MangaStatsModel({
    required this.result,
    required this.statistics,
  });

  factory MangaStatsModel.fromJson(Map<String, dynamic> json, String id) =>
      MangaStatsModel(
        result: json["result"],
        statistics: Statistics.fromJson(json["statistics"], id),
      );

  Map<String, dynamic> toJson(id) => {
        "result": result,
        "statistics": statistics.toJson(id),
      };
}

class Statistics {
  MangaId mangaId;

  Statistics({
    required this.mangaId,
  });

  factory Statistics.fromJson(Map<String, dynamic> json, String id) =>
      Statistics(
        mangaId: MangaId.fromJson(json[id]),
      );

  Map<String, dynamic> toJson(String id) => {
        id: mangaId.toJson(),
      };
}

class MangaId {
  Comments? comments;
  Rating rating;
  int follows;

  MangaId({
    required this.comments,
    required this.rating,
    required this.follows,
  });

  factory MangaId.fromJson(Map<String, dynamic> json) => MangaId(
        comments: json["comments"] == null
            ? null
            : Comments.fromJson(json["comments"]),
        rating: Rating.fromJson(json["rating"]),
        follows: json["follows"],
      );

  Map<String, dynamic> toJson() => {
        "comments": comments?.toJson(),
        "rating": rating.toJson(),
        "follows": follows,
      };
}

class Comments {
  int threadId;
  int repliesCount;

  Comments({
    required this.threadId,
    required this.repliesCount,
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        threadId: json["threadId"],
        repliesCount: json["repliesCount"],
      );

  Map<String, dynamic> toJson() => {
        "threadId": threadId,
        "repliesCount": repliesCount,
      };
}

class Rating {
  double? average;
  double bayesian;
  Map<String, int> distribution;

  Rating({
    required this.average,
    required this.bayesian,
    required this.distribution,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        average: json["average"]?.toDouble() ?? 0,
        bayesian: json["bayesian"]?.toDouble(),
        distribution: Map.from(json["distribution"])
            .map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "average": average ?? 0,
        "bayesian": bayesian,
        "distribution": Map.from(distribution)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
