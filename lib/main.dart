import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'fakeChatScreen.dart';



void main() {
  runApp(const FakeIMessageApp());
}

class FakeIMessageApp extends StatelessWidget {
  const FakeIMessageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      FakeChatScreen(
        parentName: "Mom",
        parentPhoto: "assets/defaultProfilePic.jpg",
      ),
    );
  }
}
