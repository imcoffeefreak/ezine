import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezine/model/Articles/ArticlesDetails.dart';
import 'package:ezine/model/UserDetails/UserDetails.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


class ProfileController extends ChangeNotifier {
  List<UserDetails> userDetails = [];
  List<ArticleDetails> articleDetails = [];
  List<String> pdfPath = [];
  Firestore firestore;
  http.Client client;
  Directory _appDoc;


  ProfileController() {
    firestore = Firestore.instance;
    client = new http.Client();
    getApplicationDocumentsDirectory().then((onValue) {
      _appDoc = onValue;
    });
    getLoggedUserDetails();
  }

  getLoggedUserDetails() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var userId = sharedPreferences.getString("userId");
      var data = await firestore.collection("user").document(userId).get();
      userDetails.add(UserDetails.fromJson(data.data, data.documentID));
      getLoggedUserArticle(userId);
    } catch (e) {}
  }

  getLoggedUserArticle(String userId) async {
    try {
      var data = await firestore
          .collection('articles')
          .where("user_id", isEqualTo: userId)
          .getDocuments();
      data.documents.forEach((element) {
        articleDetails
            .add(ArticleDetails.fromJson(element.data, element.documentID));
        getFiles(element.data['file'], element.data['type']);
      });
      notifyListeners();
    } catch (e) {}
  }

  getFiles(String fileUrl, String extension) async {
    try {
      final filename = "article_${DateTime.now()}$extension";
      var request = await client.get(Uri.parse(fileUrl));
      var bytes = request.bodyBytes;
      File pathName = File(path.join(_appDoc.path, filename));
      await pathName.writeAsBytes(bytes);
      pdfPath.add(pathName.path);
      notifyListeners();
    } catch (e) {
      print("errror ****************** $e");
    }
  }
}
