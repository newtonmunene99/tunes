import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:tunes/database/database.dart';
import 'package:tunes/services/audio.dart';
import 'package:tunes/services/router.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

void main() => runApp(TunesApp());

class TunesApp extends StatefulWidget {
  @override
  _TunesAppState createState() => _TunesAppState();
}

class _TunesAppState extends State<TunesApp> {
  kiwi.Container container = kiwi.Container();
  AudioService audioService;

  @override
  void initState() {
    container.registerSingleton((c) => MusicDatabase());
    container.registerSingleton((c) => AudioService());

    audioService = container.resolve<AudioService>();

    audioService.getMusicFiles();

    super.initState();
  }

  @override
  void dispose() {
    audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MusicDatabase>.value(
          value: container.resolve<MusicDatabase>(),
        ),
        Provider<AudioService>.value(
          value: audioService,
        )
      ],
      child: ClipRRect(
        child: StreamBuilder<PaletteGenerator>(
            stream: audioService.palette,
            builder: (context, snapshot) {
              return MaterialApp(
                title: "Tunes",
                onGenerateRoute: Router.generateRoute,
                initialRoute: "/",
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    color: Colors.white,
                  ),
                  primaryColor: snapshot.hasData
                      ? snapshot.data.vibrantColor != null
                          ? snapshot.data.vibrantColor.color
                          : snapshot.data.dominantColor.color
                      : Colors.blue[900],
                ),
              );
            }),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
