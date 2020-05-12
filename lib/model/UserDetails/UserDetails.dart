class UserDetails {
  String docId;
  String branch;
  String name;
  String usn;
  String college;
  String password;
  String email;
  String mobile;
  String profile_pic;
  String type;

  UserDetails(
      {this.docId,
      this.branch,
      this.name,
      this.usn,
      this.college,
      this.password,
      this.email,
      this.mobile,
        this.type,
      this.profile_pic});

  UserDetails.fromJson(Map<String, dynamic> json, String id) {
    docId = id;
    branch = json['branch'];
    name = json['name'];
    usn = json['usn'];
    college = json['college'];
    password = json['password'];
    email = json['email'];
    mobile = json['mobile'];
    profile_pic = json['profile_pic'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();

    data['branch'] = this.branch;
    data['name'] = this.name;
    data['usn'] = this.usn;
    data['college'] = this.college;
    data['password'] = this.password;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profile_pic'] = this.profile_pic;
    data['type'] = "STUDENT";
    return data;
  }
}
