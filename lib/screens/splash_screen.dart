import 'package:flutter/material.dart';
import 'package:space/screens/home_screen.dart';
import '../../core/constants.dart';
import '../../widgets/red_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
       
          Image.asset(kSplashImage, fit: BoxFit.cover),

         
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Explore\nThe\nUniverse',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
            ),
          ),

          
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: RedButton(
                  title: 'Explore',
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}