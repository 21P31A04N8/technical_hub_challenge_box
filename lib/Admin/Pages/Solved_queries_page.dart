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
        body: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(152, 148, 148, 1),
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
                // var data = snapshot.data!.docs;
                // // return Text(data[0]["message"]);

                // return ListView.builder(
                //     itemCount: data.length,
                //     itemBuilder: (context, index) {
                //       return data[index]["isAccepted"]
                //           ? Container(
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(20),
                //                   gradient: LinearGradient(
                //                       begin: AlignmentDirectional.topCenter,
                //                       end: AlignmentDirectional.bottomCenter,
                //                       colors: [Colors.green, Colors.green])),
                //               //padding: EdgeInsets.all(16),
                //               margin: EdgeInsets.symmetric(
                //                   vertical: 2.5, horizontal: 25),
                //               child: Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Complaint_display(
                //                     messege: data[index]["message"],
                //                   ),
                //                   // IconButton(
                //                   //     onPressed: () {
                //                   //       setState(() {
                //                   //         seen(index, data[index]["uuid1"]);
                //                   //       });
                //                   //     },
                //                   //     icon: Icon(Icons.done_outlined))
                //                 ],
                //               ),
                //             )
                //           : null;
                //     });
                return ListView(
                  children: snapshot.data!.docs
                      .map((doc) => _buildMessageItem(doc))
                      .toList(),
                );
              } else {
                return Text('null');
              }
            })
        : Center(child: CircularProgressIndicator());
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return (data["isAccepted"])
        ? Container(
            child: Complaint_display(
            messege: data['message'],
          ))
        : Text("");
  }
}
