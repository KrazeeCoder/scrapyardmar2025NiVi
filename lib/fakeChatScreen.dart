import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'message_widget.dart';

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
  List<Map<String, String>> messages = [];

  void sendMessage(String text, bool isUser) {
    setState(() {
      messages.add({"text": text, "sender": isUser ? "user" : "parent"});
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
    return Scaffold(
      backgroundColor: Colors.black, // iMessage background
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.parentPhoto),
              radius: 15,
            ),
            const SizedBox(width: 10),
            Text(
              widget.parentName,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.camera),
            onPressed: takeScreenshot,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Screenshot(
              controller: screenshotController,
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[messages.length - index - 1];
                    final isUser = msg["sender"] == "user";
                    return MessageWidget(
                      text: msg["text"]!,
                      isUser: isUser,
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.black,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      sendMessage(textController.text, true);
                    }
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}