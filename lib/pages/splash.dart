import 'dart:async';

import "package:flutter/material.dart";
import 'package:permission/permission.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _timeout();

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
        return false;
      }
    } catch (e) {
      throw e;
    }
  }

  void _timeout() {
    Timer(Duration(seconds: 1), () {
      Future.delayed(Duration.zero, () {
        _requestPermissions().then((status) {
          if (status) {
            Navigator.pushReplacementNamed(context, "/tabs");
          } else {
            Navigator.pushReplacementNamed(context, "/setup");
          }
        }).catchError((error) {
          Navigator.pushReplacementNamed(context, "/setup");
          print(error);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Tunes"),
        ),
      ),
    );
  }
}
