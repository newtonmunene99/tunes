import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:logging/logging.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:rxdart/rxdart.dart';

enum RepeatState { ON, OFF, ONE }
enum ShuffleState { ON, OFF }

class AudioService {
  FlutterAudioQuery _audioQuery;
  AudioPlayer audioPlayer;
  RepeatState repeatState = RepeatState.OFF;
  ShuffleState shuffleState = ShuffleState.OFF;
  final Logger log = new Logger('AudioService');

  BehaviorSubject<PaletteGenerator> _colorPaletteController;
  BehaviorSubject<SongInfo> _currentlyPlayingController;
  BehaviorSubject<List<SongInfo>> _songsController;
  BehaviorSubject<List<SongInfo>> _nowPlayingSongsController;
  BehaviorSubject<List<ArtistInfo>> _artistsController;
  BehaviorSubject<List<AlbumInfo>> _albumsController;

  AudioService() {
    _audioQuery = FlutterAudioQuery();
    audioPlayer = AudioPlayer();

    _songsController = BehaviorSubject<List<SongInfo>>();
    _nowPlayingSongsController = BehaviorSubject<List<SongInfo>>();
    _currentlyPlayingController = BehaviorSubject<SongInfo>();
    _colorPaletteController = BehaviorSubject<PaletteGenerator>();
    _artistsController = BehaviorSubject<List<ArtistInfo>>();
    _albumsController = BehaviorSubject<List<AlbumInfo>>();
  }

  Stream<PaletteGenerator> get palette => _colorPaletteController.stream;
  Stream<SongInfo> get currentyPlaying => _currentlyPlayingController.stream;
  Stream<List<SongInfo>> get songs => _songsController.stream;
  Stream<List<SongInfo>> get nowplayingsongs =>
      _nowPlayingSongsController.stream;
  List<SongInfo> get getnowplayingsongs => _nowPlayingSongsController.value;
  Stream<List<ArtistInfo>> get artists => _artistsController.stream;
  Stream<List<AlbumInfo>> get albums => _albumsController.stream;

  getMusicFiles() async {
    var tracks = await _audioQuery.getSongs();
    _songsController.add(tracks);

    this.songs.listen((songslist) {
      this._nowPlayingSongsController.add(songslist);
    });

    var albums = await _audioQuery.getAlbums();
    _albumsController.add(albums);

    var artists = await _audioQuery.getArtists();
    _artistsController.add(artists);

    audioPlayer.onPlayerCompletion.listen((completed) {
      if (repeatState == RepeatState.ONE) {
        play(_currentlyPlayingController.value);
      } else {
        next();
      }
    });

    // audioPlayer.onAudioPositionChanged.listen((onData) {
    //   log.fine(onData.inSeconds);
    // });
  }

  Future<void> play(SongInfo song) async {
    if (audioPlayer.state == AudioPlayerState.PLAYING) {
      await stop();
      _currentlyPlayingController.add(song);
      _getProminentColor();
      await audioPlayer.play(
        song.filePath,
        isLocal: true,
        respectSilence: false,
      );
    } else {
      _currentlyPlayingController.add(song);
      _getProminentColor();
      await audioPlayer.play(
        song.filePath,
        isLocal: true,
        respectSilence: false,
      );
    }
  }

  void shuffle() {
    var list = List<SongInfo>.from(_nowPlayingSongsController.value);
    list.shuffle();
    _nowPlayingSongsController.add(list);
  }

  void unshuffle() {
    var list = List<SongInfo>.from(_songsController.value);
    log.fine(list[0].title);
    _nowPlayingSongsController.add(list);
    log.fine(list[0].title);
  }

  Future<void> reorder(int previous, int current) async {
    log.fine('$previous, $current');
    var list = _nowPlayingSongsController.value;
    var song = list.removeAt(previous);
    return list.insert(current, song);
    // log.fine("${list[current].title}");
    // log.fine("${list[previous].title}");

    // _nowPlayingSongsController.add(list);
  }

  void _getProminentColor() async {
    try {
      var palette = await PaletteGenerator.fromImageProvider(
        _currentlyPlayingController.value.albumArtwork != null
            ? FileImage(File.fromUri(
                Uri.parse(_currentlyPlayingController.value.albumArtwork)))
            : NetworkImage(
                "https://images.unsplash.com/photo-1500099817043-86d46000d58f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80"),
      );
      _colorPaletteController.add(palette);
    } catch (e) {
      log.shout(e);
    }
  }

  Future<void> resume() async {
    await audioPlayer.resume();
  }

  Future<void> pause() async {
    await audioPlayer.pause();
  }

  Future<void> stop() async {
    _currentlyPlayingController.add(null);
    await audioPlayer.stop();
  }

  Future<void> next() async {
    var current = _currentlyPlayingController.value;

    var songslist = _nowPlayingSongsController.value;
    int nextIndex = songslist.indexOf(current) + 1;

    if (nextIndex < songslist.length) {
      await play(songslist[nextIndex]);
    }
  }

  Future<void> previous() async {
    var current = _currentlyPlayingController.value;

    var songslist = _nowPlayingSongsController.value;
    int previousIndex = songslist.indexOf(current) - 1;
    if (previousIndex > -1) {
      await play(songslist[previousIndex]);
    }
  }

  dispose() {
    _songsController.close();
    _nowPlayingSongsController.close();
    _albumsController.close();
    _artistsController.close();
    _currentlyPlayingController.close();
    _colorPaletteController.close();
  }
}
