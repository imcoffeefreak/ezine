import 'package:ezine/controller/HomeTabPages/ProfileController.dart';
import 'package:ezine/view/HomePage/viewer/ImageView.dart';
import 'package:ezine/view/HomePage/viewer/PdfViewPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileController>(
      create: (context) => ProfileController(),
      child: Card(
        elevation: 20.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Consumer<ProfileController>(
            builder: (context, profileController, _) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
                child: (profileController.userDetails.isNotEmpty)
                    ? Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.1,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: PopupMenuButton(
                              offset: Offset(0, 100),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.exit_to_app,
                                      color: Color(0xFF1B1F5C),
                                    ),
                                    title: Text(
                                      "Logout",
                                      style: GoogleFonts.lato(),
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.edit,
                                      color: Color(0xFF1B1F5C),
                                    ),
                                    title: Text(
                                      "Edit Profile",
                                      style: GoogleFonts.lato(),
                                    ),
                                  ),
                                ),
                              ],
                              onCanceled: () {
                                print("You have canceled the menu.");
                              },
                              onSelected: (value) {
                                if (value == 1) {
                                  profileController.logout().then((code) {
                                    if (code == 200) {
                                      Navigator.pushReplacementNamed(
                                          context, '/login');
                                    } else {
                                      Toast.show(
                                          "Error while logging out! Please try again",
                                          context);
                                    }
                                  });
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          "User Update",
                                          style: GoogleFonts.lato(),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        content: Container(
                                          child: Form(
                                            child: ListView(
                                              shrinkWrap: true,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    controller:
                                                        profileController.name,
                                                    decoration: InputDecoration(
                                                        hintText: "Name",
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF1B1F5C),
                                                                )),
                                                        hintStyle:
                                                            GoogleFonts.lato(
                                                                color: Colors
                                                                    .grey),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF1B1F5C),
                                                                ))),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "College Name",
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF1B1F5C),
                                                                )),
                                                        hintStyle:
                                                            GoogleFonts.lato(
                                                                color: Colors
                                                                    .grey),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF1B1F5C),
                                                                ))),
                                                    controller:
                                                        profileController
                                                            .college,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                        hintText: "Branch Name",
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF1B1F5C),
                                                                )),
                                                        hintStyle:
                                                            GoogleFonts.lato(
                                                                color: Colors
                                                                    .grey),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF1B1F5C),
                                                                ))),
                                                    controller:
                                                        profileController
                                                            .branch,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      hintText: "Mobile Number",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0xFF1B1F5C),
                                                              )),
                                                      hintStyle:
                                                          GoogleFonts.lato(
                                                              color:
                                                                  Colors.grey),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF1B1F5C),
                                                        ),
                                                      ),
                                                    ),
                                                    controller:
                                                        profileController
                                                            .mobileNumber,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    controller:
                                                        profileController
                                                            .profile,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return "File cannot be null";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      hintText: "File Upload",
                                                      labelText: "File Upload",
                                                      labelStyle:
                                                          GoogleFonts.roboto(
                                                        fontSize: 15,
                                                        color: Colors.grey,
                                                      ),
                                                      hintStyle:
                                                          GoogleFonts.roboto(
                                                        fontSize: 15,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    onTap: () async {
                                                      await profileController
                                                          .getUploadedFile();
                                                      profileController
                                                              .profile.text =
                                                          profileController
                                                              .fileList[0]
                                                              .split('/')
                                                              .last
                                                              .split('\'')[0];
                                                      name = profileController
                                                          .fileList[0]
                                                          .split('/')
                                                          .last
                                                          .split('\'')[0];
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () async {
                                              var code = await profileController
                                                  .updateProfile(name);
                                              Navigator.pop(context);
                                              if (code == 200) {
                                                Toast.show(
                                                    "Updated successfully",
                                                    context);
                                              } else {
                                                Toast.show(
                                                    "Updation failed! Try again later",
                                                    context);
                                              }
                                            },
                                            child: Text("Submit"),
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancel"),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.more_vert,
                                color: Color(0xFF1B1F5C),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.05),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: Text(""),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        profileController
                                            .userDetails[0].profile_pic,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Name: ${profileController.userDetails[0].name}",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.robotoCondensed(
                                          color: Colors.black,
                                          fontSize: 25.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "College: ${profileController.userDetails[0].college}",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.robotoCondensed(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Branch: ${profileController.userDetails[0].branch}",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.robotoCondensed(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                                color: Colors.grey,
                                thickness: 5.0,
                                indent: MediaQuery.of(context).size.width * 0.2,
                                endIndent:
                                    MediaQuery.of(context).size.width * 0.2),
                          ),
                          (profileController.articleDetails.isNotEmpty &&
                                  profileController.pdfPath.isNotEmpty)
                              ? ListView.separated(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return Divider();
                                  },
                                  itemCount:
                                      profileController.articleDetails.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: 8.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                        .size
                                                        .shortestSide *
                                                    0.03),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .shortestSide *
                                                  0.9,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .shortestSide *
                                                  0.3,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.grey,
                                                image: (profileController
                                                                .articleDetails[
                                                                    index]
                                                                .type ==
                                                            ".jpg" ||
                                                        profileController
                                                                .articleDetails[
                                                                    index]
                                                                .type ==
                                                            ".jpeg" ||
                                                        profileController
                                                                .articleDetails[
                                                                    index]
                                                                .type ==
                                                            ".png")
                                                    ? DecorationImage(
                                                        image: NetworkImage(
                                                          profileController
                                                              .articleDetails[
                                                                  index]
                                                              .file,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/pdf.png"),
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .shortestSide *
                                                0.9,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .shortestSide *
                                                0.2,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
//                                        color: Colors.grey,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.all(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .shortestSide *
                                                          0.02),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                    child: Text(""),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                          profileController
                                                              .userDetails[0]
                                                              .profile_pic,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .shortestSide *
                                                              0.03),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .shortestSide *
                                                            0.3,
                                                        child: Text(
                                                          "${profileController.userDetails[0].name}",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .shortestSide *
                                                          0.3,
                                                      child: Text(
                                                        "${profileController.userDetails[0].branch}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .shortestSide *
                                                                0.2),
                                                        child: IconButton(
                                                          icon: Icon(Icons
                                                              .open_in_new),
                                                          onPressed: () {
                                                            print(
                                                                "************* ${profileController.articleDetails[index].type == ".pdf"}");
                                                            (profileController
                                                                        .articleDetails[
                                                                            index]
                                                                        .type ==
                                                                    ".pdf")
                                                                ? Navigator.of(
                                                                        context)
                                                                    .push(
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              PdfViewPage(
                                                                        path: profileController
                                                                            .pdfPath[index],
                                                                        details:
                                                                            profileController.articleDetails[index],
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Navigator.of(
                                                                        context)
                                                                    .push(
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              ImageView(
                                                                        details:
                                                                            profileController.articleDetails[index],
                                                                      ),
                                                                    ),
                                                                  );
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .shortestSide *
                                                                0.15),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Text(
                                                            "${DateFormat("dd-MM-yyyy").format(DateTime.fromMicrosecondsSinceEpoch(profileController.articleDetails[index].published_date * 1000))}",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : (profileController.isLoading)
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide *
                                              0.3),
                                      child: Center(
                                        child: Text(
                                          "No Articles Found!",
                                          style: GoogleFonts.lato(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1B1F5C),
                                          ),
                                        ),
                                      ),
                                    ),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
