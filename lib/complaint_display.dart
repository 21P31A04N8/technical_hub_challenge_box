import 'package:flutter/material.dart';

class Complaint_display extends StatelessWidget {
  final String messege;
  Complaint_display({super.key, required this.messege});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              colors: [Colors.green, Colors.green])),
      //padding: EdgeInsets.all(16),
      //margin: EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Text(
          messege,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
