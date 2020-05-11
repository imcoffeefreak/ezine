import 'dart:io';

import 'package:ezine/model/Articles/ArticlesDetails.dart';
import 'package:ezine/model/UserDetails/UserDetails.dart';
import 'package:ezine/view/HomePage/viewer/ImageView.dart';
import 'package:ezine/view/HomePage/viewer/PdfView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ezine/controller/HomeTabPages/FeedController.dart';
import 'package:ezine/view/HomePage/viewer/PdfViewPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FeedPage extends StatefulWidget {
  List<ArticleDetails> articleDetails;
  List<UserDetails> userDetails;
  List<String> pdfPath;
  bool isSearching;
  bool isLoading;
  FeedPage({@required this.articleDetails,@required this.pdfPath, @required this.userDetails, @required this.isSearching,this.isLoading});
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  var view;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedController>(
      create: (context) => FeedController(
        isSearching: widget.isSearching,
        articleDetails: widget.articleDetails,
        userDetails: widget.userDetails,
        pdfPath: widget.pdfPath,
      ),
      child: Card(
        elevation: 20.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: (widget.userDetails.isEmpty && widget.articleDetails.isEmpty && widget.pdfPath.isEmpty)?Consumer<FeedController>(
          builder: (context, feedController, _) {
            return (feedController.articleDetails.isNotEmpty &&
                feedController.userDetails.isNotEmpty &&
                feedController.pdfPath.isNotEmpty)
                ? SmartRefresher(
              header: WaterDropHeader(),
              onRefresh: feedController.onRefresh,
              controller: feedController.refreshController,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: feedController.articleDetails.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.shortestSide *
                                  0.03),
                          child: Container(
                            width:
                            MediaQuery.of(context).size.shortestSide *
                                0.9,
                            height:
                            MediaQuery.of(context).size.shortestSide *
                                0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey,
                              image: (feedController
                                  .articleDetails[index].type ==
                                  ".jpg" || feedController
                                  .articleDetails[index].type ==
                                  ".jpeg" || feedController
                                  .articleDetails[index].type ==
                                  ".png")
                                  ? DecorationImage(
                                image: NetworkImage(feedController
                                    .articleDetails[index].file),
                              )
                                  : DecorationImage(
                                image: AssetImage("assets/images/pdf.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width:
                          MediaQuery.of(context).size.shortestSide *
                              0.9,
                          height:
                          MediaQuery.of(context).size.shortestSide *
                              0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
//                                        color: Colors.grey,
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context)
                                        .size
                                        .shortestSide *
                                        0.02),
                                child: CircleAvatar(
                                  radius: MediaQuery.of(context)
                                      .size
                                      .shortestSide *
                                      0.09,
                                  child: FlutterLogo(),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                            0.03),
                                    child: Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .shortestSide *
                                          0.3,
                                      child: Text(
                                        "${feedController.userDetails[index].name}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.lato(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .shortestSide *
                                        0.3,
                                    child: Text(
                                      "${feedController.userDetails[index].branch}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                              .size
                                              .shortestSide *
                                              0.2),
                                      child: IconButton(
                                        icon: Icon(Icons.open_in_new),
                                        onPressed: () {
                                          print(
                                              "************* ${feedController.articleDetails[index].type == ".pdf"}");
                                          (feedController
                                              .articleDetails[
                                          index]
                                              .type ==
                                              ".pdf")
                                              ? Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PdfViewPage(
                                                    path: feedController
                                                        .pdfPath[index],
                                                    details: feedController
                                                        .articleDetails[
                                                    index],
                                                  ),
                                            ),
                                          )
                                              : Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ImageView(
                                                    path: feedController
                                                        .pdfPath[index],
                                                    details: feedController
                                                        .articleDetails[
                                                    index],
                                                  ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                              .size
                                              .shortestSide *
                                              0.15),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          "${DateFormat("dd-MM-yyyy").format(DateTime.fromMicrosecondsSinceEpoch(feedController.articleDetails[index].published_date * 1000))}",
                                          style: GoogleFonts.roboto(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
                : (feedController.isLoading)
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Center(
              child: Text(
                "No Article Found!",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
            );
          },
        ):Consumer<FeedController>(
          builder: (context, feedController, _) {
            return (widget.articleDetails.isNotEmpty &&
                widget.userDetails.isNotEmpty &&
                widget.pdfPath.isNotEmpty)
                ? SmartRefresher(
              header: WaterDropHeader(),
              onRefresh: feedController.onRefresh,
              controller: feedController.refreshController,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: widget.articleDetails.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.shortestSide *
                                  0.03),
                          child: Container(
                            width:
                            MediaQuery.of(context).size.shortestSide *
                                0.9,
                            height:
                            MediaQuery.of(context).size.shortestSide *
                                0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey,
                              image: (widget
                                  .articleDetails[index].type ==
                                  ".jpg" || widget
                                  .articleDetails[index].type ==
                                  ".jpeg" || widget
                                  .articleDetails[index].type ==
                                  ".png")
                                  ? DecorationImage(
                                image: NetworkImage(widget
                                    .articleDetails[index].file),
                              )
                                  : DecorationImage(
                                image: AssetImage("assets/images/pdf.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width:
                          MediaQuery.of(context).size.shortestSide *
                              0.9,
                          height:
                          MediaQuery.of(context).size.shortestSide *
                              0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
//                                        color: Colors.grey,
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context)
                                        .size
                                        .shortestSide *
                                        0.02),
                                child: CircleAvatar(
                                  radius: MediaQuery.of(context)
                                      .size
                                      .shortestSide *
                                      0.09,
                                  child: FlutterLogo(),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                            0.03),
                                    child: Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .shortestSide *
                                          0.3,
                                      child: Text(
                                        "${widget.userDetails[index].name}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.lato(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .shortestSide *
                                        0.3,
                                    child: Text(
                                      "${widget.userDetails[index].branch}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                              .size
                                              .shortestSide *
                                              0.2),
                                      child: IconButton(
                                        icon: Icon(Icons.open_in_new),
                                        onPressed: () {
                                          print(
                                              "************* ${widget.articleDetails[index].type == ".pdf"}");
                                          (widget
                                              .articleDetails[
                                          index]
                                              .type ==
                                              ".pdf")
                                              ? Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PdfViewPage(
                                                    path: widget
                                                        .pdfPath[index],
                                                    details: widget
                                                        .articleDetails[
                                                    index],
                                                  ),
                                            ),
                                          )
                                              : Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ImageView(
                                                    path: widget
                                                        .pdfPath[index],
                                                    details: widget
                                                        .articleDetails[
                                                    index],
                                                  ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                              .size
                                              .shortestSide *
                                              0.15),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          "${DateFormat("dd-MM-yyyy").format(DateTime.fromMicrosecondsSinceEpoch(widget.articleDetails[index].published_date * 1000))}",
                                          style: GoogleFonts.roboto(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
                : (widget.isLoading)
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Center(
              child: Text(
                "No Article Found!",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
