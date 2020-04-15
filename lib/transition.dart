import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("userId");
    if(userId!=null){
      Navigator.pushReplacementNamed(context, '/homepage');
    }
    else{
       Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  FlutterLogo(
          size: 100,
          colors: Colors.orange,
          // style: FlutterLogoStyle.stacked,
        ),
      )
    );
  }
}