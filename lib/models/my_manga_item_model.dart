import 'package:flutter_manga_app_test/models/responses/manga_chapter_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_cover_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_stats_model.dart';

class MyMangaItemModel {
  MangaModel mangaModel;
  MangaCoverModel mangaCoverModel;
  MangaChapterModel mangaChapterModel;
  MangaStatsModel mangaStatsModel;

  MyMangaItemModel({
    required this.mangaModel,
    required this.mangaCoverModel,
    required this.mangaChapterModel,
    required this.mangaStatsModel,
  });
}
