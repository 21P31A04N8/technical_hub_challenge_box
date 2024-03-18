import 'package:technical_hub_challenge_box/Auth/Auth_Services.dart';

class UserDataService {
  final _authgServices = AuthgServices();

  Map<dynamic, dynamic> userData = {};

  Future getData() async {
    await _authgServices.firestore
        .collection("Users")
        .doc(_authgServices.auth.currentUser!.uid)
        .get()
        .then((snapshot) {
      //print(snapshot.data());
      userData = snapshot.data()!;
    });
  }
}

// class IsAccepted {
//   final _authgServices = AuthgServices();

//   Map<dynamic, dynamic> isAccepted = {};

//   Future getData() async {
//     await _authgServices.firestore
//         .collection("Users")
//         .doc(_authgServices.auth.currentUser!.uid).collection("messages")
//         .get()
//         .then((snapshot) {
//       //print(snapshot.data());
//       isAccepted = snapshot.;
//     });
//   }
// }