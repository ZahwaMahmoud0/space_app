import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const SpaceApp());

class SpaceApp extends StatelessWidget {
  const SpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Space',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kBlack,
        textTheme: TextTheme(
          titleLarge: GoogleFonts.spaceGrotesk(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: kWhite,
          ),
          bodyLarge: GoogleFonts.spaceGrotesk(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: kWhite,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}