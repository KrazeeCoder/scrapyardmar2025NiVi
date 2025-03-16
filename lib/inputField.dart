// input_field.dart
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSendPressed;
  final bool isDarkMode;
  final bool isSwitched;

  const InputField({
    super.key,
    required this.controller,
    required this.onSendPressed,
    required this.isDarkMode,
    required this.isSwitched,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: isDarkMode ? Colors.grey[900] : Colors.grey[200],
      child: Row(
        children: isSwitched
            ? [
          // Send button on the left
          FloatingActionButton(
            onPressed: onSendPressed,
            backgroundColor: Colors.blue,
            child: const Icon(Icons.send, color: Colors.white),
          ),
          const SizedBox(width: 10),
          // Text field on the right
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
        ]
            : [
          // Text field on the left
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Send button on the right
          FloatingActionButton(
            onPressed: onSendPressed,
            backgroundColor: Colors.blue,
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}