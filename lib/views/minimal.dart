import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
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
        vsync: this, value: 0.0, duration: Duration(milliseconds: 200));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Theme.of(context).primaryColor],
            )),
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
              child: Card(
                margin: EdgeInsets.all(0),
                child: ClipRRect(
                  child: FadeInImage(
                    placeholder: NetworkImage(
                        "https://images.unsplash.com/photo-1500099817043-86d46000d58f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80"),
                    image: FileImage(
                        File.fromUri(Uri.parse(widget.song.albumArtwork))),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(00.0),
                ),
                elevation: 5.0,
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
                    icon: Icon(Icons.repeat),
                    alignment: Alignment.center,
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      size: 50.0,
                    ),
                    onPressed: () {
                      widget.audioService.previous();
                    },
                    padding: EdgeInsets.zero,
                  ),
                  IconButton(
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      size: 60.0,
                      progress: _playAnimation,
                    ),
                    onPressed: () {
                      if (widget.audioService.audioPlayer.state ==
                          AudioPlayerState.PLAYING) {
                        widget.audioService.pause();
                        _playAnimation.reverse();
                      } else if (widget.audioService.audioPlayer.state ==
                          AudioPlayerState.PAUSED) {
                        widget.audioService.play(widget.song);
                        _playAnimation.forward();
                      }
                    },
                    padding: EdgeInsets.zero,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      size: 50.0,
                    ),
                    onPressed: () {
                      widget.audioService.next();
                    },
                    padding: EdgeInsets.zero,
                  ),
                  IconButton(
                    icon: Icon(Icons.shuffle),
                    onPressed: () {},
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
                  Text(
                    widget.song.album,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
                  Container(
                    child: PopupMenuButton(
                      icon: Icon(Icons.more_horiz),
                      onSelected: (val) {},
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
