import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:technical_hub_challenge_box/Auth/Auth_Services.dart';
// import 'package:technical_hub_challenge_box/Complaint/Complaint_Services.dart';
import 'package:technical_hub_challenge_box/complaint_display.dart';
// import 'package:uuid/uuid.dart';

class Unsolvedquries extends StatefulWidget {
  Unsolvedquries({super.key});

  @override
  State<Unsolvedquries> createState() => _UnsolvedquriesState();
}

class _UnsolvedquriesState extends State<Unsolvedquries> {
  // final _auth = FirebaseAuth.instance;
  // final chatservicres _chatService = chatservicres();

  // final AuthgServices _authServices = AuthgServices();

  Map<dynamic, dynamic> userData = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _firestore
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
      setState(() {});
      userData = snapshot.data()!;
    });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // void Function()? seen(int i) {
  //   var id;
  //   _firestore
  //       .collection("Admin")
  //       .doc("adminsDataBasedOnUser")
  //       .collection(userData["role"])
  //       .get()
  //       .then((snapshots) {
  //     id = snapshots.docs[i].id;
  //     print(id);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        // body: Text(userData["role"]),
        body: _complaintdisplay());
  }

  Widget _complaintdisplay() {
    // void Function()? seen(int i, String id) {
    //   // var id;
    //   // List docid = [currentuserID, timeStamp];
    //   // id = docid.join("");
    //   _firestore
    //       .collection("Admin")
    //       .doc("adminsDataBasedOnUser")
    //       .collection(userData["role"])
    //       .doc(id)
    //       .update({"isAccepted": true});
    //   print(
    //       "===================================Seen tapped================================");
    // }

    return userData.isNotEmpty
        ? StreamBuilder(
            stream: _firestore
                .collection("Admin")
                .doc("adminsDataBasedOnUser")
                .collection(userData["role"])
                .orderBy("timestamp", descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error");
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("");
              } else if (snapshot.hasData) {
                var data = snapshot.data!.docs;
                return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 10),
                        child: (data[index]["isSolved"] == false &&
                                data[index]["isAccepted"] == false)
                            ? Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      blurRadius: 8,
                                      offset: Offset(0, 10),
                                    )
                                  ],
                                  // border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF539463).withOpacity(0.7),
                                        Color(0xFF639F71).withOpacity(0.7),
                                        Color(0xFF377546).withOpacity(0.7),
                                        Color(0xFF74A580).withOpacity(0.7)
                                      ]),
                                ),
                                // padding: EdgeInsets.all(16),
                                // margin: EdgeInsets.symmetric(
                                //     vertical: 2.5, horizontal: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      // height: 90,
                                      width: 290,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${data[index]["message"]}',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          _firestore
                                              .collection("Admin")
                                              .doc("adminsDataBasedOnUser")
                                              .collection(userData["role"])
                                              .doc(data[index]["uuid1"])
                                              .update({"isAccepted": true});
                                          print(
                                              "===================================Seen tapped================================");
                                          _firestore
                                              .collection("Users")
                                              .doc(data[index]["senderID"])
                                              .collection("messages")
                                              .doc(data[index]["uuid1"])
                                              .update({"isAccepted": true});
                                          print(
                                              "===================================Seen tapped123345566================================");
                                          print(data[index]["senderID"]);
                                        },
                                        splashColor: Colors.transparent,
                                        icon: Icon(data[index]["isAccepted"]
                                            ? Icons.done_all
                                            : Icons.done_outlined),
                                        color: Color(0xFF68E88C))
                                  ],
                                ),
                              )
                            : SizedBox(),
                      );
                    });
              } else {
                return Text('null');
              }
            })
        : Center(
            child: CircularProgressIndicator(
            color: Colors.green,
          ));
  }

  // Widget _buildMessageItem(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

  //   return (data["isAccepted"])
  //       ? Container(
  //           decoration: BoxDecoration(
  //               border: Border.all(color: Colors.green),
  //               borderRadius: BorderRadius.circular(20),
  //               gradient: LinearGradient(
  //                   begin: AlignmentDirectional.topCenter,
  //                   end: AlignmentDirectional.bottomCenter,
  //                   colors: [Colors.transparent, Colors.transparent])),
  //           //padding: EdgeInsets.all(16),
  //           margin: EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Row(
  //               children: [
  //                 Complaint_display(
  //                   messege: data['message'],
  //                 ),
  //               ],
  //             ),
  //           ))
  //       : SizedBox();
  // }
}
