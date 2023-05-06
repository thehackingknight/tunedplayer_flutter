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
    super.initState();
    _playerStateReader = context.read<TPlayerState>();

  }

  @override
  Widget build(BuildContext context) {
    var winW = MediaQuery.of(context).size.width;
    var winH = MediaQuery.of(context).size.height;
    _playerStateWatcher = context.watch<TPlayerState>();
    var currRoute = ModalRoute.of(context)?.settings.name;
    //aFTER BUILD

    return !_playerStateWatcher.useCurrPlaylist ? Positioned(
      bottom: currRoute == '/' ? 50 : 0,
      height: 60,
      width: winW,
      child: Scaffold(
        body: Stack(
          children: [

            Container(
              margin: const EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(50, 50, 50, 1),
                ),
                borderRadius: BorderRadius.circular(4),
                color: Color.fromRGBO(20, 20, 20, 1),
              ),child: MinPlayer(),
            ),Positioned(
                top: -10,
                left: 5,
                child: SizedBox(
                    width: winW - 10,
                    child: ProgressBar(
                      progress: _playerStateWatcher.position,
                      total: _playerStateWatcher.duration,
                      onSeek: (v) {
                        _playerStateReader.player.seek(v);
                      },
                      timeLabelTextStyle: TextStyle(fontSize: 0),
                      barHeight: 2,
                      thumbColor: Colors.transparent,
                      progressBarColor: Colors.white,
                    )),
            )],
        ),
      ),
    ) : Container();
  }

  Widget MinPlayer() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTapDown: (event) {
              _playerStateReader
                  .setIsMinPlayer(!_playerStateWatcher.isMinPlayer);
              showModalBottomSheet(
                  context: context, builder: (context) => const FullPlayer());
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
                          tprint("Playin");
                        }).catchError((err) {
                          tprint("PlayError");
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
