import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              child: Card(
                color: Colors.green[400],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  "Query",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            ),
            Expanded(child: _buildmessageList()),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => comment()));
          },
          child: Icon(Icons.add),
          tooltip: 'Add',
          backgroundColor: Colors.green,
        ));
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
            return Text("Loading......");
          } else {
            return ListView(
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageItem(doc))
                  .toList(),
            );
          }
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Container(
        child: Complaint_display(
      messege: data['message'],
    ));
  }
}
