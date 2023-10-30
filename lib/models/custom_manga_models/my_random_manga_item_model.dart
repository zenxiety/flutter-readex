import 'package:flutter_manga_app_test/models/response_models/manga_chapter_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_cover_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_model.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_stats_model.dart';

class MyRandomMangaItemModel {
  MangaModel? mangaModel;
  MangaCoverModel? mangaCoverModel;
  MangaChapterModel? mangaChapterModel;
  MangaStatsModel? mangaStatsModel;

  MyRandomMangaItemModel({
    required this.mangaModel,
    required this.mangaCoverModel,
    required this.mangaChapterModel,
    required this.mangaStatsModel,
  });
}
