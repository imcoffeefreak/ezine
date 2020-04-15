import 'package:ezine/transition.dart';
import 'package:ezine/view/Authentication/Login.dart';
import 'package:ezine/view/Authentication/Signup.dart';
import 'package:ezine/view/HomePage/HomePage.dart';
import 'package:flutter/material.dart';

class GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings){
    var args = settings.arguments;
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=>Transitionpage());
      case '/login':
        return MaterialPageRoute(builder: (_)=>LoginPage());
      case '/signup':
       return MaterialPageRoute(builder: (_)=>UserSignup());
      case '/homepage':
         return MaterialPageRoute(builder: (_)=>HomePage());
    }
  }
}
