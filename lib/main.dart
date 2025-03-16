import 'package:flutter/material.dart';
import 'fakeChatScreen.dart';
import 'controlHeader.dart';

void main() {
  runApp(const FakeIMessageApp());
}

class FakeIMessageApp extends StatelessWidget {
  const FakeIMessageApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Use _FakeChatScreenState as the type for the GlobalKey
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: FakeChatScreen(
                parentName: "Mom",
                parentPhoto: "assets/defaultProfilePic.jpg",
              ),
            ),
          ],
        ),
      ),
    );
  }
}