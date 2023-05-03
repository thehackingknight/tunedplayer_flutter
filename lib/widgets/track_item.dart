import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:tunedplayer/models/vanilla_models.dart';

import '../constants/index.dart';
import '../models/provider_store.dart';

class TrackItem extends StatefulWidget {
  final int index;
  final List<TrackSchema> playlist;
  const TrackItem({super.key, required this.index, required this.playlist});

  @override
  State<TrackItem> createState() => _TrackItemState();
}

class _TrackItemState extends State<TrackItem> {
  @override
  Widget build(BuildContext context) {
    final TPlayerState _playerState = context.watch();
    var playlist = widget.playlist;
    final index = widget.index;
    String artist = playlist[index].artist != null
        ? playlist[index].artist!
        : "Unknown artist";

    double screenW = MediaQuery.of(context).size.width;
    return Card(
      color: Color.fromRGBO(11, 11, 11, 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
              width: 20,
              child: Icon(
                CupertinoIcons.music_note,
                color: _playerState.player.currentIndex == index
                    ? orange
                    : Colors.white70,
              )),
          Container(
            margin: EdgeInsets.only(left: 15),
            width: .75 * screenW,// 320 on 411,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),

              onTap: () {
                _playerState.setCurrIndex(index);
                //_playerStateWatcher.setCurrTrack(playlist[index]);
                if (!_playerState.useCurrPlaylist &&
                    _playerState.currPlaylist != _playerState.playlist) {
                  //Playing tracks from songs tab AKA all tracks
                  _playerState.setCurrPlaylist(_playerState.playlist);
                } else {
                  _playerState.player.seek(Duration.zero, index: index);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: .77*screenW,
                    height: 22,
                    child: Text(
                      playlist[index].title,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                  SizedBox(
                    width: .77*screenW,
                    height: 18,
                    child: Text(
                      artist,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.ellipsis_vertical),
            ),
          )
        ]),
      ),
    );
  }
}

/*

 Card TrackItem(int index) {
    var playlist = _playerStateWatcher.playlist;
    String artist = playlist[index].artist != null
        ? _playerStateWatcher.playlist[index].artist!
        : "Unknown artist";

    return }*/
