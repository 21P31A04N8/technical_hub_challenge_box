import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:technical_hub_challenge_box/Admin/Pages/pendingQuery.dart';
import 'package:technical_hub_challenge_box/Auth/Auth_Services.dart';
import 'package:technical_hub_challenge_box/Complaint/Complaint_Services.dart';
import 'package:technical_hub_challenge_box/complaint_display.dart';

class Unsolvedquries extends StatefulWidget {
  Unsolvedquries({super.key});

  @override
  State<Unsolvedquries> createState() => _UnsolvedquriesState();
}

class _UnsolvedquriesState extends State<Unsolvedquries> {
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
        body: _complaintdisplay());
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
                return Text("");
              } else if (snapshot.hasData) {
                var data = snapshot.data!.docs;
                // return Text(data[0]["message"]);

                return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: (data[index]["isAccepted"] == false)
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45,
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
                                            Color(0xFF539463),
                                            Color(0xFF639F71),
                                            Color(0xFF377546),
                                            Color(0xFF74A580)
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
                                            splashColor: Colors.transparent,
                                            icon: Icon(data[index]["isAccepted"]
                                                ? Icons.done_all
                                                : Icons.done_outlined),
                                            color: Color(0xFF68E88C))
                                      ],
                                    ),
                                  )
                                : null,
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
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
