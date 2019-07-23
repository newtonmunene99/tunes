import 'package:flutter/material.dart';
import 'package:permission/permission.dart';

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: 1.0);
    super.initState();
  }

  Future<bool> _requestPermissions() async {
    try {
      List<Permissions> permissionGranted =
          await Permission.getPermissionsStatus([PermissionName.Storage]);
      if (permissionGranted[0].permissionStatus == PermissionStatus.allow ||
          permissionGranted[0].permissionStatus == PermissionStatus.always ||
          permissionGranted[0].permissionStatus == PermissionStatus.whenInUse) {
        return true;
      } else {
        List<Permissions> permissionStatus =
            await Permission.requestPermissions([PermissionName.Storage]);
        if (permissionStatus[0].permissionStatus == PermissionStatus.allow ||
            permissionStatus[0].permissionStatus == PermissionStatus.always ||
            permissionStatus[0].permissionStatus ==
                PermissionStatus.whenInUse) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          _buildPermissionScreen(),
        ],
        controller: _pageController,
      ),
    );
  }

  Widget _buildPermissionScreen() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Hello there, Thank you for downloading Tunes. We'd like our permission to search for music",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: FlatButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Proceed",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              onPressed: () {
                _requestPermissions().then((status) {
                  Navigator.pushReplacementNamed(context, "/tabs");
                }).catchError((error) {
                  Navigator.pushReplacementNamed(context, "/tabs");
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: FlatButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
