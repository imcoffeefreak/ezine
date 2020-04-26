import 'package:ezine/controller/UserDetails/UserRegister.dart';
import 'package:ezine/model/UserDetails/UserDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class UserSignup extends StatefulWidget {
  @override
  _UserSignupState createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  TextEditingController name;
  TextEditingController college;
  TextEditingController branch;
  TextEditingController usn;
  TextEditingController email;
  TextEditingController mobile;
  TextEditingController password;
  final _formKey = GlobalKey<FormState>();
  bool obsecureText = true;
  ProgressDialog pr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = TextEditingController();
    college = TextEditingController();
    branch = TextEditingController();
    usn = TextEditingController();
    email = TextEditingController();
    mobile = TextEditingController();
    password = TextEditingController();
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserRegister>(
      create: (context) => UserRegister(),
      child: Scaffold(
        // backgroundColor: Colors.orange[300],
        body: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 15.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.shortestSide * 0.06),
                        child: Text(
                          "Student Register",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.shortestSide * 0.03),
                        child: TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Name cannot be null";
                            } else if (value.trim().length <= 0) {
                              return "Name cannot be null";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.grey,
                            ),
                            hintText: "Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.shortestSide * 0.03),
                        child: TextFormField(
                          controller: college,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "College cannot be null";
                            } else if (value.trim().length <= 0) {
                              return "College cannot be null";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.grey,
                            ),
                            hintText: "College",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.shortestSide * 0.03),
                        child: TextFormField(
                          controller: branch,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Branch cannot be null";
                            } else if (value.trim().length <= 0) {
                              return "Branch cannot be null";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.grey,
                            ),
                            hintText: "Branch\nCSE|ECE|ME|EEE|CIVIL|ISE|ECE|AE",
                            hintMaxLines: 3,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.shortestSide * 0.03),
                        child: TextFormField(
                          controller: usn,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "USN cannot be null";
                            } else if (value.trim().length <= 0) {
                              return "USN cannot be null";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.grey,
                            ),
                            hintText: "USN",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.shortestSide * 0.03),
                        child: TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Email cannot be null";
                            } else if (value.trim().length <= 0) {
                              return "Email cannot be null";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.grey,
                            ),
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.shortestSide * 0.03),
                        child: TextFormField(
                          controller: mobile,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Mobile number cannot be null";
                            } else if (value.trim().length <= 0) {
                              return "Mobile number cannot be null";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.grey,
                            ),
                            hintText: "Mobile",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.shortestSide * 0.03),
                        child: TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Password cannot be null";
                            } else if (value.trim().length <= 0) {
                              return "Password cannot be null";
                            } else if (value.length < 8) {
                              return "Password must be atleast 8 characters";
                            }
                            return null;
                          },
                          obscureText: obsecureText,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (password.text != null) {
                                    obsecureText =
                                        (obsecureText) ? false : true;
                                  }
                                });
                              },
                              icon: (obsecureText)
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                            ),
                            hintText: "PASSWORD",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.shortestSide * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                MediaQuery.of(context).size.shortestSide * 0.15,
                            right: MediaQuery.of(context).size.shortestSide *
                                0.15),
                        child: Container(
                          height:
                              MediaQuery.of(context).size.shortestSide * 0.15,
                          child: Consumer<UserRegister>(
                              builder: (context, userRegister, _) {
                            return RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.orange,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  pr.style(
                                      message: 'Registering User... ',
                                      borderRadius: 20.0,
                                      backgroundColor: Colors.white,
                                      progressWidget:
                                          CircularProgressIndicator(),
                                      elevation: 10.0,
                                      insetAnimCurve: Curves.easeInOut,
                                      progressTextStyle: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400),
                                      messageTextStyle: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.w600));
                                  await pr.show();
                                  UserDetails userDetails = UserDetails(
                                    name: name.text,
                                    college: college.text,
                                    branch: branch.text,
                                    usn: usn.text.toUpperCase(),
                                    email: email.text,
                                    mobile: mobile.text,
                                    password: password.text.toString(),
                                    profile_pic: "https://firebasestorage.googleapis.com/v0/b/ezine-2d748.appspot.com/o/profiles%2Finternship3.png?alt=media&token=b8adb5f3-1439-42ff-acb7-013f8665dadc",
                                  );
                                  var data = userDetails.toJson();
                                  await userRegister.registerUser(data);
                                  if (userRegister.isAdded) {
                                    await pr.hide();
                                    Toast.show(
                                        "User registered successfully. Please login to continue",
                                        context,
                                        duration: Toast.LENGTH_LONG);
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Text(
                                "Register",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.shortestSide * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already Registered?",
                              style: GoogleFonts.roboto(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Login",
                                style: GoogleFonts.roboto(
                                  color: Colors.orange,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
