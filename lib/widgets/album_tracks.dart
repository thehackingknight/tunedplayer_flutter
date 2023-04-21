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
  @override
  Widget build(BuildContext context) {
    final _playerStateWatcher = context.watch<TPlayerState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.album.album),
              Text("${_playerStateWatcher.useCurrPlaylist}"),
            ],
          ),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                  itemCount: _playerStateWatcher.playlist.length,
                  itemBuilder: ((context, index) {
                    return TrackItem(
                        index: index, playlist: _playerStateWatcher.playlist.where((element) => element.albumId == widget.album.id).toList());
                  })),
            ),
          )
        ],
      ),
    );
  }
}
