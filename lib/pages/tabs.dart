import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import "package:flutter/material.dart";
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tunes/pages/albums.dart';
import 'package:tunes/pages/artists.dart';
import 'package:tunes/pages/home.dart';
import 'package:tunes/pages/library.dart';
import 'package:tunes/pages/now_playing.dart';
import 'package:tunes/pages/playlists.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex;
  TabController _tabsController;
  List<Widget> _pages = [
    HomePage(),
    LibraryPage(),
    ArtistsPage(),
    AlbumsPage(),
    PlaylistsPage(),
  ];
  double _tabHeight;

  @override
  void initState() {
    _currentIndex = 1;
    _tabHeight = 60.0;
    _tabsController = TabController(
      vsync: this,
      length: _pages.length,
      initialIndex: 1,
    );
    super.initState();
  }

  void _updateTab(int index) {
    _tabsController.animateTo(index);
    setState(() {
      _currentIndex = index;
    });
  }

  double _reverseNumber(double number, double min, double max) {
    return (max + min) - number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TabBarView(
            controller: _tabsController,
            children: _pages,
            physics: NeverScrollableScrollPhysics(),
          ),
          NowPlayingPage(
            onPanelSlide: (offset) {
              setState(() {
                _tabHeight = 60.0 * _reverseNumber(offset, 0.0, 1.0);
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 10),
        curve: Curves.linear,
        height: _tabHeight,
        child: BubbleBottomBar(
          opacity: .2,
          currentIndex: _currentIndex,
          onTap: (int index) {
            _updateTab(index);
          },
          borderRadius: BorderRadius.vertical(top: Radius.circular(0.0)),
          elevation: 8,
          hasInk: true, //new, gives a cute ink effect
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                  Icons.dashboard,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.dashboard,
                  color: Colors.red,
                ),
                title: Text("Tunes")),
            BubbleBottomBarItem(
                backgroundColor: Colors.deepPurple,
                icon: Icon(
                  Icons.access_time,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.access_time,
                  color: Colors.deepPurple,
                ),
                title: Text("Library")),
            BubbleBottomBarItem(
                backgroundColor: Colors.indigo,
                icon: Icon(
                  Icons.folder_open,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.folder_open,
                  color: Colors.indigo,
                ),
                title: Text("Artists")),
            BubbleBottomBarItem(
                backgroundColor: Colors.green,
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.menu,
                  color: Colors.green,
                ),
                title: Text("Albums"))
          ],
        ),
      ),
    );
  }
}
