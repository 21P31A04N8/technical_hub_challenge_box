import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:technical_hub_challenge_box/Auth/Auth_Services.dart';
import 'package:technical_hub_challenge_box/Complaint/Complaint_Services.dart';
import 'package:technical_hub_challenge_box/Pages/Queries_asking_page.dart';
import 'package:technical_hub_challenge_box/complaint_display.dart';

class querybox extends StatefulWidget {
  const querybox({super.key});

  @override
  State<querybox> createState() => _queryboxState();
}

class _queryboxState extends State<querybox> {
  final chatservicres _chatService = chatservicres();
  final AuthgServices _authServices = AuthgServices();
  String _selectedItem = 'Choose one';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var messagecontain = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("message")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    var hi = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromRGBO(11, 72, 73, 1),
                Color.fromRGBO(6, 37, 37, 1)
              ])),
          child: Column(children: [
            SizedBox(
              height: hi / 9,
            ),
            Container(
              height: hi / 15,
              width: wi / 1.1,
              color: Colors.transparent,
              child: Center(
                  child: Text(
                "Query",
                style: TextStyle(fontSize: 24, color: Colors.white),
              )),
            ),
            //Text("${messagecontain.isEmpty}"),
            Expanded(child: _buildmessageList()),
          ])),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => comment()));
          },
          child: Icon(Icons.add),
          tooltip: 'Add',
          backgroundColor: Colors.green,
        ),
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  Widget _buildmessageList() {
    String? senderemail = _authServices.getCurrentUser()!.email;
    String senderID = _authServices.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessage(senderID, senderemail),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          } else {
            return
                // Text(
                //     "NO DATA",
                //     style: TextStyle(color: Colors.white, fontSize: 100),
                //   )
                ListView(
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageItem(doc))
                  .toList(),
            );
            // : Lottie.asset(
            //     'lib/Assets/Animation2.json',
            //     // Path to your Lottie animation file
            //     width: 50, // Adjust width of the animation
            //     height: 50, // Adjust height of the animation
            //     fit: BoxFit.cover,
            //   );
          }
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 0.0001,
              blurRadius: 8,
              offset: Offset(0, 10),
              // blurStyle: BlurStyle.inner
            )
          ],
          // border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0B4948), Color(0xFF062525)])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Complaint_display(
              messege: data['message'],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              (data["isAccepted"] == true && data["isSolved"] == false)
                  ? "Accepted"
                  : (data["isSolved"] == true && data["isAccepted"] == true)
                      ? "Solved"
                      : "Pending",
              style: TextStyle(color: Color(0xFF68E88C)),
            ),
          )
        ],
      ),
    );
  }
}
