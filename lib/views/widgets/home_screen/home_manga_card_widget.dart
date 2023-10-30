import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/home_provider.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/recommendation_provider.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';
import 'package:flutter_manga_app_test/utils/constants/home_card_category.dart';
import 'package:flutter_manga_app_test/views/screens/manga/manga_details_screen.dart';
import 'package:provider/provider.dart';

class MangaCard extends StatelessWidget {
  final Map<String, dynamic> mangaDetails;
  final CardCategory category;

  const MangaCard(
      {super.key, required this.mangaDetails, required this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, RecommendationProvider>(
        builder: (context, state1, state2, _) {
      return InkWell(
        onTap: (category == CardCategory.latest &&
                    state1.mangalistFetchState != FetchState.success) ||
                (category == CardCategory.random &&
                    state1.mangaRandomFetchState != FetchState.success) ||
                (category == CardCategory.recommendation &&
                    state2.mangaRecommendationFetchState !=
                        FetchState.success) ||
                (category == CardCategory.search &&
                    state2.mangaSearchFetchState != FetchState.success)
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MangaDetailsScreen(
                      mangaDetails: mangaDetails,
                    ),
                  ),
                );
              },
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: Colors.grey.shade800,
          child: (category == CardCategory.latest &&
                      state1.mangalistFetchState == FetchState.success) ||
                  (category == CardCategory.random &&
                      state1.mangaRandomFetchState == FetchState.success) ||
                  (category == CardCategory.recommendation &&
                      state2.mangaRecommendationFetchState ==
                          FetchState.success) ||
                  (category == CardCategory.search &&
                      state2.mangaSearchFetchState == FetchState.success)
              ? Column(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.network(
                          mangaDetails['mangaCoverUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            mangaDetails['mangaDetail'].attributes.title.en ??
                                "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    mangaDetails['mangaChapterData'] == null
                                        ? "No Chapter"
                                        : mangaDetails['mangaChapterData']
                                                    .attributes
                                                    .chapter !=
                                                ""
                                            ? "Ch. ${mangaDetails['mangaChapterData'].attributes.chapter}"
                                            : "Oneshot",
                                  ),
                                  const SizedBox(height: 2),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    mangaDetails['mangaStatsId']
                                                .rating
                                                .average ==
                                            10
                                        ? "10"
                                        : mangaDetails['mangaStatsId']
                                            .rating
                                            .average
                                            .toString()
                                            .substring(0, 3),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : state1.mangalistFetchState == FetchState.loading ||
                      state1.mangaRandomFetchState == FetchState.loading ||
                      state2.mangaRecommendationFetchState ==
                          FetchState.loading ||
                      state2.mangaSearchFetchState == FetchState.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Text("Error fetching manga information"),
        ),
      );
    });
  }
}
