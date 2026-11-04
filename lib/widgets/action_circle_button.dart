import 'package:flutter/material.dart';
import '../core/constants.dart';

class ActionCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const ActionCircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kRed,
        foregroundColor: kWhite,
        elevation: 0,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        minimumSize: const Size(40, 40),
      ),
      child: Icon(icon, color: kWhite, size: 22),
    );
  }
}