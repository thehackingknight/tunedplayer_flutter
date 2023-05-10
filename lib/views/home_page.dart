import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/track_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // Main column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            H1("Recently Played"),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: const [
                  TrackCard(),
                  TrackCard(),
                  TrackCard(),
                  TrackCard(),
                  TrackCard(),
                  TrackCard(),
                ])),
            const SizedBox(
              height: 15,
            ),
            H1("Favorites"),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: const [
                  TrackCard(),
                  TrackCard(),
                  TrackCard(),
                  TrackCard(),
                  TrackCard(),
                  TrackCard(),
                ])),
            const SizedBox(
              height: 15,
            ),
            H1("Playlists"),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: const [
                  TrackCard(),
                  TrackCard(),
                  TrackCard(),
                  TrackCard(),
                  TrackCard(),
                  TrackCard(),
                ])),


            /*---------------Bottom spacer----------------*/
            const SizedBox(
              height: 54,
            )
          ],
        ),
      ),
    );
  }
}

Widget H1(String txt) {
  return Text(
    txt,
    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
  );
}
