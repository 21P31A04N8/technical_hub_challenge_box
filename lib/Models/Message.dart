import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final bool isAccepted;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.senderID,
      required this.senderEmail,
      required this.isAccepted,
      required this.message,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'isAccepted': isAccepted,
      'message': message,
      'timestamp': timestamp
    };
  }
}
