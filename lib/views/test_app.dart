import 'package:flutter/material.dart';
import 'package:tunedplayer/views/albums_tab.dart';

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AlbumsTab(),
          ],
        ),
      ),
    );
  }
}
