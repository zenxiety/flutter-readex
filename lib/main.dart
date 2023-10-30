import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/home_builder_provider.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/home_provider.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/manga_details_provider.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/profile_provider.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/read_manga_provider.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/recommendation_provider.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/signup_provider.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/splash_provider.dart';
import 'package:flutter_manga_app_test/views/screens/auth/signup_screen.dart';
import 'package:flutter_manga_app_test/views/screens/home/home_screen.dart';
import 'package:flutter_manga_app_test/views/screens/home/home_screen_builder.dart';
import 'package:flutter_manga_app_test/views/screens/home/profile_screen.dart';
import 'package:flutter_manga_app_test/views/screens/home/recommendation_screen.dart';
import 'package:flutter_manga_app_test/views/screens/manga/read_manga_screen.dart';
import 'package:flutter_manga_app_test/views/screens/manga/manga_details_screen.dart';
import 'package:flutter_manga_app_test/views/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => HomeBuilderProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => RecommendationProvider()),
        ChangeNotifierProvider(create: (_) => MangaDetailsProvider()),
        ChangeNotifierProvider(create: (_) => ReadMangaProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.dark(
            primary: Colors.blueAccent.shade700,
            secondary: Colors.white,
            background: Colors.black,
            brightness: Brightness.dark,
            primaryContainer: Colors.grey.shade900,
            secondaryContainer: Colors.grey.shade600,
          ),
          textTheme: TextTheme(
            titleLarge: GoogleFonts.bebasNeue(
                fontSize: 36,
                letterSpacing: 1,
                color: Colors.blueAccent.shade700),
            titleMedium: GoogleFonts.bebasNeue(
                fontSize: 24,
                letterSpacing: 1,
                color: Colors.blueAccent.shade700),
            titleSmall: GoogleFonts.bebasNeue(
                fontSize: 16,
                letterSpacing: 1,
                color: Colors.blueAccent.shade700),
            bodyLarge: GoogleFonts.poppins(fontSize: 18),
            bodyMedium: GoogleFonts.poppins(),
            bodySmall: GoogleFonts.poppins(fontSize: 12),
            labelMedium: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.yellow,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              textStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              foregroundColor: Colors.blueAccent.shade700,
              disabledForegroundColor:
                  Colors.blueAccent.shade700.withAlpha(125),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                width: 2,
                color: Colors.blueAccent.shade700,
              ),
              textStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              foregroundColor: Colors.white,
            ),
          ),
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (_) => const SplashScreen(),
          '/homeBuilder': (_) => const HomeScreenBuilder(),
          '/home': (_) => const HomeScreen(),
          '/recommendation': (_) => const RecommendationScreen(),
          '/signup': (_) => const SignUpScreen(),
          '/profile': (_) => const ProfileScreen(),
          '/manga': (_) => const MangaDetailsScreen(),
          '/chapter': (_) => const ReadMangaScreen(),
        },
      ),
    );
  }
}
