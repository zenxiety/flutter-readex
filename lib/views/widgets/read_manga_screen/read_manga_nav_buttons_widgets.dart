import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/models/responses/manga_chapter_feed_model.dart';
import 'package:flutter_manga_app_test/providers/read_manga_provider.dart';
import 'package:provider/provider.dart';

class NextButton extends StatelessWidget {
  final List<Datum> chapterData;

  const NextButton({super.key, required this.chapterData});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReadMangaProvider>(builder: (context, state, _) {
      return ElevatedButton(
        onPressed: () {
          state.flushManga();
          state.nextChapter(
            chapterData[++state.chapterIndex].id,
          );
        },
        child: const Text("NEXT"),
      );
    });
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        final provider = Provider.of<ReadMangaProvider>(
          context,
          listen: false,
        );
        provider.closeReadPage();

        Navigator.pop(context);
      },
      child: const Text("HOME"),
    );
  }
}

class PrevButton extends StatelessWidget {
  final List<Datum> chapterData;

  const PrevButton({super.key, required this.chapterData});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReadMangaProvider>(builder: (context, state, _) {
      return ElevatedButton(
        onPressed: state.chapterIndex <= 0
            ? null
            : () {
                state.flushManga();
                state.nextChapter(
                  chapterData[--state.chapterIndex].id,
                );
              },
        child: const Text("PREV"),
      );
    });
  }
}
