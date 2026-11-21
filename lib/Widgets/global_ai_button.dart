import 'package:flutter/material.dart';

class GlobalAIButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GlobalAIButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      highlightElevation: 0,
      shape: const CircleBorder(),
      child: Image.asset(
        'assets/images/robot.png',
        width: 76,
        height: 76,
        fit: BoxFit.contain,
      ),
    );
  }
}
