import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/models/response_models/manga_chapter_feed_model.dart';
import 'package:flutter_manga_app_test/providers/read_manga_provider.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';
import 'package:flutter_manga_app_test/views/widgets/read_manga_screen/read_manga_nav_buttons_widgets.dart';
import 'package:provider/provider.dart';

class ReadMangaScreen extends StatefulWidget {
  final List<Datum>? chapterData;

  const ReadMangaScreen({super.key, this.chapterData});

  @override
  State<ReadMangaScreen> createState() => _ReadMangaScreenState();
}

class _ReadMangaScreenState extends State<ReadMangaScreen> {
  @override
  void initState() {
    final provider = Provider.of<ReadMangaProvider>(
      context,
      listen: false,
    );
    provider.scrollController = ScrollController();
    provider.getMangaPages(
        chapterId: widget.chapterData![provider.chapterIndex].id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: RawScrollbar(
        thumbColor: Theme.of(context).colorScheme.primary,
        radius: const Radius.circular(8),
        thickness: 4,
        controller: Provider.of<ReadMangaProvider>(context, listen: false)
            .scrollController,
        child: ListView(
          controller: Provider.of<ReadMangaProvider>(context, listen: false)
              .scrollController,
          children: <Widget>[
            const SizedBox(height: 40),
            Consumer<ReadMangaProvider>(builder: (context, state, _) {
              final String chapterNo =
                  widget.chapterData?[state.chapterIndex].attributes.chapter ??
                      "";

              return Text(
                "Chapter $chapterNo",
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              );
            }),
            Consumer<ReadMangaProvider>(builder: (context, state, _) {
              final String chapterNo =
                  widget.chapterData?[state.chapterIndex].attributes.chapter ??
                      '';

              final String chapterTitle =
                  widget.chapterData?[state.chapterIndex].attributes.title ??
                      '';

              return Text(
                chapterTitle != "" ? chapterTitle : "Chapter $chapterNo",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              );
            }),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PrevButton(chapterData: widget.chapterData!),
                  const HomeButton(),
                  NextButton(chapterData: widget.chapterData!)
                ],
              ),
            ),
            Consumer<ReadMangaProvider>(builder: (context, state, _) {
              final String chapterId =
                  state.mangaPagesModel?.chapter.hash ?? "";
              List<String> images =
                  state.mangaPagesModel?.chapter.dataSaver ?? [];

              return state.fetchState == FetchState.loading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Loading chapter pages...",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        final String imageUrl =
                            "https://uploads.mangadex.org/data-saver/$chapterId/${images[index]}";

                        return Image.network(
                          imageUrl,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Text(
                              "Error fetching this manga page, please wait for a moment.",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall,
                            );
                          },
                        );
                      },
                    );
            }),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PrevButton(chapterData: widget.chapterData!),
                  const HomeButton(),
                  NextButton(chapterData: widget.chapterData!)
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Provider.of<ReadMangaProvider>(
            context,
            listen: false,
          ).scrollController!.animateTo(
                0,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
              );
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
        ),
        child: const Icon(Icons.keyboard_double_arrow_up_rounded),
      ),
    );
  }
}
