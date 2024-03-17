import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:technical_hub_challenge_box/Auth/Loginorregister.dart';
import 'package:technical_hub_challenge_box/Auth/User_Data_Service.dart';
import 'package:technical_hub_challenge_box/Pages/Second.dart';

class Auth_gate extends StatefulWidget {
  const Auth_gate({super.key});

  @override
  State<Auth_gate> createState() => _Auth_gateState();
}

class _Auth_gateState extends State<Auth_gate> {
  // final UserDataService _user = UserDataService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // _user.getData();
          if (snapshot.hasData) {
            return SecondScreen();
          } else {
            return LoginorRegister();
          }
        },
      ),
    );
  }
}
