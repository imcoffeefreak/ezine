import 'package:ezine/controller/HomeTabPages/ProfileController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              height: MediaQuery.of(context).size.height,
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
                        (profileController.articleDetails.isNotEmpty)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  // physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      profileController.articleDetails.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: ListTile(
                                          title: Text(
                                            "${profileController.articleDetails[index].article_title}",
                                            style: GoogleFonts.robotoCondensed(
                                              color: Colors.black,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                          subtitle: Text(
                                            "${profileController.articleDetails[index].description}",
                                            style: GoogleFonts.robotoCondensed(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          trailing: ActionChip(
                                            backgroundColor: (profileController
                                                    .articleDetails[index]
                                                    .is_approved)
                                                ? Colors.green
                                                : Colors.yellow,
                                            label: (profileController
                                                    .articleDetails[index]
                                                    .is_approved)
                                                ? Text(
                                                    "Approved",
                                                    style: GoogleFonts
                                                        .robotoCondensed(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                    ),
                                                  )
                                                : Text(
                                                    "Pending",
                                                    style: GoogleFonts
                                                        .robotoCondensed(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
