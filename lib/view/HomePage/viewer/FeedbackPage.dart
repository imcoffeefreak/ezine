import 'package:ezine/controller/Feedback/FeedbackController.dart';
import 'package:ezine/model/Feedback/FeedbackModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FeedbackChatPage extends StatefulWidget {
  String docId;

  FeedbackChatPage({@required this.docId});

  @override
  _FeedbackChatPageState createState() => _FeedbackChatPageState();
}

class _FeedbackChatPageState extends State<FeedbackChatPage> {
  TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedbackController>(
      create: (context) => FeedbackController(docId: widget.docId),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Feedback",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lato(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Consumer<FeedbackController>(
                builder: (context, feedbackController, _) {
                  return Flexible(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                      ),
                      child: (feedbackController.chats.isNotEmpty &&
                              feedbackController.users.isNotEmpty)
                          ? ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(8),
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.05,
                                );
                              },
                              itemCount: feedbackController.chats.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                      width: MediaQuery.of(context)
                                              .size
                                              .shortestSide *
                                          0.15,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            feedbackController
                                                .users[index].profile_pic,
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "${feedbackController.users[index].name}",
                                      style: GoogleFonts.lato(),
                                    ),
                                    subtitle: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "${feedbackController.chats[index].message}",
                                            style: GoogleFonts.roboto(),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "${DateFormat("dd-MM-yyyy").format(DateTime.fromMicrosecondsSinceEpoch(feedbackController.chats[index].created_at*1000))}",
                                              style: GoogleFonts.roboto(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.orange
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                "Provide Feedback!",
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),
              Consumer<FeedbackController>(
                  builder: (context, feedbackController, _) {
                return Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: "Feedback",
                            hintStyle: GoogleFonts.roboto(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.shortestSide * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1B1F5C),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              var chat = FeedbackModel(
                                message: controller.text,
                                userId: feedbackController.userId,
                                created_at:
                                    DateTime.now().millisecondsSinceEpoch,
                              );
                              feedbackController.sendFeedback(
                                  docId: widget.docId, json: chat.toJson());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
