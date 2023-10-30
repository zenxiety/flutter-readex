import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/providers/profile_provider.dart';
import 'package:flutter_manga_app_test/utils/constants/fetch_state.dart';
import 'package:flutter_manga_app_test/views/screens/manga/manga_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    final ProfileProvider provider =
        Provider.of<ProfileProvider>(context, listen: false);
    provider.getUserInfo();
    provider.getFavouriteMangas();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            Text(
              "My Profile",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsetsDirectional.symmetric(vertical: 10),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Username"),
                          Text("Email"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Consumer<ProfileProvider>(
                            builder: (context, state, _) {
                              return Text(
                                state.preferences?.getString('username') ?? "",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w200,
                                ),
                              );
                            },
                          ),
                          Consumer<ProfileProvider>(
                            builder: (context, state, _) {
                              return Text(
                                state.preferences?.getString('email') ?? "",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w200,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Consumer<ProfileProvider>(
                  builder: (context, state, _) {
                    return OutlinedButton(
                      onPressed: state.preferences == null
                          ? null
                          : () => state.signOut(context),
                      child: const Text("Sign Out"),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Favourite Manga",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Consumer<ProfileProvider>(builder: (context, state, _) {
                  return IconButton(
                    onPressed: state.favFetchState == FetchState.loading
                        ? null
                        : () =>
                            Provider.of<ProfileProvider>(context, listen: false)
                                .getFavouriteMangas(),
                    color: Theme.of(context).colorScheme.primary,
                    icon: const Icon(Icons.refresh),
                  );
                }),
              ],
            ),
            Consumer<ProfileProvider>(
              builder: (context, state, _) {
                return state.favFetchState == FetchState.loading
                    ? const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : state.favMangaList.isEmpty
                        ? Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Text("No favourite manga yet"),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.favFetchState == FetchState.success
                                ? state.favMangaList.length
                                : 4,
                            separatorBuilder: (context, _) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              Map<String, dynamic> mangaDetails = {
                                "mangaDetail": null,
                                "mangaCoverUrl": null,
                                "mangaAuthorId": null,
                                "mangaChapterData": null,
                                "mangaStatsId": null,
                              };

                              if (state.favFetchState == FetchState.success) {
                                mangaDetails["mangaDetail"] =
                                    state.favMangaList[index].mangaModel?.data;
                                mangaDetails["mangaCoverUrl"] =
                                    "https://uploads.mangadex.org/covers/${state.favMangaList[index].mangaCoverModel!.data.relationships[0].id}/${state.favMangaList[index].mangaCoverModel!.data.attributes.fileName}.256.jpg";
                                mangaDetails["mangaChapterData"] = state
                                    .favMangaList[index]
                                    .mangaChapterModel
                                    ?.data;
                                mangaDetails["mangaStatsId"] = state
                                    .favMangaList[index]
                                    .mangaStatsModel!
                                    .statistics
                                    .mangaId;

                                final authorId = state.favMangaList[index]
                                    .mangaModel!.data!.relationships!
                                    .where(
                                        (element) => element.type == "author")
                                    .first
                                    .id;
                                mangaDetails["mangaAuthorId"] = authorId;
                              }
                              return InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MangaDetailsScreen(
                                      mangaDetails: mangaDetails,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Image.network(
                                          mangaDetails['mangaCoverUrl'],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              4 /
                                              5,
                                          fit: BoxFit.fitWidth,
                                          opacity:
                                              const AlwaysStoppedAnimation(.2),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              3 /
                                              5,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: <Color>[
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                Colors.transparent,
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            mangaDetails['mangaDetail']
                                                .attributes
                                                .title
                                                .en,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
              },
            ),
          ],
        ),
      ),
    );
  }
}
