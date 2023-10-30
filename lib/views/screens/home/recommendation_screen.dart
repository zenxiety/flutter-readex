import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/providers/profile_provider.dart';
import 'package:flutter_manga_app_test/providers/recommendation_provider.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';
import 'package:flutter_manga_app_test/utils/constants/home_card_category.dart';
import 'package:flutter_manga_app_test/views/widgets/home_screen/home_manga_card_widget.dart';
import 'package:provider/provider.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  RecommendationProvider? provider;

  @override
  void initState() {
    provider = Provider.of<RecommendationProvider>(context, listen: false);
    provider!.searchController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    provider!.searchController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Consumer2<RecommendationProvider, ProfileProvider>(
              builder: (context, state1, state2, _) {
                return Form(
                  key: state1.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: state1.searchController,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: "Search Manga",
                          ),
                          validator: (value) => state1.validateSearch(value),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          OutlinedButton(
                            onPressed: state1.mangaSearchFetchState ==
                                    FetchState.loading
                                ? null
                                : state1.searchManga,
                            child: state1.mangaSearchFetchState ==
                                    FetchState.loading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text("Search"),
                          ),
                          ElevatedButton(
                            onPressed: state1.mangaRecommendationFetchState ==
                                        FetchState.loading ||
                                    state2.favMangaList.isEmpty
                                ? null
                                : state1.recommendManga,
                            child: state1.mangaRecommendationFetchState ==
                                    FetchState.loading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    state2.favMangaList.isEmpty
                                        ? "Add favourite mangas to get recommendations"
                                        : "Recommend Me!",
                                    style: state2.favMangaList.isEmpty
                                        ? const TextStyle(fontSize: 12)
                                        : null,
                                  ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),

            // RECOMMENDATION
            Consumer<RecommendationProvider>(
              builder: (context, state, _) {
                return state.mangaRecommendationFetchState == FetchState.success
                    ? Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Manga Recommendation",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Handpicked Just for You!",
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 9 / 16,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.totalRecommendedManga,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> mangaDetails = {
                                "mangaDetail": null,
                                "mangaCoverUrl": null,
                                "mangaAuthorId": null,
                                "mangaChapterData": null,
                                "mangaStatsId": null,
                              };

                              if (state.mangaRecommendationFetchState ==
                                  FetchState.success) {
                                mangaDetails["mangaDetail"] = state
                                    .mangaRecommendationList[index]
                                    .mangaSearchModel!
                                    .data![0];
                                mangaDetails["mangaCoverUrl"] =
                                    state.generateCover(
                                  mangaId: state
                                      .mangaRecommendationList[index]
                                      .mangaCoverModel!
                                      .data
                                      .relationships[0]
                                      .id,
                                  mangaCoverId: state
                                      .mangaRecommendationList[index]
                                      .mangaCoverModel!
                                      .data
                                      .attributes
                                      .fileName,
                                );
                                mangaDetails["mangaChapterData"] = state
                                    .mangaRecommendationList[index]
                                    .mangaChapterModel
                                    ?.data;
                                mangaDetails["mangaStatsId"] = state
                                    .mangaRecommendationList[index]
                                    .mangaStatsModel!
                                    .statistics
                                    .mangaId;

                                final authorId = state
                                    .mangaRecommendationList[index]
                                    .mangaSearchModel!
                                    .data![0]
                                    .relationships!
                                    .where(
                                        (element) => element.type == "author")
                                    .first
                                    .id;
                                mangaDetails["mangaAuthorId"] = authorId;
                              }

                              return Container(
                                margin: const EdgeInsets.fromLTRB(4, 0, 4, 16),
                                width:
                                    MediaQuery.of(context).size.width * 2 / 3,
                                child: MangaCard(
                                  mangaDetails: mangaDetails,
                                  category: CardCategory.recommendation,
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : state.mangaRecommendationFetchState == FetchState.loading
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 200),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox();
              },
            ),

            // SEARCH RESULT
            Consumer<RecommendationProvider>(
              builder: (context, state, _) {
                return state.mangaSearchFetchState == FetchState.success
                    ? Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              "Manga Search Result",
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 9 / 16,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> mangaDetails = {
                                "mangaDetail": null,
                                "mangaCoverUrl": null,
                                "mangaAuthorId": null,
                                "mangaChapterData": null,
                                "mangaStatsId": null,
                              };

                              if (state.mangaSearchFetchState ==
                                  FetchState.success) {
                                mangaDetails["mangaDetail"] = state
                                    .mangaSearchList[index]
                                    .mangaSearchModel!
                                    .data![0];
                                mangaDetails["mangaCoverUrl"] =
                                    state.generateCover(
                                  mangaId: state
                                      .mangaSearchList[index]
                                      .mangaCoverModel!
                                      .data
                                      .relationships[0]
                                      .id,
                                  mangaCoverId: state
                                      .mangaSearchList[index]
                                      .mangaCoverModel!
                                      .data
                                      .attributes
                                      .fileName,
                                );
                                mangaDetails["mangaChapterData"] = state
                                    .mangaSearchList[index]
                                    .mangaChapterModel
                                    ?.data;
                                mangaDetails["mangaStatsId"] = state
                                    .mangaSearchList[index]
                                    .mangaStatsModel!
                                    .statistics
                                    .mangaId;

                                final authorId = state.mangaSearchList[index]
                                    .mangaSearchModel!.data![0].relationships!
                                    .where(
                                        (element) => element.type == "author")
                                    .first
                                    .id;
                                mangaDetails["mangaAuthorId"] = authorId;
                              }

                              return Container(
                                margin: const EdgeInsets.fromLTRB(4, 0, 4, 16),
                                width:
                                    MediaQuery.of(context).size.width * 2 / 3,
                                child: MangaCard(
                                  mangaDetails: mangaDetails,
                                  category: CardCategory.search,
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : state.mangaSearchFetchState == FetchState.loading
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 200),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
