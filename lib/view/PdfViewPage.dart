import 'dart:io';
import 'dart:typed_data';

import 'package:ezine/model/Articles/ArticlesDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:toast/toast.dart';

class PdfViewPage extends StatefulWidget {
  String path;
  ArticleDetails article = ArticleDetails();

  PdfViewPage({this.path, @required ArticleDetails details}) {
    if (details != null) {
      article = details;
    } else {
      details = ArticleDetails();
    }
  }

  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  File fileData;
  String filename;
  String path;

  @override
  initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    loadPdf();
//    initial();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/teste.pdf');
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
        fileName: 'article.pdf_${DateTime.now()}',
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
    print("*************** PATH ${widget.path}");
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
      body: Container(
        child: (path != null)
            ? PdfViewer(
                filePath: path,
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
