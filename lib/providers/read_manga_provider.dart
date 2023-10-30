import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_pages_model.dart';
import 'package:flutter_manga_app_test/services/mangadex_service.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';

class ReadMangaProvider with ChangeNotifier {
  MangaPagesModel? mangaPagesModel;
  FetchState fetchState = FetchState.initial;
  int chapterIndex = 0;

  ScrollController? scrollController;

  void getMangaPages({required String chapterId}) async {
    mangaPagesModel = null;

    try {
      fetchState = FetchState.loading;

      final result = await MangaDexService.getMangaPages(chapterId: chapterId);

      mangaPagesModel = result;

      fetchState = FetchState.success;
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }

  void prevChapter({required String chapterId}) {
    getMangaPages(chapterId: chapterId);
    notifyListeners();
  }

  void nextChapter({required String chapterId}) {
    getMangaPages(chapterId: chapterId);
    notifyListeners();
  }

  void flushManga() {
    fetchState = FetchState.initial;
    mangaPagesModel = null;
    notifyListeners();
  }

  void closeReadPage() {
    chapterIndex = 0;
    mangaPagesModel = null;
    notifyListeners();
  }
}
