import 'package:ezine/controller/HomeTabPages/ProfileController.dart';
import 'package:ezine/view/ImageView.dart';
import 'package:ezine/view/PdfViewPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.09,
                                  left:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.05),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red),
                                child: FlutterLogo(
                                  size:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.5,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${profileController.userDetails[0].name}",
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
                                      "${profileController.userDetails[0].college}",
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
                                      "${profileController.userDetails[0].branch}",
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
                                                child: CircleAvatar(
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .shortestSide *
                                                      0.09,
                                                  child: FlutterLogo(),
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
                                                        style: GoogleFonts.lato(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .shortestSide *
                                                            0.3,
                                                    child: Text(
                                                      "${profileController.userDetails[0].branch}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts.roboto(
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
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .shortestSide *
                                                              0.2),
                                                      child: IconButton(
                                                        icon: Icon(
                                                            Icons.open_in_new),
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
                                                                              .pdfPath[
                                                                          index],
                                                                      details: profileController
                                                                              .articleDetails[
                                                                          index],
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
                                                                      details: profileController
                                                                              .articleDetails[
                                                                          index],
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
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            color: Colors.grey,
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
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            );
          }),
        ),
      ),
    );
  }
}
