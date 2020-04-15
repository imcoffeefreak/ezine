import 'package:ezine/controller/UserDetails/UserLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usn;
  TextEditingController password;
  bool obsecureText = true;
  final _formKey = GlobalKey<FormState>();
  ProgressDialog pr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usn = TextEditingController();
    password = TextEditingController();
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserLogin>(
      create: (context)=>UserLogin(),
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
                height: MediaQuery.of(context).size.height * 0.6,
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
                          "Student Login",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.shortestSide * 0.05),
                        child: TextFormField(
                          controller: usn,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "USN cannot be empty";
                            } else if (value.trim().length <= 0) {
                              return "USN cannot be empty";
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
                      SizedBox(
                        height: MediaQuery.of(context).size.shortestSide * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.shortestSide * 0.05),
                        child: TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Password cannot be empty";
                            } else if (value.trim().length <= 0) {
                              return "Password cannot be empty";
                            } else if (value.length < 8) {
                              return "Password must be atleast 8 character";
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
                                    obsecureText = (obsecureText) ? false : true;
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
                            left: MediaQuery.of(context).size.shortestSide * 0.15,
                            right:
                                MediaQuery.of(context).size.shortestSide * 0.15),
                        child: Container(
                          height: MediaQuery.of(context).size.shortestSide * 0.15,
                          child: Consumer<UserLogin>(
                            builder: (context, userLogin,_) {
                              return RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: Colors.orange,
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    pr.style(
                                        message: 'Logging User... ',
                                        borderRadius: 20.0,
                                        backgroundColor: Colors.white,
                                        progressWidget: CircularProgressIndicator(),
                                        elevation: 10.0,
                                        insetAnimCurve: Curves.easeInOut,
                                        progressTextStyle: GoogleFonts.lato(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                        ),
                                        messageTextStyle: GoogleFonts.lato(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                        ),
                                    );
                                    await pr.show();
                                    int res = await userLogin.userLogin(usn.text.toUpperCase(), password.text);
                                    if(res==204){
                                      await pr.hide();
                                      Navigator.pushReplacementNamed(context, '/homepage');
                                    }else{
                                      await pr.hide();
                                      Toast.show("USN not found", context,duration: Toast.LENGTH_LONG);
                                    }
                                  }
                                },
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.shortestSide * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.shortestSide * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Not Registered?",
                              style: GoogleFonts.roboto(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Text(
                                "Sign Up ",
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
