import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:tunedplayer/constants/globals.dart';
import 'package:tunedplayer/constants/styles.dart';

import '../constants/index.dart';
import '../models/provider_store.dart';
import '../widgets/album_tracks.dart';
import '../widgets/widgets.dart';

class AlbumsTab extends StatefulWidget {
  const AlbumsTab({super.key});

  @override
  State<AlbumsTab> createState() => _AlbumsTabState();
}

class _AlbumsTabState extends State<AlbumsTab> {
  late TPlayerState _playerState;
  void getAlbums() async {
    var albums = await audioQuery.queryAlbums();
    _playerState.setAlbums(albums);
  }
  @override
  void initState() {
    super.initState();

    getAlbums();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      var screenW = MediaQuery.of(context).size.width;
      context.read<AppState>().setScreenWidth(screenW);

    });
  }

  @override
  Widget build(BuildContext context) {
    _playerState = context.watch();
    final AppState _appState = context.watch();

    const numGrids = 10;
    const numRows = 3;
    return _playerState.albums.isEmpty ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const[
         Icon(CupertinoIcons.music_albums, size: 100,),
        SizedBox(
          height: 5,
        ),
        Text("EMPTY", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 5),)
      ],
    ) : NotificationListener(
      onNotification: (SizeChangedLayoutNotification notification) {
        Future.delayed(const Duration(milliseconds: 300), () {
          tprint('size changed');
          var screenW = MediaQuery.of(context).size.width;
          context.read<AppState>().setScreenWidth(screenW);
        });
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numRows,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 60.0,
                  ),
                  itemCount: _playerState.albums.length,
                  itemBuilder: (context, index) {
                    double screenWidth = MediaQuery.of(context).size.width;
                    double imgWidth =
                        screenWidth * 0.31666666666666665; //152px ref=480;
                    var album = _playerState.albums[index];
                    return Wrap(children: [
                      Container(
                        //color: Colors.black26,
                        //height: 200,
                        child: InkWell(
                          onTap: () {
                            _playerState.setCurrAlbum(album);
                            Navigator.of(context).pushNamed("/album-tracks");
                          },
                          child: Column(
                            children: [
                              Container(
                                width: imgWidth, //152px ref=480
                                height: imgWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.black26),
                                child: const Icon(CupertinoIcons.music_albums, size: 50,),
                                // child: Image.asset("assets/images/pistol.jpg"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    SizedText(
                                        txt: album.album,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                    w: 250),
                                    SizedText(
                                       txt: album.artist!, style: const TextStyle(), w: 250)// TODO
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
