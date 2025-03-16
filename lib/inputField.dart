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
            // Send button on the left
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: onSendPressed,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/sentMessage.png'),
                radius: 15,
              ),
            ),
            const SizedBox(width: 10),
            // Expanded text field
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
                  ],
                ),
              ),
            ),
            // Plus icon on the right
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // Add functionality for the plus icon (e.g., show attachment options)
              },
              child: Icon(
                CupertinoIcons.add_circled,
                color: isDarkMode ? CupertinoColors.systemGrey : CupertinoColors.systemGrey2,
                size: 40,
              ),
            ),
          ]
              : [
            // Plus icon on the left
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // Add functionality for the plus icon (e.g., show attachment options)
              },
              child: Icon(
                CupertinoIcons.add_circled,
                color: isDarkMode ? CupertinoColors.systemGrey : CupertinoColors.systemGrey2,
                size: 40,
              ),
            ),
            const SizedBox(width: 10),
            // Expanded text field
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
                    // Send button (custom icon from assets)
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: onSendPressed,
                      child: CircleAvatar(
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
      ),
    );
  }
}