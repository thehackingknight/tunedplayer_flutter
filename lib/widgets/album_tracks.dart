import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:tunedplayer/constants/styles.dart';
import 'package:tunedplayer/widgets/track_item.dart';

import '../models/provider_store.dart';

class AlbumTracks extends StatefulWidget {
  const AlbumTracks({super.key});

  @override
  State<AlbumTracks> createState() => _AlbumTracksState();
}

class _AlbumTracksState extends State<AlbumTracks> {
  late TPlayerState _playerState;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //Set current playlist
      _playerState.setCurrPlaylist(_playerState.playlist
          .where((it) => it.albumId == _playerState.currAlbum?.id)
          .toList());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _playerState = context.watch<TPlayerState>();
    return Scaffold(
      appBar: AppBar(
        title:
        Text("${_playerState.currAlbum?.album}",
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 18)),
        actions: const [
         Icon(CupertinoIcons.ellipsis_vertical)],
      ),
      body: Column(
        children: [
          Text("${ModalRoute.of(context)?.settings.name}/${_playerState.currAlbum?.album}"),
          Expanded(

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Scrollbar(
                child: ListView.builder(
                    itemCount: _playerState.currPlaylist.length,
                    itemBuilder: ((context, index) {
                      return TrackItem(
                          index: index, playlist: _playerState.currPlaylist);
                    })),
              ),
            ),
          )
        ],
      ),
    );
  }
}
