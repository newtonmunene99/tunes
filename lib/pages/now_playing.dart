import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tunes/types/types.dart';
import 'package:tunes/views/minimal.dart';
import '../services/audio.dart';

class NowPlayingPage extends StatefulWidget {
  final OnPanelSlideCallback onPanelSlide;

  NowPlayingPage({this.onPanelSlide});
  @override
  _NowPlayingPageState createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  bool playing = false;
  PanelController _panelController;

  @override
  void initState() {
    _panelController = PanelController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var audioService = Provider.of<AudioService>(context);
    return StreamBuilder<SongInfo>(
      stream: audioService.currentyPlaying,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SlidingUpPanel(
            onPanelSlide: widget.onPanelSlide,
            maxHeight: MediaQuery.of(context).size.height,
            minHeight: 70.0,
            parallaxOffset: 1.0,
            controller: _panelController,
            collapsed: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: 60,
                child: ListTile(
                  leading: AspectRatio(
                    aspectRatio: 1,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        child: snapshot.data.albumArtwork != null
                            ? FadeInImage(
                                placeholder: NetworkImage(
                                    "https://images.unsplash.com/photo-1500099817043-86d46000d58f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80"),
                                image: FileImage(File.fromUri(
                                    Uri.parse(snapshot.data.albumArtwork))),
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                "https://images.unsplash.com/photo-1500099817043-86d46000d58f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80",
                                fit: BoxFit.cover,
                              ),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      elevation: 5.0,
                    ),
                  ),
                  title: Text(
                    snapshot.data.title,
                    softWrap: false,
                  ),
                  subtitle: Text(
                    snapshot.data.artist,
                    softWrap: false,
                  ),
                  trailing: StreamBuilder<AudioPlayerState>(
                    stream: audioService.audioPlayer.onPlayerStateChanged,
                    builder: (context, snapshot) {
                      return IconButton(
                        icon: snapshot.data == AudioPlayerState.PAUSED
                            ? Icon(
                                Feather.play,
                                color: Theme.of(context).primaryColor,
                              )
                            : Icon(
                                Feather.pause,
                                color: Theme.of(context).primaryColor,
                              ),
                        onPressed: () {
                          if (snapshot.data == AudioPlayerState.PAUSED) {
                            audioService.resume();
                          } else if (snapshot.data ==
                              AudioPlayerState.PLAYING) {
                            audioService.pause();
                          }
                        },
                        padding: EdgeInsets.zero,
                      );
                    },
                  ),
                )),
            panel: MinimalNowPlayingPage(
              song: snapshot.data,
              audioService: audioService,
              onCloseTapped: () => _panelController.animatePanelToPosition(0.0),
            ),
          );
        } else {
          return SizedBox(
            height: 0.0,
          );
        }
      },
    );
  }
}
