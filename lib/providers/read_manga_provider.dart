import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/models/responses/manga_pages_model.dart';
import 'package:flutter_manga_app_test/services/mangadex_services.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';

class ReadMangaProvider with ChangeNotifier {
  MangaPagesModel? mangaPagesModel;
  FetchState fetchState = FetchState.initial;
  int chapterIndex = 0;

  ScrollController? scrollController;

  void getMangaPages(String chapterId) async {
    mangaPagesModel = null;

    try {
      fetchState = FetchState.loading;

      final result = await MangaDexServices.getMangaPages(chapterId);

      mangaPagesModel = result;

      fetchState = FetchState.success;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  void prevChapter(String chapterId) {
    getMangaPages(chapterId);
    notifyListeners();
  }

  void nextChapter(String chapterId) {
    getMangaPages(chapterId);
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
