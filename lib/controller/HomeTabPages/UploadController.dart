import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezine/model/Articles/ArticlesDetails.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;


class UploadController extends ChangeNotifier {
  List<String> fileList = [];
  File file;
  StorageReference storageReference;
  Firestore firestore;
  String userId;
  var extension;
  var fileUrl;

  UploadController() {
    firestore = Firestore.instance;
    getUserDetails();
  }

  getUserDetails() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userId = sharedPreferences.getString("userId");
      notifyListeners();
    } catch (e) {}
  }

  getFiles() async {
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

  deleteFile(int index) {
    try {
      fileList.removeAt(index);
      notifyListeners();
    } catch (e) {}
  }

  addArticle(String title, String description, String fileName) async {
    try {
      final date = DateTime.now();
      storageReference = FirebaseStorage.instance
          .ref()
          .child("articles/$userId/${path.basename(file.path)}");
      StorageUploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.onComplete;
      fileUrl = await storageReference.getDownloadURL();

      if (fileUrl != null) {
        final articleDetails = ArticleDetails(
          article_title: title,
          description: description,
          published_date: date.millisecondsSinceEpoch,
          is_approved: false,
          file: fileUrl,
          user_id: userId,
          type: extension,
        );
        var data = await firestore
            .collection('articles')
            .add(articleDetails.toJson());
        if (data.documentID != null) {
          fileList.clear();
          notifyListeners();
          return 204;
        } else {
          return 400;
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
