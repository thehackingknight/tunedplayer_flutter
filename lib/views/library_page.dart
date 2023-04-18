import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tunedplayer/views/tracks_page.dart';

import '../constants/index.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            labelColor: orange_2,
            tabs: [
              Tab(icon: Icon(CupertinoIcons.music_note_2)),
              Tab(icon: Icon(CupertinoIcons.music_albums)),
              Tab(icon: Icon(CupertinoIcons.person)),
              Tab(icon: Icon(CupertinoIcons.music_note_list)),
            ],
          ),
          toolbarHeight: 0,
        ),
        body: const TabBarView(children: [
          Tracks(),
          Text("Albums"),
          Text("Artists"),
          Text("Playlists"),
        ]),
      ),
    );
  }
}
