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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      var screenW = MediaQuery.of(context).size.width;
      context.read<AppState>().setScreenWidth(screenW);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TPlayerState _playerState = context.watch();
    final AppState _appState = context.watch();

    const numGrids = 10;
    const numRows = 3;
    return NotificationListener(
      onNotification: (SizeChangedLayoutNotification notification) {
        Future.delayed(Duration(milliseconds: 300), () {
          print('size changed');
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
                        color: Colors.black26,
                        //height: 200,
                        child: InkWell(
                          onTap: () {
                            _playerState.setUseCurrPlaylist(true);
                            showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return AlbumTracks(album: album);
                                    })
                                .whenComplete(() =>
                                    _playerState.setUseCurrPlaylist(false));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: imgWidth, //152px ref=480
                                height: imgWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.black),
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
                                       txt: album.artist!, style: TextStyle(), w: 250)// TODO
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
