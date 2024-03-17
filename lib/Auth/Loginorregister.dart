import 'package:flutter/material.dart';
import 'package:technical_hub_challenge_box/Pages/Register.dart';
import 'package:technical_hub_challenge_box/Pages/login.dart';

class LoginorRegister extends StatefulWidget {
  LoginorRegister({super.key});

  @override
  State<LoginorRegister> createState() => _LoginorRegisterState();
}

class _LoginorRegisterState extends State<LoginorRegister> {
  bool showloginPage = true;

  void togglePages() {
    setState(() {
      showloginPage = !showloginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginPage) {
      return Login_Page(
        onTap: togglePages,
      );
    } else {
      return Register(
        onTap: togglePages,
      );
    }
  }
}
