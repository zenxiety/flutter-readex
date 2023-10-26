import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/models/responses/manga_list_model.dart';
import 'package:flutter_manga_app_test/providers/home_provider.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';
import 'package:flutter_manga_app_test/views/widgets/home_screen/home_section_title_widget.dart';
import 'package:flutter_manga_app_test/views/widgets/home_screen/home_manga_card_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    homeProvider.getMangaList(page: 0);
    homeProvider.getRandomManga();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: <Widget>[
          // LATEST MANGA
          const SectionTitle(title: "Latest Manga"),
          Consumer<HomeProvider>(
            builder: (context, state, _) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 9 / 16,
                ),
                itemCount: state.mangalistFetchState == FetchState.success
                    ? state.mangaListModel!.data.length
                    : 8,
                itemBuilder: (context, index) {
                  late Map<String, dynamic> mangaDetails = {
                    "mangaDetail": null,
                    "mangaCoverUrl": null,
                    "mangaAuthorId": null,
                    "mangaChapterData": null,
                    "mangaStatsId": null,
                  };

                  if (state.mangalistFetchState == FetchState.success &&
                      state.myMangaListModel.isNotEmpty) {
                    mangaDetails["mangaDetail"] =
                        state.mangaListModel?.data[index];
                    mangaDetails["mangaCoverUrl"] =
                        "https://uploads.mangadex.org/covers/${state.myMangaListModel[index].mangaCoverModel.data.relationships[0].id}/${state.myMangaListModel[index].mangaCoverModel.data.attributes.fileName}.256.jpg";
                    mangaDetails["mangaChapterData"] =
                        state.myMangaListModel[index].mangaChapterModel.data;
                    mangaDetails["mangaStatsId"] = state.myMangaListModel[index]
                        .mangaStatsModel.statistics.mangaId;

                    final authorId = state
                        .mangaListModel?.data[index].relationships
                        .where((element) =>
                            element.type == RelationshipType.AUTHOR)
                        .first
                        .id;
                    mangaDetails["mangaAuthorId"] = authorId;
                  }

                  return MangaCard(
                    mangaDetails: mangaDetails,
                    isList: true,
                  );
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Consumer<HomeProvider>(builder: (context, state, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  state.currentMainPage != 0
                      ? ElevatedButton(
                          onPressed: () => state.goToPrevPage(),
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white),
                          ),
                          child: const Text(
                            "Prev",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      : const SizedBox(),
                  ElevatedButton(
                    onPressed: () => state.goToNextPage(),
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              );
            }),
          ),

          // RANDOM MANGA
          const SectionTitle(title: "Discover Manga"),
          Consumer<HomeProvider>(
            builder: (context, state, _) {
              return SizedBox(
                height: 360,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.totalRandomManga,
                  itemBuilder: (context, index) {
                    late Map<String, dynamic> mangaDetails = {
                      "mangaDetail": null,
                      "mangaCoverUrl": null,
                      "mangaAuthorId": null,
                      "mangaChapterData": null,
                      "mangaStatsId": null,
                    };

                    if (state.mangaRandomFetchState == FetchState.success) {
                      mangaDetails["mangaDetail"] =
                          state.myRandomMangaList[index].mangaModel?.data;
                      mangaDetails["mangaCoverUrl"] =
                          "https://uploads.mangadex.org/covers/${state.myRandomMangaList[index].mangaCoverModel!.data.relationships[0].id}/${state.myRandomMangaList[index].mangaCoverModel!.data.attributes.fileName}.256.jpg";
                      mangaDetails["mangaChapterData"] = state
                          .myRandomMangaList[index].mangaChapterModel?.data;
                      mangaDetails["mangaStatsId"] = state
                          .myRandomMangaList[index]
                          .mangaStatsModel!
                          .statistics
                          .mangaId;

                      final authorId = state.myRandomMangaList[index]
                          .mangaModel!.data!.relationships!
                          .where((element) => element.type == "author")
                          .first
                          .id;
                      mangaDetails["mangaAuthorId"] = authorId;
                    }

                    return Container(
                      margin: const EdgeInsets.fromLTRB(4, 0, 4, 16),
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      child: MangaCard(
                        mangaDetails: mangaDetails,
                        isList: false,
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
