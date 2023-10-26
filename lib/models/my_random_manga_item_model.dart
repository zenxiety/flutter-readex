import 'package:flutter_manga_app_test/models/responses/manga_chapter_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_cover_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_model.dart';
import 'package:flutter_manga_app_test/models/responses/manga_stats_model.dart';

class MyRandomMangaItemModel {
  MangaModel? mangaModel;
  MangaCoverModel? mangaCoverModel;
  MangaChapterModel? mangaChapterModel;
  MangaStatsModel? mangaStatsModel;

  MyRandomMangaItemModel({
    this.mangaModel,
    this.mangaCoverModel,
    this.mangaChapterModel,
    this.mangaStatsModel,
  });
}
