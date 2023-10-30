import 'package:flutter_manga_app_test/models/response_models/manga_chapter_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_cover_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_search_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_stats_model.dart';

class MyMangaSearchModel {
  MangaSearchModel? mangaSearchModel;
  MangaCoverModel? mangaCoverModel;
  MangaChapterModel? mangaChapterModel;
  MangaStatsModel? mangaStatsModel;

  MyMangaSearchModel({
    required this.mangaSearchModel,
    required this.mangaCoverModel,
    required this.mangaChapterModel,
    required this.mangaStatsModel,
  });
}
