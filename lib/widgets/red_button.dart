import 'package:flutter/material.dart';
import '../core/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class RedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const RedButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kRed,
          foregroundColor: kWhite,
          elevation: 0,
          padding: const EdgeInsets.all(16),
          shape: const StadiumBorder(),
        ),
        child: Row(
          children: [
            Expanded(
              
child: Text(
  title,
  style: GoogleFonts.spaceGrotesk(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: kWhite,
  ),
),
            ),
            const Icon(Icons.arrow_forward, color: kWhite, size: 22),
          ],
        ),
      ),
    );
  }
}