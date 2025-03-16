import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
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
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  late bool isLastMessage;

  @override
  void initState() {
    super.initState();
    isLastMessage = widget.isLastMessage; // Initialize with the passed value
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: CupertinoTheme.of(context).brightness,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: '.SF UI Text', // Cupertino/iMessage-like font
            fontSize: 16,
            color: widget.isUser ? CupertinoColors.white : CupertinoColors.label,
          ),
        ),
      ),
      child: Align(
        alignment: widget.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: widget.bubbleColor ??
                (widget.isUser
                    ? CupertinoColors.systemBlue
                    : CupertinoColors.systemGrey6),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(18),
              topRight: const Radius.circular(18),
              bottomLeft: widget.isUser || !isLastMessage
                  ? const Radius.circular(18)
                  : const Radius.circular(4),
              bottomRight: !widget.isUser || !isLastMessage
                  ? const Radius.circular(18)
                  : const Radius.circular(4),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none, // Allow the tail to overflow
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor ??
                      (widget.isUser
                          ? CupertinoColors.white
                          : CupertinoColors.label),
                  fontSize: 16,
                ),
              ),
              if (isLastMessage)
                Positioned(
                  bottom: -4, // Adjust this value to align the tail properly
                  right: widget.isUser ? -12 : null, // Adjust this value for user messages
                  left: widget.isUser ? null : -10, // Adjust this value for non-user messages
                  child: CustomPaint(
                    size: const Size(12, 12),
                    painter: _MessageTailPainter(
                      color: widget.bubbleColor ??
                          (widget.isUser
                              ? CupertinoColors.systemBlue
                              : CupertinoColors.systemGrey6),
                      isUser: widget.isUser,
                    ),
                  ),
                ),
            ],
          ),
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
      // Draw tail for user messages (right side)
      path.moveTo(0, 0);
      path.quadraticBezierTo(size.width * 0.6, size.height * 0.2, size.width, size.height * 0.5);
      path.quadraticBezierTo(size.width * 0.6, size.height * 0.8, 0, size.height);
    } else {
      // Draw tail for non-user messages (left side)
      path.moveTo(size.width, 0);
      path.quadraticBezierTo(size.width * 0.4, size.height * 0.2, 0, size.height * 0.5);
      path.quadraticBezierTo(size.width * 0.4, size.height * 0.8, size.width, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}