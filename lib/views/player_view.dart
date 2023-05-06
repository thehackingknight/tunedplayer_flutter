import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:tunedplayer/constants/index.dart';
import 'package:tunedplayer/models/provider_store.dart';
import 'package:tunedplayer/models/vanilla_models.dart';
import 'package:tunedplayer/widgets/widgets.dart';
import 'package:tunedplayer/widgets/full_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import '../constants/globals.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({super.key});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  // STATE //
  // END STATE //
  late TPlayerState _playerStateReader;
  late TPlayerState _playerStateWatcher;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _playerStateReader = context.read<TPlayerState>();


  }

  @override
  Widget build(BuildContext context) {
    var winW = MediaQuery.of(context).size.width;
    var winH = MediaQuery.of(context).size.height;
    _playerStateWatcher = context.watch<TPlayerState>();
    //aFTER BUILD

    return !_playerStateWatcher.useCurrPlaylist ? Positioned(
      bottom: 50,
      height: 60,
      width: winW,
      child: Card(
        color: const Color.fromRGBO(11, 11, 11, 1),
        borderOnForeground: true,
        child: MinPlayer(),
      ),
    ) : Container();
  }

  Widget MinPlayer() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTapDown: (event) {
              _playerStateReader
                  .setIsMinPlayer(!_playerStateWatcher.isMinPlayer);
              showModalBottomSheet(
                  context: context, builder: (context) => FullPlayer());
            },
            child: _playerStateWatcher.currTrack != null
                ? Column(
                    children: [
                      SizedText(
                          txt: _playerStateWatcher.currTrack!.title,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                          w: 260, // TODO
                          h: 20),
                      SizedText(txt:"${_playerStateWatcher.currTrack!.artist}",
                          style: const TextStyle(fontSize: 11),
                          w: 260, h: 15)
                    ],
                  )
                : const Text(""),
          ),
          SizedBox(
              width: 24,
              child: IconButton(
                onPressed: () {
                  _playerStateWatcher.isPlaying
                      ? _playerStateWatcher.player.pause()
                      : _playerStateWatcher.player.play().then((value) {
                          print("Playin");
                        }).catchError((err) {
                          print("PlayError");
                        });
                },
                icon: _playerStateWatcher.isPlaying
                    ? const Icon(CupertinoIcons.pause)
                    : const Icon(CupertinoIcons.play),
              )),
        ],
      ),
    );
  }
}
