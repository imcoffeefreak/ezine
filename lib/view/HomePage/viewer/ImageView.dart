import 'dart:io';
import 'dart:typed_data';

import 'package:ezine/model/Articles/ArticlesDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
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
  File fileData;
  String filename;
  String path;

  @override
  initState() {
    super.initState();
    loadPdf();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/teste');
  }

  Future<File> writeCounter(Uint8List stream) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsBytes(stream);
  }

  Future<Uint8List> fetchPost() async {
    final response = await http.get('${widget.article.file}');
    final responseJson = response.bodyBytes;

    return responseJson;
  }

  loadPdf() async {
    writeCounter(await fetchPost());
    path = (await _localFile).path;

    if (!mounted) return;

    setState(() {});
  }

  initial() async {
    try {
      await FlutterDownloader.initialize();
      Directory('/storage/emulated/0/Ezine').exists().then((yes) {
        if (!yes) {
          print("inside failed loop $yes");
          Directory('/storage/emulated/0/Ezine').create();
          Directory(
              '/storage/emulated/0/Ezine/articles')
              .create();
        } else {
          print("im here");
          Directory(
              '/storage/emulated/0/Ezine/articles')
              .create();
        }
      }).catchError((e) {
        Directory(
            '/storage/emulated/0/Ezine/articles')
            .create();
        setState(() {
          var exception = "error creating";
        });
      });
      String uri = Uri.decodeFull(widget.article.file);
      final RegExp regex =
      RegExp('([^?/]*\.(pdf|jpg|txt|docx|zip|jpeg|png|csv))');
      setState(() {
        filename = regex.stringMatch(uri);
        print(filename);
        fileData = File(
            '/storage/emulated/0/Ezine/articles/$filename');
      });
    } catch (e) {
      print(e);
    }
  }

  downloadPdf() async {
    try {
      await initial();
      await FlutterDownloader.enqueue(
        url: widget.article.file,
        savedDir:
        "/storage/emulated/0/Ezine/articles",
        fileName: 'article_${DateTime.now()}',
        showNotification: true,
        openFileFromNotification:
        true, // click on notification to open downloaded file (for Android)
      );
    } catch (e) {
      print("********** ERROR DOWNLOAD ********** $e");
    }
  }
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
              downloadPdf();
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
