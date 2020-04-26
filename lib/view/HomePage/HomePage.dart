import 'package:ezine/controller/homePageController.dart';
import 'package:ezine/view/HomePage/TabPages/FeedPage.dart';
import 'package:ezine/view/HomePage/TabPages/FeedPageV2.dart';
import 'package:ezine/view/HomePage/TabPages/ProfilePage.dart';
import 'package:ezine/view/HomePage/TabPages/UploadPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int currentIndex = 0;
  TextEditingController search;

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          currentIndex = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<HomePageController>(
        create: (context) => HomePageController(),
        child: Consumer<HomePageController>(
          builder: (context, homePageController, _) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: (currentIndex == 0)
                    ? Container(
                        width: MediaQuery.of(context).size.shortestSide * 0.9,
                        height: MediaQuery.of(context).size.shortestSide * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Form(
                          child: TextFormField(
                            controller: search,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                      color: Color(0xFF1B1F5C),
                                    )),
                                suffixIcon: Container(
                                  child: (!homePageController.isSearching)
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.search,
                                            color: Color(0xFF1B1F5C),
                                          ),
                                          onPressed: () {
                                            homePageController
                                                .changeSearchFlag();
                                          },
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: Color(0xFF1B1F5C),
                                          ),
                                          onPressed: () {
                                            search.clear();
                                            homePageController
                                                .changeSearchFlag();
                                            homePageController.getUserArticle();
                                          },
                                        ),
                                ),
                                hintText: "Search article",
                                hintStyle: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                )),
                            onTap: () {
                              homePageController.changeSearchFlag();
                            },
                            onChanged: (value) {
                              if (value.length >= 3) {
                                homePageController.searchViaName(value);
                              }
                            },
                          ),
                        ))
                    : Container(),
                bottom: TabBar(
                  controller: _tabController,
                  isScrollable: false,
                  indicatorColor: Colors.white,
                  labelStyle: GoogleFonts.lato(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelStyle: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
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
                controller: _tabController,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.shortestSide * 0.02),
                    child: FeedPageV2(
                      onRefresh: homePageController.onRefresh,
                      refreshController: homePageController.refreshController,
                      isLoading: homePageController.isLoading,
                      isSearching: homePageController.isSearching,
                      articleDetails: homePageController.articleDetails,
                      userDetails: homePageController.userDetails,
                      pdfPath: homePageController.pdfPath,
                    ),
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
            );
          },
        ),
      ),
    );
  }
}
