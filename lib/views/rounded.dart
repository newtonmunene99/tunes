import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tunes/types/types.dart';
import '../services/audio.dart';

class RoundedNowPlayingPage extends StatefulWidget {
  final OnPanelSlideCallback onPanelSlide;

  RoundedNowPlayingPage({this.onPanelSlide});
  @override
  _RoundedNowPlayingPageState createState() => _RoundedNowPlayingPageState();
}

class _RoundedNowPlayingPageState extends State<RoundedNowPlayingPage>
    with SingleTickerProviderStateMixin {
  AnimationController _playAnimation;
  bool playing = false;

  @override
  void initState() {
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
              collapsed: Container(
                height: 60,
                color: Colors.red,
              ),
              panel: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 40.0, bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {},
                                ),
                                Text(
                                  snapshot.hasData ? snapshot.data.album : '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.more_horiz),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.width * 0.9,
                            child: Card(
                              margin: EdgeInsets.all(0),
                              child: ClipRRect(
                                child: snapshot.data.albumArtwork != null
                                    ? FadeInImage(
                                        placeholder: NetworkImage(
                                            "https://images.unsplash.com/photo-1500099817043-86d46000d58f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80"),
                                        image: FileImage(File.fromUri(Uri.parse(
                                            snapshot.data.albumArtwork))),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        "https://images.unsplash.com/photo-1500099817043-86d46000d58f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80",
                                        fit: BoxFit.cover,
                                      ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5.0,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            snapshot.hasData ? snapshot.data.title : '',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                              letterSpacing: 1.0,
                            ),
                            softWrap: true,
                          ),
                          Text(snapshot.hasData ? snapshot.data.artist : ''),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.skip_previous,
                                    size: 50.0,
                                  ),
                                  onPressed: () {
                                    audioService.previous();
                                  },
                                ),
                                IconButton(
                                  icon: AnimatedIcon(
                                    icon: AnimatedIcons.play_pause,
                                    size: 50.0,
                                    progress: _playAnimation,
                                  ),
                                  onPressed: () {
                                    if (audioService.audioPlayer.state ==
                                        AudioPlayerState.PLAYING) {
                                      audioService.pause();
                                      _playAnimation.reverse();
                                    } else if (audioService.audioPlayer.state ==
                                        AudioPlayerState.PAUSED) {
                                      audioService.play(snapshot.data);
                                      _playAnimation.forward();
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.skip_next,
                                    size: 50.0,
                                  ),
                                  onPressed: () {
                                    audioService.next();
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60.0,
                          )
                        ],
                      ),
                    ),
                  ),
                  SlidingUpPanel(
                    minHeight: 60.0,
                    panel: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 32.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              snapshot.hasData ? snapshot.data.title : '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20.0),
                              softWrap: true,
                            ),
                            Text(snapshot.hasData ? snapshot.data.artist : ''),
                          ],
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        20.0,
                      ),
                      topRight: Radius.circular(
                        20.0,
                      ),
                    ),
                  )
                ],
              ));
        } else {
          return SizedBox(
            height: 0.0,
          );
        }
      },
    );
  }
}
