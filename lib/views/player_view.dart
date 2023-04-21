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

  final _audioQuery = OnAudioQuery();
  List<AudioSource> _children = List.empty(growable: true);
  late ConcatenatingAudioSource audioPlaylist;

  void getTracks() async {
    List<TrackSchema> playlist = List.empty(growable: true);
    var res = await _audioQuery.querySongs();
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

      //_playerStateWatcher.setCurrTrack(playlist[0]);
      _playerStateWatcher.setPlaylist(playlist);
      if (Platform.isAndroid &&
          _playerStateWatcher.player.audioSource == null) {
        AudioPlayer newAudioPlayer = AudioPlayer();
        newAudioPlayer
            .setAudioSource(audioPlaylist,
                initialIndex: 0, initialPosition: Duration.zero)
            .then((value) => {
                  newAudioPlayer.playerStateStream.listen((state) {
                    debugPrint("$TAG: STATE: $state");
                    setState(() {
                      _playerStateReader.setIsPlaying(state.playing);
                    });
                  })
                });

        newAudioPlayer.durationStream.listen((val) {
          if (val != null) {
            _playerStateReader.setDuration(val);
          }
        });

        newAudioPlayer.positionStream.listen((val) {
          _playerStateReader.setPosition(val);
        });
        _playerStateReader.setPlayer(newAudioPlayer);
      }
    }
  }

  void getAlbums() async {
    var albums = await _audioQuery.queryAlbums();
    _playerStateReader.setAlbums(albums);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _playerStateReader = context.read<TPlayerState>();

    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      if (_playerStateWatcher.currTrack == null) {
        _playerStateReader.setCurrTrack(
            TrackSchema(title: "Hanah", artist: "Tonics", album: "Single"));
      }

      getTracks();
      getAlbums();
    });
  }

  @override
  Widget build(BuildContext context) {
    var winW = MediaQuery.of(context).size.width;
    var winH = MediaQuery.of(context).size.height;
    _playerStateWatcher = context.watch<TPlayerState>();
    //aFTER BUILD

    return Positioned(
      bottom: 50,
      height: 60,
      width: winW,
      child: Card(
        child: MinPlayer(),
        color: Color.fromARGB(226, 15, 15, 15),
        borderOnForeground: true,
      ),
    );
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
                          _playerStateWatcher.currTrack!.title,
                          const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                          w: 260,
                          h: 20),
                      SizedText("${_playerStateWatcher.currTrack!.artist}",
                          const TextStyle(fontSize: 11),
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
