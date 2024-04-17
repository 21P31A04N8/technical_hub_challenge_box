import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:technical_hub_challenge_box/Auth/Auth_Services.dart';
// import 'package:technical_hub_challenge_box/Complaint/Complaint_Services.dart';
import 'package:technical_hub_challenge_box/complaint_display.dart';
// import 'package:uuid/uuid.dart';

class Solvedqueries extends StatefulWidget {
  Solvedqueries({super.key});

  @override
  State<Solvedqueries> createState() => _SolvedqueriesState();
}

class _SolvedqueriesState extends State<Solvedqueries> {
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
                return ListView(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  children: snapshot.data!.docs
                      .map((doc) => _buildMessageItem(doc))
                      .toList(),
                );
              } else {
                return Text('null');
              }
            })
        : Center(
            child: CircularProgressIndicator(
            color: Colors.green,
          ));
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return (data["isSolved"])
        ? Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  )
                ],
                // border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0B4948), Color(0xFF062525)])),
            //padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Complaint_display(
                messege: data['message'],
              ),
            ))
        : SizedBox();
  }
}
