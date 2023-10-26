import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/models/my_manga_item_model.dart';
import 'package:flutter_manga_app_test/models/my_random_manga_item_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_chapter_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_cover_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_list_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_search_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_stats_model.dart';
import 'package:flutter_manga_app_test/services/mangadex_services.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';

class HomeProvider with ChangeNotifier {
  MangaListModel? mangaListModel;
  MangaModel? mangaModel;
  MangaCoverModel? mangaCoverModel;
  List<MyMangaItemModel> myMangaListModel = [];
  MangaChapterModel? mangaChapterModel;
  MangaStatsModel? mangaStatsModel;
  List<MyRandomMangaItemModel> myRandomMangaList = [];

  // MangaSearchModel? mangaSearchModel;

  FetchState mangalistFetchState = FetchState.initial;
  FetchState mangaRandomFetchState = FetchState.initial;
  FetchState mangaSearchFetchState = FetchState.initial;

  int currentMainPage = 0;
  final int mangaPerPage = 4;
  final int totalRandomManga = 2;
  final int totalRecommendedManga = 8;

  void resetManga() {
    mangaListModel = null;
    mangaModel = null;
    mangaCoverModel = null;
    myMangaListModel = [];
    mangaChapterModel = null;
    mangaStatsModel = null;
    myRandomMangaList = [];
  }

  void goToNextPage() {
    getMangaList(page: ++currentMainPage);
    notifyListeners();
  }

  void goToPrevPage() {
    getMangaList(page: --currentMainPage);
    notifyListeners();
  }

  Future<void> getMangaList({required int page}) async {
    try {
      mangalistFetchState = FetchState.loading;
      resetManga();

      final result = await MangaDexServices.getMangaList(page, mangaPerPage);

      mangaListModel = result;

      for (int i = 0; i < mangaListModel!.data.length; i++) {
        print("LIST $i");
        final mangaId = mangaListModel!.data[i].id;
        print("LIST 1 $mangaId");
        final mangaDetails = await MangaDexServices.getMangaDetails(mangaId);

        final coverId = mangaDetails.data!.relationships!
            .where((rel) => rel.type == "cover_art")
            .first
            .id!;
        print("LIST 2 $coverId");
        final mangaCover = await MangaDexServices.getMangaCoverModel(coverId);

        final chapterId = mangaDetails.data!.attributes!.latestUploadedChapter!;
        print("LIST 3 $chapterId");
        final mangaChapter = await MangaDexServices.getMangaChapter(chapterId);
        print("LIST 4 $mangaId");
        final mangaStats = await MangaDexServices.getMangaStats(mangaId);

        final mangaItem = MyMangaItemModel(
          mangaModel: mangaDetails,
          mangaCoverModel: mangaCover,
          mangaChapterModel: mangaChapter,
          mangaStatsModel: mangaStats,
        );
        myMangaListModel.add(mangaItem);
      }

      mangalistFetchState = FetchState.success;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getRandomManga() async {
    try {
      mangaRandomFetchState = FetchState.loading;

      for (int i = 0; i < totalRandomManga; i++) {
        print("R $i");

        final result = await MangaDexServices.getRandomManga();
        print("1");

        final mangaId = result.data.id;
        print("12 $mangaId");
        final mangaDetails = mangaId == ""
            ? null
            : await MangaDexServices.getMangaDetails(mangaId);

        final coverId = mangaDetails?.data!.relationships!
            .where((rel) => rel.type == "cover_art")
            .first
            .id;
        print("123 $coverId");
        final mangaCover = coverId == ""
            ? null
            : await MangaDexServices.getMangaCoverModel(coverId!);

        final chapterId = mangaDetails?.data!.attributes!.latestUploadedChapter;
        print("1234 $chapterId");
        final mangaChapter = chapterId == null
            ? null
            : await MangaDexServices.getMangaChapter(chapterId);

        print("12345 $mangaId");
        final mangaStats = await MangaDexServices.getMangaStats(mangaId);

        final randomMangaItem = MyRandomMangaItemModel(
          mangaModel: mangaDetails,
          mangaCoverModel: mangaCover,
          mangaChapterModel: mangaChapter,
          mangaStatsModel: mangaStats,
        );

        myRandomMangaList.add(randomMangaItem);
      }

      mangaRandomFetchState = FetchState.success;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> searchManga(String rawMangaTitle) async {
    final String mangaTitle = rawMangaTitle.replaceAll(" ", "%20");

    try {} catch (e) {
      rethrow;
    }
  }
}
