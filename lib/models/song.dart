import 'dart:typed_data';

class Song {
  final String title;
  final String album;
  final String artist;
  final Uint8List albumCover;
  final String comment;
  final String year;
  final String track;
  final String genre;
  final String copyright;
  final String encoder;
  final String lyrics;
  final String length;

  Song({
    this.title,
    this.album,
    this.artist,
    this.albumCover,
    this.comment,
    this.year,
    this.track,
    this.genre,
    this.copyright,
    this.encoder,
    this.lyrics,
    this.length,
  });

  factory Song.fromMap(Map data) {
    return Song(
      title: data['title'] ?? 'Unknown',
      album: data['album'] ?? 'Unknown',
      artist: data['TPE2'] ?? 'Unknown',
      albumCover: data['APIC'] != null
          ? Uint8List.fromList(data['APIC'].imageData) ?? null
          : null,
      comment: data['comment'] ?? null,
      year: data['year'] ?? null,
      track: data['track'] ?? null,
      genre: data['genre'] ?? null,
      copyright: data['TCOP'] ?? null,
      encoder: data['TENC'] ?? null,
      lyrics: data['USLT'] ?? null,
      length: data['TLEN'] ?? null,
    );
  }

  Map get map {
    return {
      "title": this.title,
      "album": this.album,
      "artist": this.artist,
      "albumCover": this.albumCover,
      "comment": this.comment,
      "year": this.year,
      "track": this.track,
      "genre": this.genre,
      "copyright": this.copyright,
      "encoder": this.encoder,
      "lyrics": this.lyrics,
    };
  }
}
