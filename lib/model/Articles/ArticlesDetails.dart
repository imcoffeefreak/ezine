class ArticleDetails {
  String docId;
  String article_title;
  String description;
  String file;
  bool is_approved;
  dynamic published_date;
  String user_id;
  String type;

  ArticleDetails({
    this.docId,
    this.article_title,
    this.description,
    this.file,
    this.is_approved,
    this.published_date,
    this.user_id,
    this.type
  });

  ArticleDetails.fromJson(Map<String,dynamic> json, String id){
    this.docId = id;
    this.article_title = json['article_title'];
    this.description = json['description'];
    this.file = json['file'];
    this.is_approved = json['is_approved'];
    this.published_date = json['published_date'];
    this.user_id = json['user_id'];
    this.type = json['type'];
  }

  Map<String,dynamic> toJson() {
    final data = Map<String,dynamic>();
    data['article_title'] = this.article_title;
    data['description'] = this.description;
    data['file'] = this.file;
    data['is_approved'] = this.is_approved;
    data['published_date'] = this.published_date;
    data['user_id'] = this.user_id;
    data['type'] = this.type;
    return data;
  }
}