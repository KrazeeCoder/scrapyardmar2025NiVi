import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isLastMessage;
  final Color? bubbleColor;
  final Color? textColor;

  const MessageWidget({
    super.key,
    required this.text,
    required this.isUser,
    this.isLastMessage = false,
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
          color: bubbleColor ?? (isUser ? Colors.blue : Colors.grey[300]),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: isUser || !isLastMessage
                ? const Radius.circular(18)
                : const Radius.circular(4),
            bottomRight: !isUser || !isLastMessage
                ? const Radius.circular(18)
                : const Radius.circular(4),
          ),
        ),
        child: Stack(
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor ?? (isUser ? Colors.white : Colors.black),
                fontSize: 16,
              ),
            ),
            if (isLastMessage)
              Positioned(
                bottom: 0,
                right: isUser ? -10 : null,
                left: isUser ? null : -10,
                child: CustomPaint(
                  size: const Size(12, 12),
                  painter: _MessageTailPainter(
                    color: bubbleColor ?? (isUser ? Colors.blue : Colors.grey[300]!),
                    isUser: isUser,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MessageTailPainter extends CustomPainter {
  final Color color;
  final bool isUser;

  _MessageTailPainter({required this.color, required this.isUser});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final Path path = Path();

    if (isUser) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}