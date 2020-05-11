import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class Transitionpage extends StatefulWidget {
  @override
  _TransitionpageState createState() => _TransitionpageState();
}

class _TransitionpageState extends State<Transitionpage> {
  SharedPreferences sharedPreferences;
  String userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoggedInUser(context);
  }

  getLoggedInUser(BuildContext context) async {
    /**
     * Permission Handler
     *
     */
    final permission = Permission.storage;
    final status = await permission.status;
    switch (status) {
      case PermissionStatus.granted:
      // do something
        break;
      case PermissionStatus.denied:
      // do something
        break;
      case PermissionStatus.undetermined:
        var permissionStatus = await permission.request();
        print("*********************** STATUS IS $permissionStatus");
        break;
      case PermissionStatus.restricted:
      // do something
        break;
      default:
    }
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("userId");
    if (userId != null) {
      Navigator.pushReplacementNamed(context, '/homepage');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FlutterLogo(
        size: 100,
        colors: Colors.orange,
        // style: FlutterLogoStyle.stacked,
      ),
    ));
  }
}
