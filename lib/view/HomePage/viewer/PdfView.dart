import 'package:ezine/model/Articles/ArticlesDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PdfView extends StatefulWidget {
  String path;
  ArticleDetails article = ArticleDetails();

  PdfView({this.path, @required ArticleDetails details}) {
    if (details != null) {
      article = details;
    } else {
      details = ArticleDetails();
    }
  }
  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("${widget.article.article_title}",
            style: GoogleFonts.roboto(
              fontSize: 25,
              color: Colors.white,
            )),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_download,
            ),
            onPressed: () {
              Toast.show("Your pdf is being downloaded", context);
            },
          ),
        ],
      ),
      body: WebView(
        initialUrl: "http://docs.google.com/viewer?url=${widget.path}",
      ),
    );
  }
}
