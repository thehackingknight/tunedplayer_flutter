import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tunedplayer/constants/index.dart';
import 'package:tunedplayer/widgets/widgets.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({super.key});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  // STATE //
  bool _isMinPlayer = false;
  // END STATE //

  @override
  Widget build(BuildContext context) {
    var winW = MediaQuery.of(context).size.width;
    var winH = MediaQuery.of(context).size.height;
    return Positioned(
      bottom: _isMinPlayer ? 50 : 0,
      height: _isMinPlayer ? 60 : winH,
      width: winW,
      child: Card(
        child: _isMinPlayer ? MinPlayer() : FullPlayer(),
        color: _isMinPlayer
            ? const Color.fromARGB(104, 15, 15, 15)
            : const Color.fromARGB(255, 19, 19, 19),
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
          TapRegion(
            onTapInside: (event) {
              setState(() {
                _isMinPlayer = !_isMinPlayer;
              });
            },
            child: Column(
              children: [
                SizedText("TrackTitleaaaaaaaaaaaaggggggggggggggffffffffffaaa",
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    w: 260, h: 20),
                SizedText("Track Artist", const TextStyle(fontSize: 11),
                    w: 260, h: 15)
              ],
            ),
          ),
          SizedBox(
              width: 24,
              child: IconButton(
                onPressed: () {},
                icon: Icon(CupertinoIcons.play),
              )),
        ],
      ),
    );
  }

  Widget FullPlayer() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _isMinPlayer = !_isMinPlayer;
                  });
                },
                icon: const Icon(CupertinoIcons.arrow_left))
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // Track cover disk
            width: 200,
            height: 200,
            margin: const EdgeInsets.only(top: 60),
            decoration: const BoxDecoration(
                color: orange,
                borderRadius: BorderRadius.all(Radius.circular(100))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedText(
                      "Track Title",
                      const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                  SizedText("Tonics", const TextStyle(fontSize: 15)),
                  SizedText("Album", const TextStyle(fontSize: 15)),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.ellipsis_vertical))
            ],
          ),
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
          SizedBox(
              width: 300,
              child: CupertinoSlider(
                value: .4,
                onChanged: (v) {},
              )),
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
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.play_circle,
                  size: 40,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.chevron_forward)),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.shuffle,
                  size: 18,
                )),
          ])
        ],
      )
    ]);
  }
}
