import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezine/model/Articles/ArticlesDetails.dart';
import 'package:ezine/model/UserDetails/UserDetails.dart';
import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class HomePageController extends ChangeNotifier {
  RefreshController refreshController;
  List<UserDetails> userDetails = [];
  List<ArticleDetails> articleDetails = [];
  List<String> pdfPath = [];
  Firestore firestore;
  bool isLoading = true;
  http.Client client;
  Directory _appDoc;
  bool isSearching = false;
  String dept = "";
  bool isFaculty = false;
  bool branchDataChecked = false;
  SharedPreferences sharedPreferences;

  HomePageController() {
    getLoggedInUserDetail();
    refreshController = RefreshController(initialRefresh: false);
    client = new http.Client();
    getApplicationDocumentsDirectory().then((onValue) {
      _appDoc = onValue;
    });
    firestore = Firestore.instance;
    getUserArticle();
  }

  getLoggedInUserDetail() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var docId = sharedPreferences.getString("userId");

    var data = await firestore.collection("user").document(docId).get();
    if (data.data['type'] == "FACULTY") {
      isFaculty = true;
      dept = data.data['branch'];
    }
    notifyListeners();
  }

  checkBranch(bool data) {
    branchDataChecked = data;
    notifyListeners();
  }

  getBranchDataForFaculties({String branch}) async {
    if (branchDataChecked) {
      try {
        articleDetails.clear();
        var user = await firestore
            .collection("user")
            .where("branch", isEqualTo: branch)
            .getDocuments();
        user.documents.forEach((element) {
          firestore
              .collection('articles')
              .where("is_approved", isEqualTo: true)
              .where("user_id", isEqualTo: element.documentID)
              .getDocuments()
              .then((value) {
            value.documents.forEach((articles) {
              articleDetails.add(
                  ArticleDetails.fromJson(articles.data, articles.documentID));
            });
          });
        });

//        data.documents.forEach((element) {
//          DateTime date = DateTime.fromMicrosecondsSinceEpoch(
//              element.data['published_date'] * 1000);
//          if (date.month == DateTime.now().month - 1) {
//            articleDetails
//                .add(ArticleDetails.fromJson(element.data, element.documentID));
//            getUserDetails(element.data['user_id']);
//            getFiles(element.data['file'], element.data['type']);
//          }
//        });
        checkData();
        notifyListeners();
      } catch (e) {
        print(e);
      }
    }else{
      getUserArticle();
    }
  }

  getUserDetails(String userId, {String branch}) async {
    try {
      if (branch == null) {
        var data = await firestore.collection("user").document(userId).get();
        userDetails.add(UserDetails.fromJson(data.data, data.documentID));
        notifyListeners();
      } else {
        var data = await firestore.collection("user").document(userId).get();
        userDetails.add(UserDetails.fromJson(data.data, data.documentID));
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  getUserArticle() async {
    try {
      articleDetails.clear();
      var data = await firestore
          .collection('articles')
          .where("is_approved", isEqualTo: true)
          .getDocuments();
      data.documents.forEach((element) {
        DateTime date = DateTime.fromMicrosecondsSinceEpoch(
            element.data['published_date'] * 1000);
        if (date.month == DateTime.now().month - 1) {
          articleDetails
              .add(ArticleDetails.fromJson(element.data, element.documentID));
          getUserDetails(element.data['user_id']);
          getFiles(element.data['file'], element.data['type']);
        }
      });
      checkData();
      notifyListeners();
    } catch (e) {
      print(e);
    }
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

  checkData() {
    if (articleDetails.isEmpty) {
      isLoading = false;
    }
    notifyListeners();
  }

  void onRefresh() async {
    try {
      await Future.delayed(Duration(milliseconds: 1000));
      getUserArticle();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    }
  }

  changeSearchFlag() {
    if (isSearching) {
      isSearching = false;
    } else {
      isSearching = true;
    }
    notifyListeners();
  }

  searchViaName(String name) async {
    try {
      userDetails.clear();
      var data = await firestore
          .collection("user")
          .orderBy("name")
          .startAt([name]).getDocuments();
      data.documents.forEach((element) {
        userDetails.add(UserDetails.fromJson(element.data, element.documentID));
        getArticles(element.documentID);
      });
      checkData();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getArticles(String docId) async {
    try {
      articleDetails.clear();
      var data = await firestore
          .collection("articles")
          .where("user_id", isEqualTo: docId)
          .where("is_approved", isEqualTo: true)
          .getDocuments();
      data.documents.forEach((element) {
        DateTime date = DateTime.fromMicrosecondsSinceEpoch(
            element.data['published_date'] * 1000);
        if (date.month == DateTime.now().month - 1) {
          articleDetails
              .add(ArticleDetails.fromJson(element.data, element.documentID));
          getFiles(element.data['file'], element.data['type']);
        }
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
