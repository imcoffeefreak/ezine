import 'package:ezine/model/Articles/ArticlesDetails.dart';
import 'package:ezine/model/UserDetails/UserDetails.dart';
import 'package:ezine/view/HomePage/viewer/FeedbackPage.dart';
import 'package:ezine/view/HomePage/viewer/ImageView.dart';
import 'package:ezine/view/HomePage/viewer/PdfViewPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PreViewFilesPage extends StatefulWidget {
  ArticleDetails article = ArticleDetails();
  UserDetails userDetails = UserDetails();

  PreViewFilesPage(
      {@required ArticleDetails details, @required UserDetails users}) {
    if (details != null) {
      article = details;
      userDetails = users;
    } else {
      details = ArticleDetails();
      users = UserDetails();
    }
  }

  @override
  _PreViewFilesPageState createState() => _PreViewFilesPageState();
}

class _PreViewFilesPageState extends State<PreViewFilesPage> {
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.1),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.shortestSide * 0.1,
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      "${widget.article.article_title}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: top,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.3,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                    image: (widget.article.type == ".jpg" ||
                            widget.article.type == ".jpeg" ||
                            widget.article.type == ".png" ||
                            widget.article.type == ".PNG")
                        ? DecorationImage(
                            image: NetworkImage(widget.article.file),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: AssetImage("assets/images/pdf.png"),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
            NotificationListener(
              onNotification: (v) {
                if (v is ScrollUpdateNotification) {
                  // setState(() {
                  if (v.scrollDelta != null) {
                    top -= v.scrollDelta / 5;
                  }
                  // });
                }
                return true;
              },
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Opacity(
                    opacity: 0.0,
                    child: Material(
                      child: GestureDetector(
                        onTap: () {
                          if (widget.article.type == ".jpg" ||
                              widget.article.type == ".jpeg" ||
                              widget.article.type == ".png" ||
                              widget.article.type == ".PNG") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageView(
                                  details: widget.article,
                                ),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewPage(
                                  details: widget.article,
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.height * 0.35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                            image: (widget.article.type == ".jpg" ||
                                    widget.article.type == ".jpeg" ||
                                    widget.article.type == ".png" ||
                                    widget.article.type == ".PNG")
                                ? DecorationImage(
                                    image: NetworkImage(widget.article.file),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: AssetImage("assets/images/pdf.png"),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xFF1B1F5C),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.3,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.02,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.timer,
                                color: Colors.orange[200],
                                size: 14,
                              ),
                              label: Text(
                                "${DateFormat("dd-MM-yyyy").format(DateTime.fromMicrosecondsSinceEpoch(widget.article.published_date * 1000))}",
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            FlatButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FeedbackChatPage(
                                      docId: widget.article.docId,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.orange[200],
                                size: 14,
                              ),
                              label: Text(
                                "Feedback",
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Description:",
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: Colors.orange[200],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.shortestSide * 0.08,
                        ),
                        Container(
                          padding: EdgeInsets.all(15.0),
                          width:
                              MediaQuery.of(context).size.shortestSide * 0.95,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.white30)),
                          child: Text(
                            "${widget.article.description}",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.roboto(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.shortestSide * 0.1,
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Published By:",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Colors.orange[200],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${widget.userDetails.name}",
                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "(${widget.userDetails.usn})",
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
