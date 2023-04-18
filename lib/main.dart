import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:tunedplayer/views/library_page.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  int _selectedIndex = 0;
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
                      style: TextStyle(fontSize: 12),
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
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Color.fromRGBO(60, 60, 60, 0.3),
            selectedItemColor: orange_2,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.book), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.search), label: ""),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ));
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
