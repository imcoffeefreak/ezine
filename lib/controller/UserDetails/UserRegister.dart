import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegister extends ChangeNotifier {
  Firestore firestore;
  bool isAdded = false;
  SharedPreferences sharedPreferences;
  FirebaseAuth auth;

  UserRegister() {
    auth = FirebaseAuth.instance;
    firestore = Firestore.instance;
  }

  registerUser(Map<String, dynamic> jsonData) async {
    try {
      var user = await auth.createUserWithEmailAndPassword(
          email: jsonData['email'], password: jsonData['password']);
      if (user.user.uid != null) {
        var data = await firestore.collection("user").add(jsonData);
        if (data.documentID != null) {
          sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("userId", data.documentID);
          isAdded = true;
        }
      }
    } catch (e) {}

    notifyListeners();
  }
}
