import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:logging/logging.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:rxdart/rxdart.dart';

class AudioService {
  FlutterAudioQuery audioQuery;
  AudioPlayer audioPlayer;
  List<SongInfo> nowplayinglist;
  final Logger log = new Logger('AudioService');

  BehaviorSubject<PaletteGenerator> _colorPaletteController;
  BehaviorSubject<SongInfo> _currentlyPlayingController;
  BehaviorSubject<List<SongInfo>> _songsController;
  BehaviorSubject<List<ArtistInfo>> _artistsController;
  BehaviorSubject<List<AlbumInfo>> _albumsController;

  AudioService() {
    audioQuery = FlutterAudioQuery();
    audioPlayer = AudioPlayer();
    nowplayinglist = [];
    _songsController = BehaviorSubject<List<SongInfo>>();
    _currentlyPlayingController = BehaviorSubject<SongInfo>();
    _colorPaletteController = BehaviorSubject<PaletteGenerator>();
    _artistsController = BehaviorSubject<List<ArtistInfo>>();
    _albumsController = BehaviorSubject<List<AlbumInfo>>();
  }

  Stream<PaletteGenerator> get palette => _colorPaletteController.stream;
  Stream<SongInfo> get currentyPlaying => _currentlyPlayingController.stream;
  Stream<List<SongInfo>> get songs => _songsController.stream;
  Stream<List<ArtistInfo>> get artists => _artistsController.stream;
  Stream<List<AlbumInfo>> get albums => _albumsController.stream;

  getMusicFiles() async {
    var songs = await audioQuery.getSongs();
    _songsController.add(songs);

    var albums = await audioQuery.getAlbums();
    _albumsController.add(albums);

    var artists = await audioQuery.getArtists();
    _artistsController.add(artists);

    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == AudioPlayerState.COMPLETED) {
        next();
      }
    });

    audioPlayer.onAudioPositionChanged.listen((onData) {
      log.fine(onData.inSeconds);
    });
  }

  Future<void> play(SongInfo song) async {
    if (audioPlayer.state == AudioPlayerState.PLAYING) {
      await stop();
      _currentlyPlayingController.add(song);
      _getProminentColor();
      await audioPlayer.play(song.filePath, isLocal: true);
    } else {
      _currentlyPlayingController.add(song);
      _getProminentColor();
      await audioPlayer.play(song.filePath, isLocal: true);
    }
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

  Future<void> pause() async {
    await audioPlayer.pause();
  }

  Future<void> stop() async {
    _currentlyPlayingController.add(null);
    await audioPlayer.stop();
  }

  Future<void> next() async {
    var current = _currentlyPlayingController.value;

    var songslist = _songsController.value;
    int nextIndex = songslist.indexOf(current) + 1;

    if (nextIndex < songslist.length) {
      await play(songslist[nextIndex]);
    }
  }

  Future<void> previous() async {
    var current = _currentlyPlayingController.value;

    var songslist = _songsController.value;
    int previousIndex = songslist.indexOf(current) - 1;
    if (previousIndex > -1) {
      await play(songslist[previousIndex]);
    }
  }

  dispose() {
    _songsController.close();
    _albumsController.close();
    _artistsController.close();
    _currentlyPlayingController.close();
    _colorPaletteController.close();
  }
}
