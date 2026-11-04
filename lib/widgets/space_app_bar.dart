import 'package:flutter/material.dart';
import '../core/app_text_styles.dart';
import '../core/constants.dart';


class SpaceAppBar extends StatelessWidget {
  final String topTitle;
  final String bottomTitle;
  final Widget? leading;
  final double height;

  const SpaceAppBar({
    super.key,
    required this.topTitle,
    required this.bottomTitle,
    this.leading,
    this.height = 260,
  });

  @override
  Widget build(BuildContext context) {
    final safeTop = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: height + safeTop,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          
          Image.asset(
            kHeaderImage,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, kBlack],
                stops: [0.35, 1.0],
              ),
            ),
          ),
          
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: safeTop + 26),
              child: Text(topTitle, style: AppText.heading),
            ),
          ),
         
          if (leading != null)
            Positioned(
              left: 16,
              top: safeTop + 22,
              child: leading!,
            ),
          
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(bottomTitle, style: AppText.heading),
            ),
          ),
        ],
      ),
    );
  }
}