import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_model.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/manga_details_provider.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';
import 'package:flutter_manga_app_test/views/screens/manga/read_manga_screen.dart';
import 'package:provider/provider.dart';

class MangaDetailsScreen extends StatefulWidget {
  final Map<String, dynamic>? mangaDetails;

  const MangaDetailsScreen({
    super.key,
    this.mangaDetails,
  });

  @override
  State<MangaDetailsScreen> createState() => _MangaDetailsScreenState();
}

class _MangaDetailsScreenState extends State<MangaDetailsScreen> {
  bool hasTheme = false;
  bool hasGenre = false;
  bool hasFormat = false;
  String? demographic;
  List<Tag>? tags;
  List<String>? altTitleList;

  @override
  void initState() {
    final provider = Provider.of<MangaDetailsProvider>(context, listen: false);

    provider.getMangaAuthor(authorId: widget.mangaDetails?["mangaAuthorId"]);
    provider.getMangaChapterFeed(
        mangaId: widget.mangaDetails?["mangaDetail"].id);
    provider.favCheck(
      mangaId: widget.mangaDetails?["mangaDetail"].id,
      mangaTitle: widget.mangaDetails?["mangaDetail"].attributes.title.en,
    );

    tags = widget.mangaDetails?["mangaDetail"].attributes?.tags ?? [];
    for (Tag tag in tags!) {
      if (tag.attributes!.group!.toLowerCase() == "theme") hasTheme = true;
      if (tag.attributes!.group!.toLowerCase() == "genre") hasGenre = true;
      if (tag.attributes!.group!.toLowerCase() == "format") hasFormat = true;
    }

    demographic =
        widget.mangaDetails?["mangaDetail"].attributes.publicationDemographic;

    altTitleList = provider
        .getAltTitles(widget.mangaDetails?["mangaDetail"].attributes.altTitles);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 2 / 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.network(
                widget.mangaDetails!["mangaCoverUrl"],
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(.15),
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Consumer<MangaDetailsProvider>(
                      builder: (context, state, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.mangaDetails?["mangaDetail"].attributes
                                      .title.en ??
                                  "",
                              style: Theme.of(context).textTheme.titleLarge,
                              maxLines: 7,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              state.fetchState == FetchState.loading
                                  ? "Loading author..."
                                  : state.mangaAuthorModel?.data.attributes
                                          .name ??
                                      "",
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.mangaDetails!['mangaStatsId'].rating
                                              .average ==
                                          10
                                      ? "10"
                                      : widget.mangaDetails!['mangaStatsId']
                                          .rating.average
                                          .toString()
                                          .substring(0, 3),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          child: Image.network(
                            widget.mangaDetails!["mangaCoverUrl"],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                Provider.of<MangaDetailsProvider>(
                                  context,
                                  listen: false,
                                ).toggleFavourite(
                                  context,
                                  mangaId:
                                      widget.mangaDetails!["mangaDetail"].id,
                                  mangaTitle: widget
                                      .mangaDetails!["mangaDetail"]
                                      .attributes
                                      .title
                                      .en,
                                );
                              },
                              icon: Consumer<MangaDetailsProvider>(
                                  builder: (context, state, _) {
                                return Icon(
                                  state.isFavourite
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_outline_rounded,
                                  color: Colors.pink,
                                );
                              }),
                            ),
                            IconButton(
                              onPressed: Provider.of<MangaDetailsProvider>(
                                context,
                                listen: false,
                              ).toggleLike,
                              icon: Consumer<MangaDetailsProvider>(
                                  builder: (context, state, _) {
                                return Icon(
                                  state.isLiked
                                      ? Icons.thumb_up
                                      : Icons.thumb_up_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                );
                              }),
                            ),
                            IconButton(
                              onPressed: Provider.of<MangaDetailsProvider>(
                                context,
                                listen: false,
                              ).toggleDisike,
                              icon: Consumer<MangaDetailsProvider>(
                                  builder: (context, state, _) {
                                return Icon(
                                  state.isDisliked
                                      ? Icons.thumb_down
                                      : Icons.thumb_down_outlined,
                                  color: Colors.grey,
                                );
                              }),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Synopsis",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.mangaDetails?["mangaDetail"].attributes.title.en ??
                          "",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.mangaDetails?["mangaDetail"].attributes.description
                              .en ??
                          "No Description",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              hasTheme
                  ? Text(
                      "THEMES",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  : const SizedBox(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    for (Tag tag in tags!)
                      if (tag.attributes!.group!.toLowerCase() == "theme")
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(tag.attributes!.name!.en ?? ""),
                          ),
                        ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              hasGenre
                  ? Text(
                      "GENRES",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  : const SizedBox(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    for (Tag tag in tags!)
                      if (tag.attributes!.group!.toLowerCase() == "genre")
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(tag.attributes!.name!.en ?? ""),
                          ),
                        ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              hasFormat
                  ? Text(
                      "FORMATS",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  : const SizedBox(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    for (Tag tag in tags!)
                      if (tag.attributes!.group!.toLowerCase() == "format")
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(tag.attributes!.name!.en ?? ""),
                          ),
                        ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  altTitleList!.isEmpty
                      ? const SizedBox()
                      : Text(
                          "ALT TITLES",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                  for (String title in altTitleList!) Text(title),
                ],
              ),
              const SizedBox(height: 16),
              demographic != ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "DEMOGRAPHIC",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(demographic?.toUpperCase() ?? "-"),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "RATING",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    widget.mangaDetails?["mangaDetail"].attributes.contentRating
                            .toString()
                            .split(".")
                            .last
                            .toUpperCase() ??
                        "-",
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Consumer<MangaDetailsProvider>(
                builder: (context, state, _) {
                  final chapters = state.mangaChapterFeedModel?.data ?? [];

                  return ElevatedButton(
                    onPressed: chapters.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReadMangaScreen(
                                  chapterData: chapters,
                                ),
                              ),
                            );
                          },
                    child: chapters.isEmpty
                        ? const Text("No chapter available")
                        : state.chapterFetchState == FetchState.loading
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                state.mangaChapterFeedModel?.data.length == 1
                                    ? "Read Chapter"
                                    : "Read First Chapter",
                              ),
                  );
                },
              ),
              Consumer<MangaDetailsProvider>(
                builder: (context, state, _) {
                  final chapters = state.mangaChapterFeedModel?.data ?? [];
                  final totalChapters =
                      state.mangaChapterFeedModel?.data.length ?? 0;

                  return totalChapters == 1
                      ? const SizedBox()
                      : Container(
                          constraints: BoxConstraints(
                            maxHeight: totalChapters == 0
                                ? 0
                                : MediaQuery.of(context).size.height / 2,
                          ),
                          child: ListView(
                            padding: const EdgeInsets.only(bottom: 20),
                            children: <Widget>[
                              for (int data = 0; data < totalChapters; data++)
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          chapters[data]
                                              .attributes
                                              .chapter
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        const SizedBox(width: 16),
                                        Flexible(
                                          child: Text(
                                            chapters[data].attributes.title !=
                                                    ""
                                                ? chapters[data]
                                                    .attributes
                                                    .title
                                                : "Chapter ${chapters[data].attributes.chapter.toString()}",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
