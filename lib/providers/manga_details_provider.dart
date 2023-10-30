import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_author_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_chapter_feed_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_model.dart';
import 'package:flutter_manga_app_test/services/mangadex_services.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MangaDetailsProvider with ChangeNotifier {
  MangaModel? mangaModel;
  MangaAuthorModel? mangaAuthorModel;
  MangaChapterFeedModel? mangaChapterFeedModel;

  FetchState fetchState = FetchState.initial;
  FetchState chapterFetchState = FetchState.initial;

  void getMangaDetails({required String mangaId}) async {
    try {
      fetchState = FetchState.loading;

      final result = await MangaDexServices.getMangaDetails(mangaId: mangaId);

      mangaModel = result;

      fetchState = FetchState.success;
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }

  void getMangaAuthor({required String authorId}) async {
    mangaAuthorModel = null;

    try {
      fetchState = FetchState.loading;

      final result = await MangaDexServices.getMangaAuthor(authorId: authorId);

      mangaAuthorModel = result;

      fetchState = FetchState.success;
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }

  void getMangaChapterFeed({required String mangaId}) async {
    mangaChapterFeedModel = null;

    try {
      chapterFetchState = FetchState.loading;

      final result =
          await MangaDexServices.getMangaChapterFeed(mangaId: mangaId);

      mangaChapterFeedModel = result;

      chapterFetchState = FetchState.success;
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }

  List<String> getAltTitles(List<AltTitle> altTitleList) {
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

  void favCheck({required String mangaId, required String mangaTitle}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final String favsId = preferences.getString("favsId")!;
    final String favsTitle = preferences.getString("favsTitle")!;

    isFavourite = favsId.contains(mangaId) || (favsTitle.contains(mangaTitle))
        ? true
        : false;
    notifyListeners();
  }

  void toggleFavourite(
    BuildContext context, {
    required String mangaId,
    required String mangaTitle,
  }) async {
    isFavourite = !isFavourite;
    notifyListeners();

    late String message;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (isFavourite) {
      String favsId = preferences.getString("favsId")!;
      String favsTitle = preferences.getString("favsTitle")!;

      String newFavsId = favsId + mangaId;
      String newFavsTitle = favsTitle + mangaTitle;

      preferences.setString("favsId", "$newFavsId|");
      preferences.setString("favsTitle", "$newFavsTitle|");

      message = "Manga added to favourites";
    } else {
      String favsId = preferences.getString("favsId") ?? "";
      String favsTitle = preferences.getString("favsTitle") ?? "";

      String newFavsId = favsId.replaceFirst("$mangaId|", "");
      String newFavsTitle = favsTitle.replaceFirst("$mangaTitle|", "");

      preferences.setString("favsId", newFavsId);
      preferences.setString("favsTitle", newFavsTitle);

      message = "Manga removed from favourites";
    }

    notifyListeners();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          action: SnackBarAction(label: "OK", onPressed: () {}),
        ),
      );
    }
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
