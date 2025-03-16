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
        children: [
          // Plus icon on the left
          IconButton(
            onPressed: () {
              // Add functionality for the plus icon (e.g., show attachment options)
            },
            icon: Icon(
              Icons.add_circle,
              color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              size: 40,
            ),
          ),
          const SizedBox(width: 10),
          // Expanded text field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // Send button (custom icon from assets)
                  IconButton(
                    onPressed: onSendPressed,
                    icon: CircleAvatar(
                      backgroundImage: AssetImage('assets/sentMessage.png'),
                      radius: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}