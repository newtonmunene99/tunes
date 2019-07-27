import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';
import '../services/audio.dart';

class NowPlayingList extends StatefulWidget {
  @override
  _NowPlayingListState createState() => _NowPlayingListState();
}

class _NowPlayingListState extends State<NowPlayingList> {
  @override
  Widget build(BuildContext context) {
    var audioService = Provider.of<AudioService>(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ReorderableListView(
                children: audioService.getnowplayingsongs
                    .map((song) => ListTile(
                          key: GlobalKey(),
                          title: Text("${song.title}"),
                          subtitle: Text("${song.album}"),
                        ))
                    .toList(),
                onReorder: (previous, current) async {
                  await audioService.reorder(previous, current - 1);
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
