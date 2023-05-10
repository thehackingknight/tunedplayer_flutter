import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrackCard extends StatefulWidget {
  const TrackCard({Key? key}) : super(key: key);

  @override
  State<TrackCard> createState() => _TrackCardState();
}

class _TrackCardState extends State<TrackCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imgWidth = 140;
    return Container(
      margin: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: imgWidth,
            height: imgWidth,
            decoration:  BoxDecoration(
                color: Colors.black26 ,
              borderRadius: BorderRadius.circular(4)
            ),
            child: const Icon(CupertinoIcons.music_note_2,size: 40,),
          ),
          const Text("Track title", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
          const Text("Artist", style: TextStyle(color: Colors.white70),),
        ],
      ),
    );
  }
}
