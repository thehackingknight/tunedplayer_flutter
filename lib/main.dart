import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tunedplayer/models/provider_store.dart';
import 'package:tunedplayer/views/home_page.dart';
import 'package:tunedplayer/views/library_page.dart';
import 'package:tunedplayer/views/player_view.dart';
import 'package:tunedplayer/views/test_app.dart';
import 'package:tunedplayer/widgets/album_tracks.dart';
import 'package:tunedplayer/widgets/navmenu.dart';
import 'constants/index.dart';
import "constants/globals.dart" as globals;

Future<void> main() async {
  //HIVE
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  //REQUEST STORAGE PERMISSION
  if (await Permission.storage.request().isGranted) {
    // Either the permission was already granted before or the user just granted it.
    debugPrint("$TAG STORAGE PERMISSION GRANTED");
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppState()),
    ChangeNotifierProvider(create: (_) => TPlayerState()),
  ], child: const Root()));
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late TPlayerState _playerState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _playerState.player.playerStateStream.listen((state) {
          _playerState.setIsPlaying(state.playing);
          tprint(ModalRoute.of(context)?.settings.name);
          // If the player is not currently playing
          if (!_playerState.hasPlayed && state.playing) _playerState.setHasPlayed(true);
      });
      _playerState.player.durationStream.listen((val) {
        if (val != null) {
          _playerState.setDuration(val);
        }
      });

      _playerState.player.positionStream.listen((val) {
        _playerState.setPosition(val);
      });

      _playerState.player.currentIndexStream.listen((val) {
        if (val != null) {
          _playerState.setCurrIndex(val);
          _playerState.setCurrTrack(_playerState.currPlaylist[val]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _playerState = context.watch<TPlayerState>();
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      routes: {
        '/': (context) => TRoute( const MyApp()),
        "/album-tracks" : (context) => TRoute(const AlbumTracks())
      },
      initialRoute: '/',
    );
  }
}

Widget TRoute(Widget child){
  return Stack(
    children: [
      child,
      const PlayerView()
    ],
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  int _selectedIndex = 0;
  final double _iconSize = 20;
  final List<Widget> _mainPages = [const HomePage(), const LibraryPage()];
  bool _online = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _playerState = context.watch<TPlayerState>();
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => const NavMenu());
                    },
                    icon: const Icon(CupertinoIcons.bars),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Online",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 35,
                        height: 30,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Switch(
                            value: _online,
                            onChanged: (bool val) {
                              setState(() {
                                _online = val;
                              });
                            },
                            activeColor: orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.ellipsis_vertical),
                    iconSize: 20,
                  )
                ],
              ),
            ),
            body: _mainPages.elementAt(_selectedIndex),
            bottomNavigationBar: Container(
                color: const Color.fromARGB(104, 15, 15, 15),
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        iconSize: _iconSize,
                        color: _selectedIndex == 0 ? orange_2 : Colors.white,
                        onPressed: () {
                          _onItemTapped(0);
                        },
                        icon: const Icon(CupertinoIcons.home)),
                    IconButton(
                        iconSize: _iconSize,
                        color: _selectedIndex == 1 ? orange_2 : Colors.white,
                        onPressed: () {
                          _onItemTapped(1);
                        },
                        icon: const Icon(CupertinoIcons.bookmark)),
                    IconButton(
                        iconSize: _iconSize,
                        color: _selectedIndex == 2 ? orange_2 : Colors.white,
                        onPressed: () {
                          _onItemTapped(2);
                        },
                        icon: const Icon(CupertinoIcons.search)),
                    IconButton(
                        iconSize: _iconSize,
                        color: _selectedIndex == 3 ? orange_2 : Colors.white,
                        onPressed: () {
                          _onItemTapped(3);
                        },
                        icon: const Icon(CupertinoIcons.info)),
                  ],
                )));
  }
}


class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("First Route"),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Second Route"),
      ElevatedButton(onPressed: () {}, child: const Text("First Route"))
    ]);
  }
}
