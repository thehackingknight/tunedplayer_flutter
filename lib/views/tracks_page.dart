import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../constants/index.dart';

class TracksPage extends StatelessWidget {
  const TracksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Tracks extends StatefulWidget {
  const Tracks({super.key});

  @override
  State<Tracks> createState() => _TracksState();
}

class _TracksState extends State<Tracks> {
  int cnt = 0;
  bool isPlaying = false;
  AudioPlayer? player = null;
  final OnAudioQuery _audioQuery = OnAudioQuery();

  List<SongModel> tracks = [];

  void getTracks() async {
    var res = await _audioQuery.querySongs();
    debugPrint("$TAG SONGS QUERIED");
    setState(() {
      tracks = res;
    });
  }

  var lst = [1, 2, 3, 4, 5];
  final URL = "https://www.kozco.com/tech/piano2-CoolEdit.mp3";
  // Define the playlist
  final playlist = ConcatenatingAudioSource(
    // Start loading next item just before reaching it
    useLazyPreparation: true,
    // Customise the shuffle algorithm
    shuffleOrder: DefaultShuffleOrder(),
    // Specify the playlist items
    children: [
      AudioSource.uri(
        Uri.parse(
            "https://res.cloudinary.com/sketchi/video/upload/v1665652751/TunedBass/audio%20files/TenTimez_bl2ghf.mp3"),
        tag: MediaItem(
          // Specify a unique ID for each media item:
          id: '1',
          // Metadata to display in the notification:
          album: "To You",
          title: "TenTimes",
          artUri: Uri.parse(
              'https://res.cloudinary.com/sketchi/image/upload/v1642949999/TunedBass/images/pexels-stas-knop-1261578_pkw99u.jpg'),
        ),
      ),
      AudioSource.uri(
        Uri.parse(
            'https://res.cloudinary.com/sketchi/video/upload/v1661797757/TunedBass/My_Land_wxcvsl.mp3'),
        tag: MediaItem(
          // Specify a unique ID for each media item:
          id: '2',
          // Metadata to display in the notification:
          album: "To You",
          title: "My Land",
          artUri: Uri.parse(
              'https://res.cloudinary.com/sketchi/image/upload/v1642949999/TunedBass/images/pexels-stas-knop-1261578_pkw99u.jpg'),
        ),
      )
    ],
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (tracks.isEmpty) getTracks();
    if (player == null) {
      setState(() {
        player = AudioPlayer();
      });
      if (Platform.isAndroid && player?.audioSource == null) {
        return;
        player
            ?.setAudioSource(playlist,
                initialIndex: 0, initialPosition: Duration.zero)
            .then((value) => {
                  player?.playerStateStream.listen((state) {
                    debugPrint("$TAG: STATE: $state");
                    setState(() {
                      isPlaying = state.playing;
                    });
                  })
                });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void playPause() {
      debugPrint("PP");
      if (isPlaying) {
        player?.pause();
      } else {
        player?.play().then((value) => debugPrint("$TAG: Playing"));
      }
    }

    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                    itemCount: tracks.length,
                    itemBuilder: ((context, index) {
                      return TrackItem(index);
                    })),
              ),
            )
          ],
        ));
  }

  Card TrackItem(int index) {
    String artist =
        tracks[index].artist != null ? tracks[index].artist! : "Unknown artist";

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 250,
                height: 22,
                child: Text(
                  tracks[index].title,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              SizedBox(
                width: 250,
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
