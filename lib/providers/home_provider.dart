import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/models/custom_manga_models/my_manga_item_model.dart';
import 'package:flutter_manga_app_test/models/custom_manga_models/my_random_manga_item_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_chapter_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_cover_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_list_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_random_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_stats_model.dart';
import 'package:flutter_manga_app_test/services/mangadex_services.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';

class HomeProvider with ChangeNotifier {
  MangaListModel? mangaListModel;
  MangaModel? mangaModel;
  MangaCoverModel? mangaCoverModel;
  MangaChapterModel? mangaChapterModel;
  MangaStatsModel? mangaStatsModel;

  final List<MyMangaItemModel> myMangaListModel = [];
  final List<MyRandomMangaItemModel> myRandomMangaList = [];

  FetchState mangalistFetchState = FetchState.initial;
  FetchState mangaRandomFetchState = FetchState.initial;

  int currentMainPage = 0;
  final int mangaPerPage = 8;
  final int totalRandomManga = 8;

  void resetManga() {
    mangaListModel = null;
    mangaModel = null;
    mangaCoverModel = null;
    myMangaListModel.clear();
    mangaChapterModel = null;
    mangaStatsModel = null;
    myRandomMangaList.clear();
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

      myMangaListModel.clear();

      final MangaListModel result = await MangaDexServices.getMangaList(
        page: page,
        mangaPerPage: mangaPerPage,
      );

      mangaListModel = result;

      for (int i = 0; i < mangaListModel!.data.length; i++) {
        final String mangaId = mangaListModel!.data[i].id;
        final MangaModel? mangaDetails = mangaId == ''
            ? null
            : await MangaDexServices.getMangaDetails(mangaId: mangaId);

        final String coverId = mangaDetails!.data!.relationships!
            .where((rel) => rel.type == "cover_art")
            .first
            .id!;
        final MangaCoverModel? mangaCover = coverId == ""
            ? null
            : await MangaDexServices.getMangaCover(coverId: coverId);

        final String chapterId =
            mangaDetails.data!.attributes!.latestUploadedChapter!;
        final MangaChapterModel? mangaChapter = chapterId == ""
            ? null
            : await MangaDexServices.getMangaChapter(chapterId: chapterId);

        final MangaStatsModel? mangaStats = mangaId == ''
            ? null
            : await MangaDexServices.getMangaStats(mangaId: mangaId);

        final MyMangaItemModel mangaItem = MyMangaItemModel(
          mangaModel: mangaDetails,
          mangaCoverModel: mangaCover,
          mangaChapterModel: mangaChapter,
          mangaStatsModel: mangaStats,
        );

        myMangaListModel.add(mangaItem);
      }

      mangalistFetchState = FetchState.success;
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> getRandomManga() async {
    try {
      mangaRandomFetchState = FetchState.loading;
      notifyListeners();

      myRandomMangaList.clear();

      for (int i = 0; i < totalRandomManga; i++) {
        final MangaRandomModel result = await MangaDexServices.getRandomManga();

        final String mangaId = result.data.id;
        final MangaModel? mangaDetails = mangaId == ""
            ? null
            : await MangaDexServices.getMangaDetails(mangaId: mangaId);

        final String? coverId = mangaDetails?.data!.relationships!
            .where((rel) => rel.type == "cover_art")
            .first
            .id;
        final MangaCoverModel? mangaCover = coverId == "" || coverId == null
            ? null
            : await MangaDexServices.getMangaCover(coverId: coverId);

        final String? chapterId =
            mangaDetails?.data!.attributes!.latestUploadedChapter;
        final MangaChapterModel? mangaChapter =
            chapterId == "" || chapterId == null
                ? null
                : await MangaDexServices.getMangaChapter(chapterId: chapterId);

        final MangaStatsModel mangaStats =
            await MangaDexServices.getMangaStats(mangaId: mangaId);

        final MyRandomMangaItemModel randomMangaItem = MyRandomMangaItemModel(
          mangaModel: mangaDetails,
          mangaCoverModel: mangaCover,
          mangaChapterModel: mangaChapter,
          mangaStatsModel: mangaStats,
        );

        myRandomMangaList.add(randomMangaItem);
      }

      mangaRandomFetchState = FetchState.success;
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
