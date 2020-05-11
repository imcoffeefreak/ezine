import 'package:ezine/routeGeneration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

void main(){
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ezine',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        tabBarTheme: TabBarTheme(
           labelStyle: GoogleFonts.lato(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: Colors.white
            ),
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelStyle: GoogleFonts.lato(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white
            ),
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xFF1B1F5C),
        ),
        scaffoldBackgroundColor: Color(0xFF1B1F5C),
      ),
      initialRoute: '/',
      onGenerateRoute: GenerateRoute.generateRoute,
    );
  }
}
