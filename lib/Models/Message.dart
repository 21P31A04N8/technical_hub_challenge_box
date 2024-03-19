import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final bool isAccepted;
  final String message;
  final String uuid1;
  final String department;
  final Timestamp timestamp;

  Message(
      {required this.senderID,
      required this.department,
      required this.senderEmail,
      required this.isAccepted,
      required this.message,
      required this.uuid1,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'isAccepted': isAccepted,
      'message': message,
      'timestamp': timestamp,
      'uuid1': uuid1,
      'department': department
    };
  }
}
