import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'messageWidget.dart';
import 'controlHeader.dart'; // Import the ControlHeader
import 'inputField.dart'; // Import the InputField

class FakeChatScreen extends StatefulWidget {
  final String parentName;
  final String parentPhoto;

  const FakeChatScreen({
    super.key,
    required this.parentName,
    required this.parentPhoto,
  });

  @override
  _FakeChatScreenState createState() => _FakeChatScreenState();
}

class _FakeChatScreenState extends State<FakeChatScreen> {
  final ScreenshotController screenshotController = ScreenshotController();
  final TextEditingController textController = TextEditingController();
  List<Map<String, dynamic>> messages = []; // Add a field to track switched mode

  // Track whether the app is in dark mode
  bool isDarkMode = true;

  // Track whether the input field is in switched mode
  bool isSwitched = false;

  // Function to toggle between light and dark mode
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  // Function to toggle switched mode
  void toggleSwitchedMode() {
    setState(() {
      isSwitched = !isSwitched;
    });
  }

  void sendMessage(String text, bool isUser) {
    setState(() {
      messages.add({
        "text": text,
        "sender": isUser ? "user" : "parent",
        "isSwitched": isSwitched, // Track whether the message was sent in switched mode
      });
    });
    textController.clear();
  }

  Future<void> takeScreenshot() async {
    final Uint8List? image = await screenshotController.capture();
    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/fake_chat.png';
      final File imageFile = File(imagePath);
      await imageFile.writeAsBytes(image);
      Share.shareXFiles([XFile(imagePath)], text: "Fake iMessage Screenshot");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define light and dark mode colors
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final chatBubbleColorUser = isDarkMode ? Colors.blue : Colors.blue[400];
    final chatBubbleColorParent = isDarkMode ? Colors.grey[800] : Colors.grey[300];

    return Scaffold(
      backgroundColor: backgroundColor, // Set background color based on theme
      body: Column(
        children: [
          // ControlHeader at the absolute top
          ControlHeader(
            onScreenshotPressed: takeScreenshot,
            onThemePressed: toggleTheme, // Pass the theme toggle function
            onSwitchPressed: toggleSwitchedMode, // Pass the switch mode function
            isDarkMode: isDarkMode, // Pass the current theme mode
          ),
          // Add the profile picture and "Mom" text here
          CupertinoTheme(
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
              color: backgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.parentPhoto),
                    radius: 15,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.parentName,
                    style: TextStyle(color: textColor, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Screenshot(
              controller: screenshotController,
              child: Container(
                color: backgroundColor,
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[messages.length - index - 1];
                    final isUser = msg["sender"] == "user";
                    final isSwitchedMessage = msg["isSwitched"];

                    return MessageWidget(
                      text: msg["text"],
                      isUser: isSwitchedMessage ? !isUser : isUser, // Flip alignment if in switched mode
                      bubbleColor: isSwitchedMessage
                          ? chatBubbleColorParent
                          : isUser
                          ? chatBubbleColorUser
                          : chatBubbleColorParent,
                      textColor: textColor,
                    );
                  },
                ),
              ),
            ),
          ),
          // Use the InputField widget
          InputField(
            controller: textController,
            onSendPressed: () {
              if (textController.text.isNotEmpty) {
                sendMessage(textController.text, true);
              }
            },
            isDarkMode: isDarkMode,
            isSwitched: isSwitched,
          ),
        ],
      ),
    );
  }
}