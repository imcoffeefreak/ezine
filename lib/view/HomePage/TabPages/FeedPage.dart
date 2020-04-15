import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ezine/controller/HomeTabPages/FeedController.dart';
import 'package:ezine/view/PdfViewPage.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  var view;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedController>(
      create: (context) => FeedController(),
      child: Card(
        elevation: 20.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Consumer<FeedController>(
          builder: (context, feedController, _) {
            return StreamBuilder(
                stream: feedController.getUserArticle(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    feedController.addData(snapshot.data);
                    return (feedController.articleDetails.isNotEmpty &&
                            feedController.userDetails.isNotEmpty &&
                            feedController.pdfPath.isNotEmpty)
                        ? ListView.separated(
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
                                          MediaQuery.of(context)
                                                  .size
                                                  .shortestSide *
                                              0.03),
                                      child: Container(
                                        width: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.9,
                                        height: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context)
                                              .size
                                              .shortestSide *
                                          0.9,
                                      height: MediaQuery.of(context)
                                              .size
                                              .shortestSide *
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                      left: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .shortestSide *
                                                          0.2),
                                                  child: IconButton(
                                                    icon:
                                                        Icon(Icons.open_in_new),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PdfViewPage(
                                                            path: feedController
                                                                .pdfPath[index],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .shortestSide *
                                                          0.15),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Text(
                                                      "${DateFormat("dd-MM-yyyy").format(DateTime.fromMicrosecondsSinceEpoch(feedController.articleDetails[index].published_date * 1000))}",
                                                      style: GoogleFonts.roboto(
                                                        fontStyle:
                                                            FontStyle.italic,
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
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                });
          },
        ),
      ),
    );
  }
}
