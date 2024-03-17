// import 'package:chat_app/Auth/Auth_services.dart';
import 'package:flutter/material.dart';
import 'package:technical_hub_challenge_box/Auth/Auth_Services.dart';
import 'package:technical_hub_challenge_box/Pages/Second.dart';

class Login_Page extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwoedController = TextEditingController();
  final void Function()? onTap;
  Login_Page({super.key, required this.onTap});
  void login(BuildContext context) async {
    final authservice = AuthgServices();
    try {
      await authservice.signInWithEmailPassword(
          _emailController.text, _passwoedController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
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
            Text("Welcome back,You've been missed!!",
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
              height: 40,
            ),
            InkWell(
              onTap: () => login(context),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Center(child: Text("Login")),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("If You are not a member"),
                  InkWell(
                    onTap: onTap,
                    child: Text(
                      "Register Now",
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
