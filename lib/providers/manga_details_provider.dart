import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/models/responses/manga_author_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_chapter_feed_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_list_model.dart';
import 'package:flutter_manga_app_test/services/mangadex_services.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';

class MangaDetailsProvider with ChangeNotifier {
  FetchState fetchState = FetchState.initial;
  MangaModel? mangaModel;
  MangaAuthorModel? mangaAuthorModel;
  MangaChapterFeedModel? mangaChapterFeedModel;

  void getMangaDetails(String chapterId) async {
    try {
      fetchState = FetchState.loading;

      final result = await MangaDexServices.getMangaDetails(chapterId);

      mangaModel = result;

      fetchState = FetchState.success;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  void getMangaAuthor(String authorId) async {
    mangaAuthorModel = null;

    try {
      fetchState = FetchState.loading;

      final result = await MangaDexServices.getMangaAuthor(authorId);

      mangaAuthorModel = result;

      fetchState = FetchState.success;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  void getMangaChapterFeed(String mangaId) async {
    mangaChapterFeedModel = null;

    try {
      fetchState = FetchState.loading;

      final result = await MangaDexServices.getMangaChapterFeed(mangaId);

      mangaChapterFeedModel = result;

      fetchState = FetchState.success;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  List<String> getAltTitles(List<ListAltTitle> altTitleList) {
    List<String> altTitles = [];
    for (int i = 0; i < altTitleList.length; i++) {
      altTitles.add(altTitleList[i].ar ?? "");
      altTitles.add(altTitleList[i].en ?? "");
      altTitles.add(altTitleList[i].esLa ?? "");
      altTitles.add(altTitleList[i].fr ?? "");
      altTitles.add(altTitleList[i].he ?? "");
      altTitles.add(altTitleList[i].it ?? "");
      altTitles.add(altTitleList[i].ja ?? "");
      altTitles.add(altTitleList[i].jaRo ?? "");
      altTitles.add(altTitleList[i].ko ?? "");
      altTitles.add(altTitleList[i].ms ?? "");
      altTitles.add(altTitleList[i].pl ?? "");
      altTitles.add(altTitleList[i].ptBr ?? "");
      altTitles.add(altTitleList[i].ru ?? "");
      altTitles.add(altTitleList[i].th ?? "");
      altTitles.add(altTitleList[i].tl ?? "");
      altTitles.add(altTitleList[i].tr ?? "");
      altTitles.add(altTitleList[i].tr ?? "");
      altTitles.add(altTitleList[i].uk ?? "");
      altTitles.add(altTitleList[i].vi ?? "");
      altTitles.add(altTitleList[i].zh ?? "");
      altTitles.add(altTitleList[i].zhHk ?? "");
      altTitles.add(altTitleList[i].zhRo ?? "");
    }

    return altTitles.where((title) => title.isNotEmpty).toList();
  }

  bool isFavourite = false;
  bool isLiked = false;
  bool isDisliked = false;

  void toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }

  void toggleLike() {
    isLiked = !isLiked;
    if (isDisliked) isDisliked = false;
    notifyListeners();
  }

  void toggleDisike() {
    isDisliked = !isDisliked;
    if (isLiked) isLiked = false;
    notifyListeners();
  }
}
