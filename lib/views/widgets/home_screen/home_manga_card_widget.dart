import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/providers/home_provider.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';
import 'package:flutter_manga_app_test/views/screens/manga_details_screen.dart';
import 'package:provider/provider.dart';

class MangaCard extends StatelessWidget {
  final Map<String, dynamic> mangaDetails;
  final bool isList;

  const MangaCard(
      {super.key, required this.mangaDetails, required this.isList});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, state, _) {
      return InkWell(
        onTap: () {
          state.mangalistFetchState == FetchState.success
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MangaDetailsScreen(
                      mangaDetails: mangaDetails,
                    ),
                  ),
                )
              : null;
        },
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: Colors.grey.shade800,
          child: (isList && state.mangalistFetchState == FetchState.success) ||
                  (!isList && state.mangaRandomFetchState == FetchState.success)
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
              : state.mangalistFetchState == FetchState.loading ||
                      state.mangaRandomFetchState == FetchState.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Text("Error"),
        ),
      );
    });
  }
}
