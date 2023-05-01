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
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 4 + 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _playerStateWatcher.currTrack != null
                    ? Column(
                        children: [
                          SizedText(
                              _playerStateWatcher.currTrack!.title,
                              const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              h: 27),
                          SizedText("${_playerStateWatcher.currTrack!.artist}",
                              const TextStyle(fontSize: 15)),
                          SizedText("${_playerStateWatcher.currTrack!.album}",
                              const TextStyle(fontSize: 15)),
                        ],
                      )
                    : Text("No track"),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.ellipsis_vertical))
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  formatTime(_playerStateWatcher.position),
                  style: const TextStyle(fontSize: 11),
                ),
                SizedBox(
                    width: 230,
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
          ]),
        ],
      ),
    );
  }
}
