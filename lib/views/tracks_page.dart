import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../constants/globals.dart';
import '../constants/index.dart';
import '../models/provider_store.dart';
import '../models/vanilla_models.dart';
import '../widgets/track_item.dart';

class TracksPage extends StatelessWidget {
  const TracksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TracksTab extends StatefulWidget {
  const TracksTab({super.key});

  @override
  State<TracksTab> createState() => _TracksTabState();
}

class _TracksTabState extends State<TracksTab> {
  late TPlayerState _playerState;
  
  final List<AudioSource> _children = List.empty(growable: true);
  late ConcatenatingAudioSource audioPlaylist;

  void getTracks() async {
    List<TrackSchema> playlist = List.empty(growable: true);
    var res = await audioQuery.querySongs();
    debugPrint("$TAG SONGS QUERIED");
    for (var it in res) {
      TrackSchema track = TrackSchema(
          title: it.title,
          artist: it.artist,
          album: it.album,
          albumId: it.albumId,
          path: it.uri,
          id: it.id);
      playlist.add(track);

      AudioSource audioSource = AudioSource.uri(
        Uri.parse(it.uri!),
        tag: MediaItem(
          // Specify a unique ID for each media item:
          id: it.id.toString(),
          // Metadata to display in the notification:
          album: it.album,
          title: it.title,
          artUri: Uri.parse(dummyImg),
        ),
      );
      _children.add(audioSource);
    }

    if (_children.isNotEmpty) {
      audioPlaylist = ConcatenatingAudioSource(
        // Start loading next item just before reaching it
        useLazyPreparation: true,
        // Customise the shuffle algorithm
        shuffleOrder: DefaultShuffleOrder(),
        // Specify the playlist items
        children: _children,
      );

      _playerState.setPlaylist(playlist);
      _playerState.setCurrPlaylist(playlist);

      if (Platform.isAndroid &&
          _playerState.player.audioSource == null) {}
    }
  }




  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {

      getTracks();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    _playerState = context.watch<TPlayerState>();

    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                    itemCount: _playerState.playlist.length,
                    itemBuilder: ((context, index) {
                      return TrackItem(
                          index: index, playlist: _playerState.playlist);
                    })),
              ),
            )
          ],
        ));
  }
}
