import 'dart:io';

import 'package:ezine/controller/HomeTabPages/UploadController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  TextEditingController article_name;
  TextEditingController article_description;
  TextEditingController fileName;
  final _formKey = GlobalKey<FormState>();
  ProgressDialog pr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    article_description = TextEditingController();
    article_name = TextEditingController();
    fileName = TextEditingController();
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UploadController>(
      create: (context) => UploadController(),
      child:
          Consumer<UploadController>(builder: (context, uploadController, _) {
        return Card(
          elevation: 20.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.shortestSide * 0.05,
                          left: MediaQuery.of(context).size.shortestSide * 0.05,
                          right:
                              MediaQuery.of(context).size.shortestSide * 0.05,
                        ),
                        child: Text(
                          "Article Upload",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.shortestSide * 0.05,
                        right: MediaQuery.of(context).size.shortestSide * 0.05,
                      ),
                      child: Divider(
                        color: Colors.orange,
                        thickness: 5,
                        endIndent: MediaQuery.of(context).size.width * 0.7,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.shortestSide * 0.07),
                      child: TextFormField(
                        controller: article_name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Article Name cannot be null";
                          } else if (value.trim().length <= 0) {
                            return "Article Name cannot be null";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Article Title",
                          labelText: "Article Title",
                          labelStyle: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.shortestSide * 0.07),
                      child: TextFormField(
                        controller: article_description,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Description cannot be null";
                          } else if (value.trim().length <= 0) {
                            return "Description cannot be null";
                          }
                          return null;
                        },
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Description",
                          labelText: "Description",
                          labelStyle: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.shortestSide * 0.07),
                      child: TextFormField(
                        readOnly: true,
                        controller: fileName,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "File cannot be null";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "File Upload",
                          labelText: "File Upload",
                          labelStyle: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () async {
                          await uploadController.getFiles();
                          setState(() {
                            fileName.text = uploadController.fileList[0]
                                .split('/')
                                .last
                                .split('\'')[0];
                          });
                        },
                      ),
                    ),
                    (uploadController.fileList.length != 0)
                        ? Container(
                            child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: uploadController.fileList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.orange),
                                        onPressed: () {
                                          uploadController.deleteFile(index);
                                          fileName.clear();
                                        },
                                      ),
                                      title: Text(
                                        "${uploadController.fileList[index].split('/').last.split('\'')[0]}",
                                        style: GoogleFonts.lato(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : Text(
                            "No Articles Uploaded",
                            style: GoogleFonts.lato(
                              color: Colors.black,
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.shortestSide * 0.07),
                      child: Container(
                        height: MediaQuery.of(context).size.shortestSide * 0.15,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.orange,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              pr.style(
                                message: 'Submitting Article... ',
                                borderRadius: 20.0,
                                backgroundColor: Colors.white,
                                progressWidget: SizedBox(
                                  width: 5.0,
                                  height:5.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.orange),
                                  ),
                                ),
                                elevation: 10.0,
                                insetAnimCurve: Curves.easeInOut,
                                progressTextStyle: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 5.0,
                                ),
                                messageTextStyle: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              );
                              await pr.show();
                              int res = await uploadController.addArticle(
                                  article_name.text,
                                  article_description.text,
                                  uploadController.fileList[0]
                                      .split('/')
                                      .last
                                      .split('\'')[0]);
                              if (res == 204) {
                                fileName.clear();
                                article_description.clear();
                                article_name.clear();
                                await pr.hide();
                                Toast.show(
                                    "Successfully submitted the article. Waiting for mod to approve",
                                    context,
                                    duration: Toast.LENGTH_LONG);
                              } else {
                                await pr.hide();
                                Toast.show(
                                    "Something went wrong! Please try again later!",
                                    context,
                                    duration: Toast.LENGTH_LONG);
                              }
                            }
                          },
                          child: Text("Upload Article"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
