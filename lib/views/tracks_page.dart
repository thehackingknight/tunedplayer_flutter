import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../constants/index.dart';
import '../models/provider_store.dart';
import '../widgets/track_item.dart';

class TracksPage extends StatelessWidget {
  const TracksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Tracks extends StatefulWidget {
  const Tracks({super.key});

  @override
  State<Tracks> createState() => _TracksState();
}

class _TracksState extends State<Tracks> {
  late TPlayerState _playerStateWatcher;
  @override
  Widget build(BuildContext context) {
    _playerStateWatcher = context.watch<TPlayerState>();

    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                    itemCount: _playerStateWatcher.playlist.length,
                    itemBuilder: ((context, index) {
                      return TrackItem(
                          index: index, playlist: _playerStateWatcher.playlist);
                    })),
              ),
            )
          ],
        ));
  }
}
