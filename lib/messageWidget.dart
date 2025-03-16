import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final bool isUser;
  final Color? bubbleColor;
  final Color? textColor;

  const MessageWidget({
    super.key,
    required this.text,
    required this.isUser,
    this.bubbleColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 16),
        ),
      ),
    );
  }
}