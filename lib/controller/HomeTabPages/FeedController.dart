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

class FeedController extends ChangeNotifier {
  RefreshController refreshController;
  List<UserDetails> userDetails = [];
  List<ArticleDetails> articleDetails = [];
  List<String> pdfPath = [];
  Firestore firestore;
  bool isLoading = true;
  http.Client client;
  Directory _appDoc;
  String dept ="";
  bool isFaculty = false;
  bool branchDataChecked = false;
  SharedPreferences sharedPreferences;  

  FeedController({ @required List<ArticleDetails> articleDetails , @required List<UserDetails> userDetails , @required  List<String> pdfPath, @required isSearching}) {
    getLoggedInUserDetail();
    refreshController = RefreshController(initialRefresh: false);
    client = new http.Client();
    getApplicationDocumentsDirectory().then((onValue) {
      _appDoc = onValue;
    });
    firestore = Firestore.instance;
    if(articleDetails.isEmpty && userDetails.isEmpty && pdfPath.isEmpty && !isSearching){
      getUserArticle();
    }
  }

  getLoggedInUserDetail() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var docId = sharedPreferences.getString("userId");
    
    var data = await firestore.collection("user").document(docId).get();
    if(data.data['type'] == "FACULTY"){
      isFaculty = true;
      dept = data.data['branch'];
    }
    notifyListeners();
  }

  getBranchDataForFaculties() async {
    try {
      articleDetails.clear();
      var data = await firestore
          .collection('articles')
          .where("is_approved", isEqualTo: true)
          .where("branch", isEqualTo: dept)
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
  
  getUserDetails(String userId) async {
    try {
      var data = await firestore.collection("user").document(userId).get();
      userDetails.add(UserDetails.fromJson(data.data, data.documentID));
      notifyListeners();
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

  addData(QuerySnapshot data) {
    articleDetails.clear();
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

  void onRefresh() async{
   try{
     await Future.delayed(Duration(milliseconds: 1000));
     getUserArticle();
     refreshController.refreshCompleted();
   }catch(e){
     refreshController.refreshFailed();
   }
  }

//  void _onLoading() async{
//    // monitor network fetch
//    await Future.delayed(Duration(milliseconds: 1000));
//    // if failed,use loadFailed(),if no data return,use LoadNodata()
//    items.add((items.length+1).toString());
//    if(mounted)
//      setState(() {
//
//      });
//    _refreshController.loadComplete();
//  }
}
