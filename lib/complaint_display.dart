import 'package:flutter/material.dart';

class Complaint_display extends StatelessWidget {
  final String messege;
  Complaint_display({super.key, required this.messege});

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var hi = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          //  boxShadow: [
          //               BoxShadow(
          //                 color: Colors.black,
          //                 spreadRadius: -5,
          //                 blurRadius: 8,
          //                 offset: Offset(0, 3),
          //                 // blurStyle: BlurStyle.inner
          //               )
          //             ],
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              colors: [Colors.transparent, Colors.transparent])),
      //padding: EdgeInsets.all(16),
      //margin: EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 18, bottom: 18),
        child: Text(
          messege,
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
