import 'dart:io';
import 'package:flutter/material.dart';

class SongTile extends StatefulWidget {
  final String title;
  final String artist;
  final dynamic albumCover;
  final GestureTapCallback onTap;

  SongTile(
      {@required this.title,
      @required this.artist,
      this.albumCover,
      this.onTap});
  @override
  _SongTileState createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: ListTile(
        onTap: widget.onTap,
        leading: AspectRatio(
          aspectRatio: 1,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ClipRRect(
              child: widget.albumCover != null
                  ? FadeInImage(
                      placeholder: NetworkImage(
                          "https://images.unsplash.com/photo-1500099817043-86d46000d58f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80"),
                      image:
                          FileImage(File.fromUri(Uri.parse(widget.albumCover))),
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
          widget.title,
          softWrap: false,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
        subtitle: Text(
          widget.artist,
          softWrap: false,
          style: TextStyle(
            letterSpacing: 1.0,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.more_horiz),
          onPressed: () {},
        ),
      ),
    );
  }
}
