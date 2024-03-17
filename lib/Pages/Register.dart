// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Registration extends StatefulWidget {
//   const Registration({super.key});

//   @override
//   State<Registration> createState() => _RegistrationState();
// }

// class _RegistrationState extends State<Registration> {
//   @override
//   Widget build(BuildContext context) {
//     final _email = TextEditingController();
//     final _pass = TextEditingController();
//     final formkey = GlobalKey<FormState>();
//     int h = MediaQuery.of(context).size.height.toInt();
//     int w = MediaQuery.of(context).size.width.toInt();
//     return Container(
//       decoration: BoxDecoration(
//           image: DecorationImage(
//               fit: BoxFit.cover,
//               image: NetworkImage(
//                   "https://cdn.pixabay.com/photo/2023/10/07/23/39/girl-8301168_640.png"))),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Form(
//           child: Center(
//             child: SingleChildScrollView(
//               child: Container(
//                 height: h.toDouble(),
//                 width: w.toDouble(),
//                 color: Colors.white.withOpacity(0.5),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Sign Up",
//                       style: TextStyle(
//                           fontSize: 30,
//                           fontFamily: 'Courier New',
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20.0),
//                       child: TextFormField(
//                         controller: _email,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: "Email Id",
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20.0),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: "User name",
//                         ),
//                         validator: (val) => val!.isEmpty ? "Enter Email" : null,
//                       ),
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0),
//                       child: TextFormField(
//                         controller: _pass,
//                         decoration: InputDecoration(
//                           //icon: Icon(Icons.remove_red_eye),
//                           border: OutlineInputBorder(),
//                           hintText: "Password",
//                         ),
//                         validator: (val) => val!.isEmpty ? "Enter Email" : null,
//                         obscureText: true,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           //icon: Icon(Icons.remove_red_eye),
//                           border: OutlineInputBorder(),
//                           hintText: "Confirm Password",
//                         ),
//                         obscureText: true,
//                       ),
//                     ),
//                     Padding(
//                         padding: const EdgeInsets.only(top: 20.0),
//                         child: SizedBox(
//                           width: 500,
//                           height: 40,
//                           child: TextButton(
//                             onPressed: () {
//                               Future<void> createuser() async {
//                                 await FirebaseAuth.instance
//                                     .createUserWithEmailAndPassword(
//                                         email: "${_email.text}",
//                                         password: "${_pass.text}");
//                               }

//                               createuser();
//                               Navigator.pop(context);
//                             },
//                             child: Text(
//                               "Register",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             style: TextButton.styleFrom(
//                               backgroundColor: Colors.lightBlueAccent,
//                             ),
//                           ),
//                         )),
//                     Row(
//                       children: [
//                         SizedBox(width: 160, child: Divider(height: 100)),
//                         Padding(
//                           padding:
//                               const EdgeInsets.only(left: 16.0, right: 16.0),
//                           child: Text("OR"),
//                         ),
//                         SizedBox(
//                             width: 180,
//                             child: Divider(
//                               height: 100,
//                             )),
//                       ],
//                     ),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         //Image.network(width: 25,'https://cdn.pixabay.com/photo/2015/12/11/11/43/google-1088004_640.png'),
//                         Text(
//                           "If you are already registered",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text(
//                             "Login",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 15),
//                           ),
//                         )
//                       ],
//                     ),

//                     //Divider(height: 180,color: Colors.black,),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:technical_hub_challenge_box/Auth/Auth_Services.dart';

class Register extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwoedController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final void Function()? onTap;
  Register({super.key, required this.onTap});
  void Register_now(BuildContext context) {
    final _auth = AuthgServices();
    if (_passwoedController.text == _confirmController.text) {
      try {
        _auth.signUpWithEmailPassword(
            _emailController.text, _passwoedController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Password do not match"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Colors.grey.shade500,
            ),
            SizedBox(
              height: 50,
            ),
            Text("Lets Create a Account for you",
                style: TextStyle(fontSize: 16)),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade500)),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: "Email Id",
                    hintStyle: TextStyle(color: Colors.grey.shade300)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _passwoedController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade500)),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey.shade300)),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _confirmController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade500)),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(color: Colors.grey.shade300)),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () => Register_now(context),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Center(child: Text("Register")),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have a Account?"),
                  InkWell(
                    onTap: onTap,
                    child: Text(
                      "Login now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
