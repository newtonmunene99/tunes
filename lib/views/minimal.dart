import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../services/audio.dart';

class MinimalNowPlayingPage extends StatefulWidget {
  final SongInfo song;
  final AudioService audioService;
  final Function onCloseTapped;

  MinimalNowPlayingPage(
      {@required this.song, @required this.audioService, this.onCloseTapped});
  @override
  _MinimalNowPlayingPageState createState() => _MinimalNowPlayingPageState();
}

class _MinimalNowPlayingPageState extends State<MinimalNowPlayingPage>
    with SingleTickerProviderStateMixin {
  AnimationController _playAnimation;
  bool playing = false;
  Color dominantColor = Colors.white;

  @override
  void initState() {
    _playAnimation = AnimationController(
        vsync: this, value: 0.0, duration: Duration(milliseconds: 100));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.9,
              child: AnimatedContainer(
                duration: Duration(
                  milliseconds: 200,
                ),
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.of(context).primaryColor,
                      blurRadius: 50.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  child: FadeInImage(
                    placeholder: NetworkImage(
                        "https://images.unsplash.com/photo-1500099817043-86d46000d58f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80"),
                    image: FileImage(
                      File.fromUri(
                        Uri.parse(
                          widget.song.albumArtwork,
                        ),
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${widget.song.title}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                    TextSpan(
                        text: ' - ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        )),
                    TextSpan(
                      text: ' ${widget.song.artist}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                softWrap: false,
              ),
            ),
            Text(widget.song.album),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  IconButton(
                    icon: widget.audioService.repeatState == RepeatState.OFF
                        ? Icon(Icons.repeat)
                        : widget.audioService.repeatState == RepeatState.ONE
                            ? Icon(Icons.repeat_one)
                            : Icon(
                                Icons.repeat,
                                color: Colors.red,
                              ),
                    alignment: Alignment.center,
                    onPressed: () {
                      if (widget.audioService.repeatState == RepeatState.OFF) {
                        setState(() {
                          widget.audioService.repeatState = RepeatState.ON;
                        });
                      } else if (widget.audioService.repeatState ==
                          RepeatState.ON) {
                        setState(() {
                          widget.audioService.repeatState = RepeatState.ONE;
                        });
                      } else {
                        setState(() {
                          widget.audioService.repeatState = RepeatState.OFF;
                        });
                      }
                    },
                    padding: EdgeInsets.zero,
                  ),
                  IconButton(
                    icon: Icon(
                      Feather.skip_back,
                      color: Theme.of(context).primaryColor,
                      size: 30.0,
                    ),
                    onPressed: () {
                      widget.audioService.previous();
                    },
                    padding: EdgeInsets.zero,
                  ),
                  StreamBuilder<AudioPlayerState>(
                    stream:
                        widget.audioService.audioPlayer.onPlayerStateChanged,
                    builder: (context, snapshot) {
                      return IconButton(
                        icon: Icon(
                          snapshot.data == AudioPlayerState.PAUSED
                              ? Feather.play
                              : Feather.pause,
                          color: Theme.of(context).primaryColor,
                          size: 50.0,
                        ),
                        onPressed: () {
                          if (snapshot.data == AudioPlayerState.PAUSED) {
                            widget.audioService.resume();
                          } else if (snapshot.data ==
                              AudioPlayerState.PLAYING) {
                            widget.audioService.pause();
                          }
                        },
                        padding: EdgeInsets.zero,
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Feather.skip_forward,
                      color: Theme.of(context).primaryColor,
                      size: 30.0,
                    ),
                    onPressed: () {
                      widget.audioService.next();
                    },
                    padding: EdgeInsets.zero,
                  ),
                  IconButton(
                    icon: Icon(
                        widget.audioService.shuffleState == ShuffleState.OFF
                            ? MaterialCommunityIcons.shuffle_disabled
                            : MaterialCommunityIcons.shuffle),
                    onPressed: () {
                      if (widget.audioService.shuffleState ==
                          ShuffleState.OFF) {
                        setState(() {
                          widget.audioService.shuffle();
                          widget.audioService.shuffleState = ShuffleState.ON;
                        });
                      } else if (widget.audioService.shuffleState ==
                          ShuffleState.ON) {
                        setState(() {
                          widget.audioService.unshuffle();
                          widget.audioService.shuffleState = ShuffleState.OFF;
                        });
                      }
                    },
                    padding: EdgeInsets.zero,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: widget.onCloseTapped,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.song.album,
                      softWrap: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: PopupMenuButton(
                      icon: Icon(Icons.more_horiz),
                      onSelected: (val) async {
                        if (val == "playlist") {
                          Navigator.pushNamed(
                            context,
                            "/nowplayinglist",
                          );
                        }
                      },
                      itemBuilder: (context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          value: "playlist",
                          child: Text("Playlist"),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
