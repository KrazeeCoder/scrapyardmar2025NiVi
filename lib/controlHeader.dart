import 'package:flutter/material.dart';

class ControlHeader extends StatelessWidget {
  final VoidCallback onScreenshotPressed;
  final VoidCallback onThemePressed;
  final bool isDarkMode;

  const ControlHeader({
    super.key,
    required this.onScreenshotPressed,
    required this.onThemePressed,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: isDarkMode ? Colors.grey[900] : Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.switch_left, color: Colors.blue),
            onPressed: () {
              // Placeholder for switch functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.auto_awesome, color: Colors.blue),
            onPressed: () {
              // Placeholder for AI functionality
            },
          ),
          // Single IconButton for light/dark mode
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.blue,
            ),
            onPressed: onThemePressed,
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.blue),
            onPressed: onScreenshotPressed,
          ),
        ],
      ),
    );
  }
}