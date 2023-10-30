import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/models/custom_manga_models/my_manga_search_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_chapter_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_cover_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_search_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_stats_model.dart';
import 'package:flutter_manga_app_test/services/mangadex_service.dart';
import 'package:flutter_manga_app_test/services/openai_service.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecommendationProvider with ChangeNotifier {
  TextEditingController? searchController;
  GlobalKey<FormState> formKey = GlobalKey();
  FetchState mangaSearchFetchState = FetchState.initial;
  final List<MyMangaSearchModel> mangaSearchList = [];

  final int totalRecommendedManga = 8;
  FetchState mangaRecommendationFetchState = FetchState.initial;
  final List<String> clickedManga = [];
  final List<MyMangaSearchModel> mangaRecommendationList = [];

  String? validateSearch(String? value) {
    if (value == null || value == "") return "Enter a manga title";

    return null;
  }

  void recommendManga() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String mangaTitle = preferences.getString("favsTitle")!;

    clickedManga.add(mangaTitle);
    getRecommendations();
    notifyListeners();
  }

  String generateCover(
      {required String mangaId, required String mangaCoverId}) {
    return "https://uploads.mangadex.org/covers/$mangaId/$mangaCoverId.256.jpg";
  }

  Future<void> getRecommendations() async {
    String mangaTitleString = "";
    clickedManga.map((manga) => mangaTitleString += "'$manga'|");

    try {
      mangaRecommendationFetchState = FetchState.loading;

      final recommendationResult =
          await RecommendationService.getRecommendations(
        mangaList: mangaTitleString,
      );

      String mangaRecommendations = recommendationResult.choices[0].text;
      notifyListeners();

      final List<String> recommendedMangaTitles = [];
      mangaRecommendations
          .replaceAll('"', "")
          .split(",")
          .map((mangaTitle) => recommendedMangaTitles.add(mangaTitle.trim()))
          .toList();

      mangaRecommendationList.clear();

      for (String mangaTitle in recommendedMangaTitles) {
        final String formattedMangaTitle =
            mangaTitle.trim().replaceAll(" ", "%20");
        final MangaSearchModel mangaRecommendation =
            await MangaDexService.searchManga(mangaTitle: formattedMangaTitle);

        final String? coverId = mangaRecommendation.data![0].relationships!
            .where((rel) => rel.type == "cover_art")
            .first
            .id;
        final MangaCoverModel? mangaRecommendationCover =
            coverId == null || coverId == ""
                ? null
                : await MangaDexService.getMangaCover(coverId: coverId);

        final String? chapterId =
            mangaRecommendation.data![0].attributes!.latestUploadedChapter;
        final MangaChapterModel? mangaRecommendationChapter =
            chapterId == null || chapterId == ""
                ? null
                : await MangaDexService.getMangaChapter(chapterId: chapterId);

        final String? mangaId = mangaRecommendation.data![0].id;
        final MangaStatsModel? mangaRecommendationStats = mangaId == null
            ? null
            : await MangaDexService.getMangaStats(mangaId: mangaId);

        final MyMangaSearchModel mangaSearchModel = MyMangaSearchModel(
          mangaSearchModel: mangaRecommendation,
          mangaCoverModel: mangaRecommendationCover,
          mangaChapterModel: mangaRecommendationChapter,
          mangaStatsModel: mangaRecommendationStats,
        );

        mangaRecommendationList.add(mangaSearchModel);
        notifyListeners();
      }

      mangaRecommendationFetchState = FetchState.success;
      mangaSearchFetchState = FetchState.initial;
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> searchManga() async {
    if (!formKey.currentState!.validate()) return;

    try {
      mangaSearchFetchState = FetchState.loading;

      final String searchTitle = searchController!.text;

      final String formattedMangaTitle = searchTitle.replaceAll(" ", "%20");
      final MangaSearchModel mangaSearchResult =
          await MangaDexService.searchManga(mangaTitle: formattedMangaTitle);

      mangaSearchList.clear();

      for (Datum manga in mangaSearchResult.data!) {
        final String? coverId = manga.relationships!
            .where((rel) => rel.type == "cover_art")
            .first
            .id;
        final MangaCoverModel? mangaSearchCover =
            coverId == null || coverId == ""
                ? null
                : await MangaDexService.getMangaCover(coverId: coverId);

        final String? chapterId = manga.attributes!.latestUploadedChapter;
        final MangaChapterModel? mangaSearchChapter =
            chapterId == null || chapterId == ""
                ? null
                : await MangaDexService.getMangaChapter(chapterId: chapterId);

        final String? mangaId = manga.id;
        final MangaStatsModel? mangaSearchStats = mangaId == null
            ? null
            : await MangaDexService.getMangaStats(mangaId: mangaId);

        final MyMangaSearchModel mangaSearchModel = MyMangaSearchModel(
          mangaSearchModel: mangaSearchResult,
          mangaCoverModel: mangaSearchCover,
          mangaChapterModel: mangaSearchChapter,
          mangaStatsModel: mangaSearchStats,
        );

        mangaSearchList.add(mangaSearchModel);
        notifyListeners();
      }

      mangaSearchFetchState = FetchState.success;
      mangaRecommendationFetchState = FetchState.initial;
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
