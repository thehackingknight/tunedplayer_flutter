import 'package:flutter/foundation.dart';

class TrackSchema {
  final String title;
  final String? artist;
  final String? album;
  final String? path;
  final int? id;
  final int? albumId;
  TrackSchema(
      {required this.title,
      this.artist,
      this.path,
      this.album,
      this.id,
      this.albumId});
}
