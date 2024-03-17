import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {
  Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  Query dbRef = FirebaseDatabase.instance.ref("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fetching data'),
        ),
        body: Column(
          children: [
            Expanded(
                child: FirebaseAnimatedList(
              query: dbRef,
              itemBuilder: (context, snapshot, animation, index) {
                print(snapshot.child("19a9").value);
                return snapshot.child("19a9").child("role").value == "Admin"
                    ? ElevatedButton(onPressed: () {}, child: Text("Admin"))
                    : snapshot.child("19a9").child("role").value == "User"
                        ? FloatingActionButton(onPressed: () {})
                        : Center(child: Text("Not a User"));
              },
            ))
          ],
        ));
  }
}
