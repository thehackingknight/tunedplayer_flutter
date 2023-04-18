import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:tunedplayer/views/library_page.dart';
import 'package:tunedplayer/views/player_view.dart';
import 'package:tunedplayer/views/tracks_page.dart';

import 'constants/index.dart';

Future<void> main() async {
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
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: Stack(
        children: const [MyApp(), PlayerView()],
      ),
    );
  }
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
  bool _deviceFiles = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TunedPlayer',
        theme: ThemeData.dark(useMaterial3: true),
        home: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "device files",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 30,
                        height: 23,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Switch(
                            value: _deviceFiles,
                            onChanged: (bool val) {
                              setState(() {
                                _deviceFiles = val;
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
            drawer: Drawer(
              width: 200,
              child: ListView(
                children: const [
                  ListTile(
                    title: Text("Home"),
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
                ))));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Home Page"),
    );
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
