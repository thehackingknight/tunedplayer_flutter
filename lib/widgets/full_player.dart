import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunedplayer/constants/index.dart';
import 'package:tunedplayer/models/provider_store.dart';
import 'package:tunedplayer/widgets/widgets.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class FullPlayer extends StatefulWidget {
  const FullPlayer({super.key});

  @override
  State<FullPlayer> createState() => _FullPlayerState();
}

class _FullPlayerState extends State<FullPlayer> {
  late TPlayerState _playerStateReader;
  late TPlayerState _playerStateWatcher;

  @override
  Widget build(BuildContext context) {
    _playerStateReader = context.read<TPlayerState>();
    _playerStateWatcher = context.watch<TPlayerState>();
    double _screenW = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.black26,
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 4 + 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.share,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.heart,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.add,
                )),
          ]),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _playerStateWatcher.currTrack != null
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedText(
                                txt: _playerStateWatcher.currTrack!.title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                                w: .82 * _screenW,
                                h: 27),
                            SizedText(
                                txt:"${_playerStateWatcher.currTrack!.artist}",
                                style: const TextStyle(fontSize: 15),
                                w: .82 * _screenW
                            ),

                            SizedText(
                                txt: "${_playerStateWatcher.currTrack!.album}",
                                style: const TextStyle(fontSize: 15),
                            w: .82 * _screenW,),

                          ],
                        )
                      : Text("No track"),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.ellipsis_vertical))
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.repeat,
                    size: 18,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.chevron_back)),
              IconButton(
                iconSize: 40,
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
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.chevron_forward)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.shuffle,
                    size: 18,
                  )),
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatTime(_playerStateWatcher.position),
                    style: const TextStyle(fontSize: 11),
                  ),
                  SizedBox(
                      width: .75 * _screenW,
                      child: ProgressBar(
                        progress: _playerStateWatcher.position,
                        total: _playerStateWatcher.duration,
                        onSeek: (v) {
                          _playerStateReader.player.seek(v);
                        },
                        timeLabelTextStyle: TextStyle(fontSize: 0),
                        barHeight: 2,
                        thumbColor: orange,
                        progressBarColor: Colors.white,
                      )),
                  Text(
                    formatTime(_playerStateWatcher.duration),
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
