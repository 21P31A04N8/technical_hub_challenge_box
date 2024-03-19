import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:technical_hub_challenge_box/Auth/Auth_Services.dart';
import 'package:technical_hub_challenge_box/Complaint/Complaint_Services.dart';
import 'package:technical_hub_challenge_box/complaint_display.dart';

class AllAdminquerypage extends StatefulWidget {
  AllAdminquerypage({super.key});

  @override
  State<AllAdminquerypage> createState() => _AllAdminquerypageState();
}

class _AllAdminquerypageState extends State<AllAdminquerypage> {
  final chatservicres _chatService = chatservicres();

  final AuthgServices _authServices = AuthgServices();

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
  // void seen(int i, String id) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        // body: Text(userData["role"]),
        body: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(36, 24, 24, 1),
                    Color.fromRGBO(11, 72, 73, 1)
                  ],
                )),
            child: _complaintdisplay()));
  }

  Widget _complaintdisplay() {
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
                return Text("Loading......");
              } else if (snapshot.hasData) {
                var data = snapshot.data!.docs;
                // return Text(data[0]["message"]);

                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                begin: AlignmentDirectional.topCenter,
                                end: AlignmentDirectional.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent
                                ])),
                        //padding: EdgeInsets.all(16),
                        margin:
                            EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Complaint_display(
                              messege: data[index]["message"],
                            ),
                            IconButton(
                                onPressed: () {
                                  // Map<dynamic, dynamic> currentUserID = {};
                                  // // Future getData()  {
                                  // _firestore
                                  //     .collection("Admin")
                                  //     .doc("adminsDataBasedOnUser")
                                  //     .collection(userData["role"])
                                  //     .doc(data[index]["uuid1"])
                                  //     .get()
                                  //     .then((snapshot) {
                                  //   //print(snapshot.data());
                                  //   currentUserID = snapshot.data()!;
                                  // });
                                  // }
                                  // var currentUserID = _firestore
                                  //     .collection("Admin")
                                  //     .doc("adminsDataBasedOnUser")
                                  //     .collection(userData["role"])
                                  //     .doc(data[index]["uuid1"])
                                  //     .snapshots();
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
                                icon: Icon(data[index]["isAccepted"]
                                    ? Icons.done_all
                                    : Icons.done_outlined),
                                color: Colors.green)
                          ],
                        ),
                      );
                    });
                // return ListView(
                //   children: snapshot.data!.docs
                //       .map((doc) => _buildMessageItem(doc))
                //       .toList(),
                // );
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

  //   return Container(
  //       child: Complaint_display(
  //     messege: data['message'],
  //   ));
  // }
}
