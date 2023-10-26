import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/providers/home_provider.dart';
import 'package:flutter_manga_app_test/providers/manga_details_provider.dart';
import 'package:flutter_manga_app_test/providers/read_manga_provider.dart';
import 'package:flutter_manga_app_test/views/screens/home_screen.dart';
import 'package:flutter_manga_app_test/views/screens/read_manga_screen.dart';
import 'package:flutter_manga_app_test/views/screens/manga_details_screen.dart';
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
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => MangaDetailsProvider()),
        ChangeNotifierProvider(create: (_) => ReadMangaProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.dark(
            background: Colors.black,
            primary: Colors.blueAccent.shade700,
            secondary: Colors.white,
            brightness: Brightness.dark,
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
            labelMedium: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.yellow,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent.shade700,
              textStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              foregroundColor: Colors.white,
              disabledForegroundColor:
                  Colors.blueAccent.shade700.withAlpha(125),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 2, color: Colors.blueAccent.shade700),
              textStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (_) => const SplashScreen(),
          '/home': (_) => const HomeScreen(),
          '/manga': (_) => const MangaDetailsScreen(),
          '/chapter': (_) => const ReadMangaScreen(),
        },
      ),
    );
  }
}
