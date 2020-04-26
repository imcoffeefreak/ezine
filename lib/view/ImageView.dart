import 'package:ezine/model/Articles/ArticlesDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class ImageView extends StatefulWidget {
  String path;
  ArticleDetails article = ArticleDetails();

  ImageView({this.path, @required ArticleDetails details}) {
    if (details != null) {
      article = details;
    } else {
      details = ArticleDetails();
    }
  }

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
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
//              downloadPdf();
              Toast.show("Your pdf is being downloaded", context);
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.shortestSide * 0.9,
          height: MediaQuery.of(context).size.shortestSide * 0.6,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                widget.article.file,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
