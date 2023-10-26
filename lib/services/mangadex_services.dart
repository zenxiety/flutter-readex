import 'package:flutter_manga_app_test/models/responses/manga_author_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_chapter_feed_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_pages_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_chapter_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_cover_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_list_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_random_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_search_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_stats_model.dart';
import 'package:http/http.dart' as http;

class MangaDexServices {
  static Future<MangaListModel> getMangaList(int page, int mangaPerPage) async {
    MangaListModel? mangaListModel;

    try {
      final int mangaOffset = mangaPerPage * page;

      final url = Uri.parse(
        "https://api.mangadex.org/manga?limit=$mangaPerPage&offset=$mangaOffset",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        mangaListModel = mangaListModelFromJson(response.body);
      }
    } catch (e) {
      throw Exception("$e");
    }

    return mangaListModel!;
  }

  static Future<MangaRandomModel> getRandomManga() async {
    MangaRandomModel? mangaRandomModel;

    try {
      final url = Uri.parse(
        "https://api.mangadex.org/manga/random",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        mangaRandomModel = mangaRandomModelFromJson(response.body);
      }
    } catch (e) {
      throw Exception("$e");
    }

    return mangaRandomModel!;
  }

  static Future<MangaModel> getMangaDetails(String id) async {
    MangaModel? mangaModel;
    try {
      final url = Uri.parse(
        "https://api.mangadex.org/manga/$id?includes[]=author&includes[]=artist&includes[]=cover_art",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        mangaModel = mangaModelFromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }

    return mangaModel!;
  }

  static Future<MangaCoverModel> getMangaCoverModel(String id) async {
    MangaCoverModel? mangaCoverModel;
    try {
      final url = Uri.parse(
        "https://api.mangadex.org/cover/$id",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        mangaCoverModel = mangaCoverModelFromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }

    return mangaCoverModel!;
  }

  static Future<MangaChapterModel> getMangaChapter(String id) async {
    MangaChapterModel? mangaChapterModel;
    try {
      final url = Uri.parse(
        "https://api.mangadex.org/chapter/$id",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        mangaChapterModel = mangaChapterModelFromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }

    return mangaChapterModel!;
  }

  static Future<MangaStatsModel> getMangaStats(String id) async {
    MangaStatsModel? mangaStatsModel;
    try {
      final url = Uri.parse(
        "https://api.mangadex.org/statistics/manga/$id",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        mangaStatsModel = mangaStatsModelFromJson(response.body, id);
      }
    } catch (e) {
      rethrow;
    }

    return mangaStatsModel!;
  }

  static Future<MangaPagesModel> getMangaPages(String chapterId) async {
    MangaPagesModel? mangaChapterImagesModel;
    try {
      final url = Uri.parse(
        "https://api.mangadex.org/at-home/server/$chapterId",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        mangaChapterImagesModel =
            mangaChapterImagesModelFromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }

    return mangaChapterImagesModel!;
  }

  static Future<MangaAuthorModel> getMangaAuthor(String authorId) async {
    MangaAuthorModel? mangaAuthorModel;
    try {
      final url = Uri.parse(
        "https://api.mangadex.org/author/$authorId",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        mangaAuthorModel = mangaAuthorModelFromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }

    return mangaAuthorModel!;
  }

  static Future<MangaChapterFeedModel> getMangaChapterFeed(
    String mangaId,
  ) async {
    MangaChapterFeedModel? mangaChapterFeedModel;
    try {
      final url = Uri.parse(
        "https://api.mangadex.org/manga/$mangaId/feed?translatedLanguage%5B%5D=en&order%5Bchapter%5D=asc&includes%5B%5D=manga",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        mangaChapterFeedModel = mangaChapterFeedModelFromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }

    return mangaChapterFeedModel!;
  }

  // static Future<MangaSearchModel> searchManga(
  //   String mangaTitle,
  // ) async {
  //   MangaSearchModel? mangaSearchModel;

  //   try {
  //     final url = Uri.parse(
  //       "https://api.mangadex.org/manga?title=mangaTitle",
  //     );

  //     final headers = {
  //       "Content-Type": "application/json",
  //     };

  //     final response = await http.get(url, headers: headers);

  //     if (response.statusCode == 200) {
  //       mangaSearchModel = mangaSearchModelFromJson(response.body);
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }

  //   return mangaSearchModel!;
  // }
}
