import 'package:app/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading =  false;
  signUp() async{
     setState(() {
      isLoading = true;
    });
     try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
    Get.offAll(Wrapper());
    }on FirebaseAuthException catch(e){
      Get.snackbar('Error Message', e.code);
    }
    catch(e){
      Get.snackbar('Error Message', e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return 
    isLoading? Center(child: CircularProgressIndicator(),) : Scaffold(
        appBar: AppBar(title: Text("Sign Up"),),
        body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child:
         Column(
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: 'Enter email'),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(hintText: 'Enter Password'),
            ),
            ElevatedButton(onPressed: (()=>signUp()), child: Text("Sign Up"))
          ],
        ),
        )
      );
  }
}