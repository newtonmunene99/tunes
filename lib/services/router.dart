import 'package:flutter/material.dart';
import 'package:tunes/pages/now_playing_list.dart';
import 'package:tunes/pages/setup.dart';
import 'package:tunes/pages/splash.dart';
import 'package:tunes/pages/tabs.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashPage());
      case '/tabs':
        return MaterialPageRoute(builder: (_) => TabsPage());
      case '/nowplayinglist':
        return MaterialPageRoute(builder: (_) => NowPlayingList());
      case '/setup':
        return MaterialPageRoute(builder: (_) => SetupPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
