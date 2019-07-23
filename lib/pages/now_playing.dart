import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
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

class _NowPlayingPageState extends State<NowPlayingPage>
    with SingleTickerProviderStateMixin {
  AnimationController _playAnimation;
  bool playing = false;
  PanelController _panelController;

  @override
  void initState() {
    _panelController = PanelController();
    _playAnimation = AnimationController(
        vsync: this, value: 0.0, duration: Duration(milliseconds: 200));

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
            minHeight: 60.0,
            parallaxOffset: 1.0,
            controller: _panelController,
            collapsed: Container(
              height: 60,
              color: Colors.red,
            ),
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
