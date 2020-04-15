import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezine/model/Articles/ArticlesDetails.dart';
import 'package:ezine/model/UserDetails/UserDetails.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ChangeNotifier {
  List<UserDetails> userDetails = [];
  List<ArticleDetails> articleDetails = [];
  Firestore firestore;

  ProfileController() {
    firestore = Firestore.instance;
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
      });
      notifyListeners();
    } catch (e) {}
  }
}
