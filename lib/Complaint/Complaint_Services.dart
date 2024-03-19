import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:technical_hub_challenge_box/Auth/User_Data_Service.dart';
import 'package:technical_hub_challenge_box/Models/Message.dart';
import 'package:uuid/data.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/v4.dart';

class chatservicres {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Stream<List<Map<String, dynamic>>> getUserStream() {
  //   return _firestore.collection('Users').snapshots().map((snapshot) {
  //     return snapshot.docs.map((docs) {
  //       final user = docs.data();
  //       return user;
  //     }).toList();
  //   });
  // }

  Future<void> sendMessege(String message, String queryType) async {
    final String currentuserID = _auth.currentUser!.uid;
    final String currentuseremail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    bool isAccepted = false;
    const uuid = Uuid();
    var id = uuid.v4();

    Message newmessage = Message(
        senderID: currentuserID,
        senderEmail: currentuseremail,
        message: message,
        timestamp: timestamp,
        isAccepted: isAccepted,
        department: queryType,
        uuid1: id);

    // var timeStamp1 = timestamp.toString();
    // List<String> ids = [currentuserID, timeStamp1];
    // // ids.sort();
    // String uniquid = ids.join("");

    await _firestore
        .collection("Users")
        .doc(currentuserID)
        .collection("messages")
        .doc(id)
        .set(newmessage.toMap());
    // .doc(Id)
    // .add(newmessage.toMap());

    await _firestore
        .collection("Admin")
        .doc("adminsDataBasedOnUser")
        .collection(queryType)
        .doc(id)
        .set(newmessage.toMap());
    // addToAdmin(message);
  }

  Stream<QuerySnapshot> getMessage(String userID, currentuseremail) {
    final String currentuserID = _auth.currentUser!.uid;
    List<String> ids = [userID, currentuseremail];
    ids.sort();

    return _firestore
        .collection("Users")
        .doc(currentuserID)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> AdmingetMessage() {
    final String currentuserID = _auth.currentUser!.uid;
    final UserDataService _userDataService = UserDataService();
    _userDataService.getData();

    return _firestore
        .collection("Admin")
        .doc("adminsDataBasedOnUser")
        .collection(_userDataService.userData["roles"])
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
