import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezine/model/UserDetails/UserDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLogin extends ChangeNotifier {
  FirebaseAuth auth;
  Firestore firestore;
  List<UserDetails> userDetails = [];
  SharedPreferences sharedPreferences;
  bool isFaculty = false;

  UserLogin() {
    auth = FirebaseAuth.instance;
    firestore = Firestore.instance;
  }

  userLogin(String usn, String password) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      var data = await firestore
          .collection("user")
          .where("usn", isEqualTo: usn)
          .where("password", isEqualTo: password)
          .getDocuments();
      userDetails.clear();
      data.documents.forEach((element) {
        sharedPreferences.setString("userId", element.documentID);
        userDetails.add(UserDetails.fromJson(element.data, element.documentID));
      });

      var user = await auth.signInWithEmailAndPassword(
          email: userDetails[0].email, password: userDetails[0].password);
      if (data.documents.length == 0 && user.user.uid != null) {
        return 401;
      } else {
        return 204;
      }
    } catch (e) {}
  }
}
