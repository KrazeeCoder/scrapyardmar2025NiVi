import 'package:flutter/material.dart';

class ControlHeader extends StatelessWidget {
  final VoidCallback onScreenshotPressed;

  const ControlHeader({
    super.key,
    required this.onScreenshotPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.grey[900],
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.switch_left, color: Colors.white),
            onPressed: () {
              // Placeholder for switch functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.auto_awesome, color: Colors.white),
            onPressed: () {
              // Placeholder for AI functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.light_mode, color: Colors.white),
            onPressed: () {
              // Placeholder for light/dark mode functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.white),
            onPressed: onScreenshotPressed,
          ),
        ],
      ),
    );
  }
}