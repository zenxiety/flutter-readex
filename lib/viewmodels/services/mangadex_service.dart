import 'package:flutter_manga_app_test/utils/constants/urls.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_author_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_chapter_feed_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_pages_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_chapter_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_cover_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_list_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_random_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_search_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_stats_model.dart';
import 'package:http/http.dart' as http;

class MangaDexService {
  static Future<MangaListModel> getMangaList({
    required int page,
    required int mangaPerPage,
  }) async {
    final Urls urls = Urls();
    MangaListModel? mangaListModel;

    try {
      final int mangaOffset = mangaPerPage * page;

      final url = Uri.parse(
        "${urls.mangaDexBaseUrl}manga?limit=$mangaPerPage&offset=$mangaOffset&contentRating[]=safe",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      mangaListModel = mangaListModelFromJson(response.body);

      return mangaListModel;
    } catch (_) {
      rethrow;
    }
  }

  static Future<MangaRandomModel> getRandomManga() async {
    final Urls urls = Urls();
    MangaRandomModel? mangaRandomModel;

    try {
      final url = Uri.parse(
        "${urls.mangaDexBaseUrl}manga/random?contentRating[]=safe",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      mangaRandomModel = mangaRandomModelFromJson(response.body);

      return mangaRandomModel;
    } catch (_) {
      rethrow;
    }
  }

  static Future<MangaModel> getMangaDetails({required String mangaId}) async {
    final Urls urls = Urls();
    MangaModel? mangaModel;

    try {
      final url = Uri.parse(
        "${urls.mangaDexBaseUrl}manga/$mangaId?includes[]=author&includes[]=artist&includes[]=cover_art",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      mangaModel = mangaModelFromJson(response.body);

      return mangaModel;
    } catch (_) {
      rethrow;
    }
  }

  static Future<MangaCoverModel> getMangaCover({
    required String coverId,
  }) async {
    final Urls urls = Urls();
    MangaCoverModel? mangaCoverModel;

    try {
      final url = Uri.parse(
        "${urls.mangaDexBaseUrl}cover/$coverId",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      mangaCoverModel = mangaCoverModelFromJson(response.body);

      return mangaCoverModel;
    } catch (_) {
      rethrow;
    }
  }

  static Future<MangaChapterModel> getMangaChapter({
    required String chapterId,
  }) async {
    final Urls urls = Urls();
    MangaChapterModel? mangaChapterModel;

    try {
      final url = Uri.parse(
        "${urls.mangaDexBaseUrl}chapter/$chapterId",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      mangaChapterModel = mangaChapterModelFromJson(response.body);

      return mangaChapterModel;
    } catch (_) {
      rethrow;
    }
  }

  static Future<MangaStatsModel> getMangaStats({
    required String mangaId,
  }) async {
    final Urls urls = Urls();
    MangaStatsModel? mangaStatsModel;

    try {
      final url = Uri.parse(
        "${urls.mangaDexBaseUrl}statistics/manga/$mangaId",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      mangaStatsModel = mangaStatsModelFromJson(response.body, mangaId);

      return mangaStatsModel;
    } catch (_) {
      rethrow;
    }
  }

  static Future<MangaPagesModel> getMangaPages({
    required String chapterId,
  }) async {
    final Urls urls = Urls();
    MangaPagesModel? mangaChapterImagesModel;

    try {
      final url = Uri.parse(
        "${urls.mangaDexBaseUrl}at-home/server/$chapterId",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      mangaChapterImagesModel = mangaChapterImagesModelFromJson(response.body);

      return mangaChapterImagesModel;
    } catch (_) {
      rethrow;
    }
  }

  static Future<MangaAuthorModel> getMangaAuthor({
    required String authorId,
  }) async {
    final Urls urls = Urls();
    MangaAuthorModel? mangaAuthorModel;

    try {
      final url = Uri.parse(
        "${urls.mangaDexBaseUrl}author/$authorId",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      mangaAuthorModel = mangaAuthorModelFromJson(response.body);

      return mangaAuthorModel;
    } catch (_) {
      rethrow;
    }
  }

  static Future<MangaChapterFeedModel> getMangaChapterFeed({
    required String mangaId,
  }) async {
    final Urls urls = Urls();
    MangaChapterFeedModel? mangaChapterFeedModel;

    try {
      final url = Uri.parse(
        "${urls.mangaDexBaseUrl}manga/$mangaId/feed?translatedLanguage%5B%5D=en&order%5Bchapter%5D=asc&includes%5B%5D=manga",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      mangaChapterFeedModel = mangaChapterFeedModelFromJson(response.body);

      return mangaChapterFeedModel;
    } catch (_) {
      rethrow;
    }
  }

  static Future<MangaSearchModel> searchManga({
    required String mangaTitle,
  }) async {
    final Urls urls = Urls();
    MangaSearchModel? mangaSearchModel;

    try {
      final url = Uri.parse(
        "${urls.mangaDexBaseUrl}manga?title=$mangaTitle&order%5Byear%5D=desc&contentRating[]=safe",
      );

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      mangaSearchModel = mangaSearchModelFromJson(response.body);

      return mangaSearchModel;
    } catch (_) {
      rethrow;
    }
  }
}
