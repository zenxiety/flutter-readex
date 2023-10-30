import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/home_provider.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';
import 'package:flutter_manga_app_test/utils/constants/home_card_category.dart';
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

    Future.delayed(Duration.zero, () {
      homeProvider.getMangaList(page: 0);
      homeProvider.getRandomManga();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            // LATEST MANGA
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Text(
                    "Latest Manga",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Your Gateway to the Freshest Manga Universes!",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
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
                    Map<String, dynamic> mangaDetails = {
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
                          "https://uploads.mangadex.org/covers/${state.myMangaListModel[index].mangaCoverModel!.data.relationships[0].id}/${state.myMangaListModel[index].mangaCoverModel!.data.attributes.fileName}.256.jpg";
                      mangaDetails["mangaChapterData"] =
                          state.myMangaListModel[index].mangaChapterModel!.data;
                      mangaDetails["mangaStatsId"] = state
                          .myMangaListModel[index]
                          .mangaStatsModel!
                          .statistics
                          .mangaId;

                      final authorId = state
                          .mangaListModel?.data[index].relationships
                          .where((element) =>
                              element.type!.toLowerCase() == "author")
                          .first
                          .id;
                      mangaDetails["mangaAuthorId"] = authorId;
                    }

                    return MangaCard(
                      mangaDetails: mangaDetails,
                      category: CardCategory.latest,
                    );
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Consumer<HomeProvider>(
                builder: (context, state, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      state.currentMainPage != 0
                          ? ElevatedButton(
                              onPressed: state.mangalistFetchState ==
                                      FetchState.loading
                                  ? null
                                  : () => state.goToPrevPage(),
                              child: const Text("Prev"),
                            )
                          : const SizedBox(),
                      ElevatedButton(
                        onPressed:
                            state.mangalistFetchState == FetchState.loading
                                ? null
                                : () => state.goToNextPage(),
                        child: const Text("Next"),
                      ),
                    ],
                  );
                },
              ),
            ),
            // RANDOM MANGA
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Text(
                    "Discover Manga",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Where Every Read is a New Adventure!",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Consumer<HomeProvider>(
              builder: (context, state, _) {
                return SizedBox(
                  height: 360,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.totalRandomManga,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> mangaDetails = {
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
                          category: CardCategory.random,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Center(
              child: Consumer<HomeProvider>(builder: (context, state, _) {
                return ElevatedButton(
                  onPressed: state.mangaRandomFetchState == FetchState.loading
                      ? null
                      : Provider.of<HomeProvider>(context, listen: false)
                          .getRandomManga,
                  child: state.mangaRandomFetchState == FetchState.loading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(),
                        )
                      : const Text("Refresh"),
                );
              }),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
