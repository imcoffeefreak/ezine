import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezine/model/Feedback/FeedbackModel.dart';
import 'package:ezine/model/UserDetails/UserDetails.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackController extends ChangeNotifier {
  List<FeedbackModel> chats = [];
  List<UserDetails> users = [];
  Firestore firestore;
  String userId;
  SharedPreferences sharedPreferences;


  FeedbackController({String docId}) {
    firestore = Firestore.instance;
    getLoggedUserId();
    getAllTheFeedback(docId);
  }

  getLoggedUserId() async {
    sharedPreferences =await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("userId");
    notifyListeners();
  }

  getAllTheFeedback(String docId) async {
    try {
      var data = await firestore
          .collection("articles")
          .document(docId)
          .collection("feedback")
          .orderBy("created_at")
          .getDocuments();
      data.documents.forEach((element) {
        chats.add(FeedbackModel.fromJson(element.data, element.documentID));
        getAllUserFromFeedback(docId: element.data['userId']);
      });
    } catch (error) {
      print("************* ERROR IN CODE $error");
    }
  }

  getAllUserFromFeedback({String docId}) async {
    try {
      var data = await firestore.collection("user").document(docId).get();
      users.add(UserDetails.fromJson(data.data, data.documentID));
      notifyListeners();
    } catch (error) {
      print("************* ERROR IN CODE $error");
    }
  }



  sendFeedback({String docId, Map<String,dynamic> json}) async {
    try{
      await firestore.collection("articles").document(docId).collection("feedback").add(json);
      getAllTheFeedback(docId);
    }catch(error){
      print("************* ERROR IN CODE $error");
    }
  }
}
