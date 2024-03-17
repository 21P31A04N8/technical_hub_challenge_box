import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:technical_hub_challenge_box/Admin/Pages/Admin_queries_page.dart";
import "package:technical_hub_challenge_box/Admin/Pages/Dummy_complaints_display.dart";
import "package:technical_hub_challenge_box/Auth/Auth_Services.dart";
import "package:technical_hub_challenge_box/Auth/User_Data_Service.dart";
import 'package:technical_hub_challenge_box/Pages/Queries_asking_page.dart';
import "package:technical_hub_challenge_box/Pages/Queries_page.dart";

class SecondScreen extends StatefulWidget {
  SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final UserDataService _user = UserDataService();

  void logout() {
    final _auth = AuthgServices();
    _auth.sighout();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_user.userData["role"]);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[600],
          centerTitle: true,
          actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
          title: Text("Profile"),
        ),
        body: FutureBuilder(
            future: _user.getData(),
            builder: (context, snapshot) {
              return Center(
                  child: _user.userData["role"] == null
                      ? ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 75, 72, 72))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => querybox()));
                          },
                          child: Text("Query"))
                      : ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Admin_query_page()));
                          },
                          child: Text("Admin")));
            }));
  }
}
