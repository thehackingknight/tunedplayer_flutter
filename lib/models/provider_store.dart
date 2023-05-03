import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tunedplayer/models/vanilla_models.dart';

import '../constants/globals.dart';

class AppState extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  final String _name = "TunedPlayer";
  String get name => _name;

  void increment({int val = 1}) {
    _counter += val;
    notifyListeners();
  }

  double _screenWidth = 0;
  double get screenWidth => _screenWidth;
  void setScreenWidth(double val) {
    _screenWidth = val;
    notifyListeners();
  }
}

class TPlayerState extends ChangeNotifier {
  bool _isMinPlayer = false;
  bool get isMinPlayer => _isMinPlayer;
  void setIsMinPlayer(bool val) {
    _isMinPlayer = val;
    notifyListeners();
  }

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  void setIsPlaying(bool val) {
    _isPlaying = val;
    notifyListeners();
  }

  bool _useCurrPlaylist = false;
  bool get useCurrPlaylist => _useCurrPlaylist;
  void setUseCurrPlaylist(bool val) {
    _useCurrPlaylist = val;
    notifyListeners();
  }

  int _currIndex = 0;
  int get currIndex => _currIndex;
  void setCurrIndex(int val) {
    _currIndex = val;
    var playlistToUse = _useCurrPlaylist ? _currPlaylist : _playlist;
    setCurrTrack(playlistToUse[val]);

    if (_player.currentIndex != val) {
      _player.seek(Duration.zero, index: val);
    }
    if (val != 0 && !_player.playing) _player.play();
    notifyListeners();
  }

  TrackSchema? _currTrack;
  TrackSchema? get currTrack => _currTrack;
  void setCurrTrack(TrackSchema val) {
    _currTrack = val;
    notifyListeners();
  }

  List<TrackSchema> _playlist = List.empty();
  List<TrackSchema> get playlist => _playlist;
  void setPlaylist(List<TrackSchema> val) {
    _playlist = val;
    notifyListeners();
  }

  List<TrackSchema> _currPlaylist = List.empty();
  List<TrackSchema> get currPlaylist => _currPlaylist;
  void setCurrPlaylist(List<TrackSchema> val) {
    _currPlaylist = val;

    List<AudioSource> _children = List.empty(growable: true);
    late ConcatenatingAudioSource source;
    for (var it in val) {
      //Iterate through new playlist
      AudioSource audioSource = AudioSource.uri(
        Uri.parse(it.path!),
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
    source = ConcatenatingAudioSource(
      // Start loading next item just before reaching it
      useLazyPreparation: true,
      // Customise the shuffle algorithm
      shuffleOrder: DefaultShuffleOrder(),
      // Specify the playlist items
      children: _children,
    );

    if (val.isNotEmpty) {
      _player.setAudioSource(source);
      _player.seek(Duration.zero, index: _currIndex);
      print("Setting current track to ${val[_currIndex].title}");
      _currTrack = val[_currIndex];
    }

    notifyListeners();
  }

  List<AlbumModel> _albums = List.empty();
  List<AlbumModel> get albums => _albums;
  void setAlbums(List<AlbumModel> val) {
    _albums = val;
    notifyListeners();
  }

  AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  void setPlayer(AudioPlayer val) {
    _player = val;

    notifyListeners();
  }

  Duration _duration = const Duration(seconds: 100);
  Duration get duration => _duration;
  void setDuration(Duration val) {
    _duration = val;
    notifyListeners();
  }

  Duration _position = const Duration(seconds: 0);
  Duration get position => _position;
  void setPosition(Duration val) {
    _position = val;
    notifyListeners();
  }
}
