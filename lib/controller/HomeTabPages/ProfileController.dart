import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezine/model/Articles/ArticlesDetails.dart';
import 'package:ezine/model/UserDetails/UserDetails.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  List<UserDetails> userDetails = [];
  List<ArticleDetails> articleDetails = [];
  List<String> pdfPath = [];
  Firestore firestore;
  http.Client client;
  Directory _appDoc;
  FirebaseAuth auth;
  SharedPreferences sharedPreferences;
  TextEditingController name;
  TextEditingController college;
  TextEditingController mobileNumber;
  TextEditingController branch;
  TextEditingController profile;
  StorageReference storageReference;
  var extension;
  var fileUrl;
  List<String> fileList = [];
  File file;
  String userId;
  bool isLoading = true;

  ProfileController() {
    firestore = Firestore.instance;
    client = new http.Client();
    auth = FirebaseAuth.instance;
    getApplicationDocumentsDirectory().then((onValue) {
      _appDoc = onValue;
    });
    getLoggedUserDetails();
  }

  getLoggedUserDetails() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userId = sharedPreferences.getString("userId");
      var data = await firestore.collection("user").document(userId).get();
      userDetails.add(UserDetails.fromJson(data.data, data.documentID));
      name = TextEditingController(text: userDetails[0].name);
      branch = TextEditingController(text: userDetails[0].branch);
      college = TextEditingController(text: userDetails[0].college);
      mobileNumber = TextEditingController(text: userDetails[0].mobile);
      profile = TextEditingController(text: userDetails[0].profile_pic);
     await getLoggedUserArticle(userId);
      checkData();
    } catch (e) {}
  }

  checkData(){
    if(articleDetails.isEmpty){
      isLoading = false;
      notifyListeners();
    }
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

  logout() async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      sharedPreferences.clear();
      await auth.signOut();
      return 200;
    } catch (e) {
      print(e);
      return 500;
    }
  }
  getUploadedFile() async {
    try {
      fileList.clear();
      file = await FilePicker.getFile(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'ppt'],
      );
      if (file != null) {
        fileList.add(file.path);
        extension = path.extension(file.path);
      }
      notifyListeners();
    } catch (e) {}
  }

  updateProfile(String nameAdded) async{
    try {
     if(nameAdded!=null){
       storageReference = FirebaseStorage.instance
           .ref()
           .child("profiles/$userId/${path.basename(file.path)}");
       StorageUploadTask uploadTask = storageReference.putFile(file);
       await uploadTask.onComplete;
       fileUrl = await storageReference.getDownloadURL();
       if(fileUrl!=null){
         final details = UserDetails(
           name: name.text,
           college: college.text,
           mobile: mobileNumber.text,
           branch: branch.text,
           usn: userDetails[0].usn,
           email: userDetails[0].email,
           password: userDetails[0].password,
           profile_pic: fileUrl,
         );
         await firestore.collection("user").document(userId).setData(details.toJson(),merge: true);
         getLoggedUserDetails();
         return 200;
       }
     }else{
         final details = UserDetails(
           name: name.text,
           college: college.text,
           mobile: mobileNumber.text,
           branch: branch.text,
           usn: userDetails[0].usn,
           email: userDetails[0].email,
           password: userDetails[0].password,
           profile_pic: profile.text,
         );
         await firestore.collection("user").document(userId).setData(details.toJson(),merge: true);
         getLoggedUserDetails();
         return 200;
     }
    } catch (e) {
      print(e);
      return 500;
    }
  }
}
