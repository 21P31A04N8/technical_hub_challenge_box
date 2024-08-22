import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:technical_hub_challenge_box/Auth/Auth_Services.dart';
import 'package:technical_hub_challenge_box/Complaint/Complaint_Services.dart';
import 'package:technical_hub_challenge_box/complaint_display.dart';

class Dummy_com_display extends StatefulWidget {
  Dummy_com_display({super.key});

  @override
  State<Dummy_com_display> createState() => _Dummy_com_displayState();
}

class _Dummy_com_displayState extends State<Dummy_com_display> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        // body: Text(userData["role"]),
        body: userData.isNotEmpty
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
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Text("Loading......");
                  } else if (snapshot.hasData) {
                    var data = snapshot.data!.docs;
                    // return Text(data[0]["message"]);

                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Complaint_display(
                            messege: data[index]["message"],
                          );
                        });
                    // return ListView(
                    //   children: snapshot.data!.docs
                    //       .map((doc) => _buildMessageItem(doc))
                    //       .toList(),
                    // );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  Widget _complaintdisplay() {
    return StreamBuilder(
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
                  return Complaint_display(
                    messege: data[index]["message"],
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
        });
  }

  // Widget _buildMessageItem(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

  //   return Container(
  //       child: Complaint_display(
  //     messege: data['message'],
  //   ));
  // }
}
