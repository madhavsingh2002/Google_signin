import 'package:app/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email = TextEditingController();
  reset() async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
  }
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
        appBar: AppBar(title: Text("Forget Password"),),
        body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child:
         Column(
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: 'Enter email'),
            ),
            ElevatedButton(onPressed: (()=>reset()), child: Text("Send Link"))
          ],
        ),
        )
      );
  }
}