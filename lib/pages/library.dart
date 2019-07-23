import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';
import '../services/audio.dart';
import '../widgets/song_tile.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var audioService = Provider.of<AudioService>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Library",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              titlePadding: EdgeInsets.only(bottom: 20, left: 20),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                leading: Icon(Icons.shuffle),
                title: Text("Shuffle"),
              ),
            ]),
          ),
          StreamBuilder<List<SongInfo>>(
              stream: audioService.songs,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) => SongTile(
                        title: snapshot.data[index].title,
                        artist: snapshot.data[index].artist,
                        albumCover: snapshot.data[index].albumArtwork,
                        onTap: () {
                          audioService.play(snapshot.data[index]);
                        },
                      ),
                      childCount: snapshot.data.length,
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text("No Songs"),
                      ],
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
