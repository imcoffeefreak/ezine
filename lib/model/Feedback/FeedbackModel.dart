class FeedbackModel{
  String docId;
  String message;
  String userId;
  int created_at;

  FeedbackModel({
    this.docId,
    this.message,
    this.userId,
    this.created_at,
});

  FeedbackModel.fromJson(Map<String,dynamic> json, String docId){
    this.docId = docId;
    this.message = json['message'];
    this.userId = json['userId'];
    this.created_at =  json['created_at'];
  }

  Map<String,dynamic> toJson(){
    final data = Map<String,dynamic>();
    data['message'] = this.message;
    data['userId'] = this.userId;
    data['created_at'] = this.created_at;
    return data;
  }
}