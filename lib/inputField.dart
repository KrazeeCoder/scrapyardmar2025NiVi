import 'package:flutter/cupertino.dart';
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
    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: '.SF UI Text', // Cupertino/iMessage-like font
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: isDarkMode ? CupertinoColors.systemBackground.darkColor : CupertinoColors.systemBackground,
        child: Row(
          children: isSwitched
              ? [
            // Expanded text field with mic/send button inside the border on the left
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? CupertinoColors.systemGrey6.darkColor : CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    // Mic/send button inside the text field border (left side)
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: controller,
                      builder: (context, value, child) {
                        return CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: value.text.isNotEmpty ? onSendPressed : null,
                          child: Icon(
                            value.text.isNotEmpty
                                ? CupertinoIcons.arrow_up_circle_fill // iMessage-style send icon
                                : CupertinoIcons.mic_fill, // Mic icon when text is empty
                            color: value.text.isNotEmpty
                                ? CupertinoColors.systemBlue // Blue color for send icon
                                : isDarkMode
                                ? CupertinoColors.systemGrey
                                : CupertinoColors.systemGrey2,
                            size: 24, // Smaller icon size
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8), // Add spacing between button and text field edge
                    // Expanded text field
                    Expanded(
                      child: CupertinoTextField(
                        controller: controller,
                        style: TextStyle(
                          color: isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                          fontSize: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide.none,
                            bottom: BorderSide.none,
                            right: BorderSide.none,
                            left: BorderSide.none,
                          ),
                        ),
                        placeholder: "iMessage",
                        placeholderStyle: TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Plus icon on the right (outside the text field border)
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // Add functionality for the plus icon (e.g., show attachment options)
              },
              child: Icon(
                CupertinoIcons.add_circled_solid, // Solid Cupertino icon
                color: isDarkMode ? CupertinoColors.systemGrey : CupertinoColors.systemGrey2,
                size: 28, // Smaller icon size
              ),
            ),
          ]
              : [
            // Plus icon on the left (outside the text field border)
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // Add functionality for the plus icon (e.g., show attachment options)
              },
              child: Icon(
                CupertinoIcons.add_circled_solid, // Solid Cupertino icon
                color: isDarkMode ? CupertinoColors.systemGrey : CupertinoColors.systemGrey2,
                size: 28, // Smaller icon size
              ),
            ),
            const SizedBox(width: 10),
            // Expanded text field with mic/send button inside the border on the right
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? CupertinoColors.systemGrey6.darkColor : CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    Expanded(
                      child: CupertinoTextField(
                        controller: controller,
                        style: TextStyle(
                          color: isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                          fontSize: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide.none,
                            bottom: BorderSide.none,
                            right: BorderSide.none,
                            left: BorderSide.none,
                          ),
                        ),
                        placeholder: "iMessage",
                        placeholderStyle: TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // Mic/send button inside the text field border (right side)
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: controller,
                      builder: (context, value, child) {
                        return CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: value.text.isNotEmpty ? onSendPressed : null,
                          child: Icon(
                            value.text.isNotEmpty
                                ? CupertinoIcons.arrow_up_circle_fill // iMessage-style send icon
                                : CupertinoIcons.mic_fill, // Mic icon when text is empty
                            color: value.text.isNotEmpty
                                ? CupertinoColors.systemBlue // Blue color for send icon
                                : isDarkMode
                                ? CupertinoColors.systemGrey
                                : CupertinoColors.systemGrey2,
                            size: 24, // Smaller icon size
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8), // Add spacing between button and text field edge
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}