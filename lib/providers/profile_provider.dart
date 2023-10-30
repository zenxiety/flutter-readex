import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/models/custom_manga_models/my_favourite_manga_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_chapter_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_cover_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_stats_model.dart';
import 'package:flutter_manga_app_test/providers/home_builder_provider.dart';
import 'package:flutter_manga_app_test/services/mangadex_service.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  SharedPreferences? preferences;

  final List<MyFavouriteMangaModel> favMangaList = [];

  FetchState favFetchState = FetchState.initial;

  void getUserInfo() async {
    preferences = await SharedPreferences.getInstance();
    notifyListeners();
  }

  void signOut(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/signup',
      (route) => false,
    );

    Provider.of<HomeBuilderProvider>(context, listen: false).selectScreen(0);

    preferences!.remove("username");
    preferences!.remove("email");
    preferences!.remove("password");
    preferences!.remove("favsId");
    preferences!.remove("favsTitle");
    preferences!.setBool("logged", false);

    notifyListeners();
  }

  void getFavouriteMangas() async {
    preferences = await SharedPreferences.getInstance();
    final String favMangas = preferences!.getString("favsId")!;

    if (favMangas == "") {
      favMangaList.clear();
      notifyListeners();
      return;
    }

    try {
      favFetchState = FetchState.loading;
      notifyListeners();

      favMangaList.clear();
      final List<String> favMangaIds = [];
      favMangas.split("|").map((mangaId) => favMangaIds.add(mangaId)).toList();

      for (String mangaId in favMangaIds) {
        if (mangaId == "") continue;

        final MangaModel mangaModel =
            await MangaDexService.getMangaDetails(mangaId: mangaId);

        final String? coverId = mangaModel.data!.relationships!
            .where((element) => element.type == "cover_art")
            .first
            .id;
        final MangaCoverModel? mangaFavCover = coverId == null || coverId == ""
            ? null
            : await MangaDexService.getMangaCover(coverId: coverId);

        final String? chapterId =
            mangaModel.data!.attributes!.latestUploadedChapter;
        final MangaChapterModel? mangaFavChapter =
            chapterId == null || chapterId == ""
                ? null
                : await MangaDexService.getMangaChapter(chapterId: chapterId);

        final MangaStatsModel? mangaFavStats = mangaId == ""
            ? null
            : await MangaDexService.getMangaStats(mangaId: mangaId);

        final MyFavouriteMangaModel favMangaModel = MyFavouriteMangaModel(
          mangaModel: mangaModel,
          mangaCoverModel: mangaFavCover,
          mangaChapterModel: mangaFavChapter,
          mangaStatsModel: mangaFavStats,
        );

        favMangaList.add(favMangaModel);
        notifyListeners();
      }

      favFetchState = FetchState.success;
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
