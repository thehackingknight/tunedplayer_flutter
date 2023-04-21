import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:tunedplayer/widgets/track_item.dart';

import '../models/provider_store.dart';

class AlbumTracks extends StatefulWidget {
  final AlbumModel album;
  const AlbumTracks({super.key, required this.album});

  @override
  State<AlbumTracks> createState() => _AlbumTracksState();
}

class _AlbumTracksState extends State<AlbumTracks> {
  late TPlayerState _playerState;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //Set current playlist
      _playerState.setCurrPlaylist(_playerState.playlist
          .where((it) => it.albumId == widget.album.id)
          .toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    _playerState = context.watch<TPlayerState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.album.album),
              Text("${_playerState.useCurrPlaylist}"),
            ],
          ),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                  itemCount: _playerState.currPlaylist.length,
                  itemBuilder: ((context, index) {
                    return TrackItem(
                        index: index, playlist: _playerState.currPlaylist);
                  })),
            ),
          )
        ],
      ),
    );
  }
}
