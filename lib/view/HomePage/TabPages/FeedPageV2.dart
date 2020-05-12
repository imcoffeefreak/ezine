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
import 'package:ezine/view/HomePage/viewer/PreViewFiles.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FeedPageV2 extends StatefulWidget {
  List<ArticleDetails> articleDetails;
  List<UserDetails> userDetails;
  List<String> pdfPath;
  bool isSearching;
  bool isLoading;
  Function onRefresh;
  RefreshController refreshController;

  FeedPageV2({@required this.articleDetails,
    @required this.pdfPath,
    @required this.userDetails,
    @required this.isSearching,
    this.onRefresh,
    this.refreshController,
    this.isLoading});

  @override
  _FeedPageV2State createState() => _FeedPageV2State();
}

class _FeedPageV2State extends State<FeedPageV2> {
  var view;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: (widget.articleDetails.isNotEmpty &&
          widget.userDetails.isNotEmpty &&
          widget.pdfPath.isNotEmpty)
          ? SmartRefresher(
        header: WaterDropHeader(),
        onRefresh: widget.onRefresh,
        controller: widget.refreshController,
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
                        MediaQuery
                            .of(context)
                            .size
                            .shortestSide * 0.03),
                    child: Container(
                      width:
                      MediaQuery
                          .of(context)
                          .size
                          .shortestSide * 0.9,
                      height:
                      MediaQuery
                          .of(context)
                          .size
                          .shortestSide * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                        image: (widget.articleDetails[index].type ==
                            ".jpg" ||
                            widget
                                .articleDetails[index].type ==
                                ".jpeg" ||
                            widget.articleDetails[index].type ==
                                ".png" ||
                            widget.articleDetails[index].type ==
                                ".PNG")
                            ? DecorationImage(
                          image: NetworkImage(
                              widget.articleDetails[index].file),
                        )
                            : DecorationImage(
                          image:
                          AssetImage("assets/images/pdf.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .shortestSide * 0.9,
                    height:
                    MediaQuery
                        .of(context)
                        .size
                        .shortestSide * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
//                                        color: Colors.grey,
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width:
                            MediaQuery
                                .of(context)
                                .size
                                .width * 0.2,
                            height:
                            MediaQuery
                                .of(context)
                                .size
                                .height * 0.2,
                            child: Text(""),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  widget.userDetails[index].profile_pic,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .shortestSide *
                                      0.03),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
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
                              width: MediaQuery
                                  .of(context)
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery
                                        .of(context)
                                        .size
                                        .shortestSide *
                                        0.2),
                                child: IconButton(
                                  icon: Icon(Icons.open_in_new),
                                  onPressed: () {
                                    print(
                                        "************* ${widget
                                            .articleDetails[index].type ==
                                            ".pdf"}");

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PreViewFilesPage(
                                              users: widget
                                                  .userDetails[index],
                                              details:
                                              widget.articleDetails[
                                              index],
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery
                                        .of(context)
                                        .size
                                        .shortestSide *
                                        0.15),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "${DateFormat("dd-MM-yyyy").format(
                                        DateTime.fromMicrosecondsSinceEpoch(
                                            widget.articleDetails[index]
                                                .published_date * 1000))}",
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
      ),
    );
  }
}
