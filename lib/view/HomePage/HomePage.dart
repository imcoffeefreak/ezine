import 'package:ezine/view/HomePage/TabPages/FeedPage.dart';
import 'package:ezine/view/HomePage/TabPages/ProfilePage.dart';
import 'package:ezine/view/HomePage/TabPages/UploadPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          // backgroundColor: Colors.orange,
          appBar: AppBar(
            elevation: 0.0,
            // backgroundColor: Colors.orange,
            bottom: TabBar(
              isScrollable: false,
              indicatorColor: Colors.white,
              labelStyle: GoogleFonts.lato(
                  fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white),
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelStyle: GoogleFonts.lato(
                  fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
              tabs: [
                Tab(
                  icon: Text(
                    "Feed",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Tab(
                  icon: Text(
                    "Upload",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Tab(
                  icon: Text(
                    "Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.shortestSide * 0.02),
                child: FeedPage(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.shortestSide * 0.02),
                child: UploadPage(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.shortestSide * 0.02),
                child: ProfilePage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
