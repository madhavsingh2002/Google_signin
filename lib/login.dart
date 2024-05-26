import 'package:app/forgetPassword.dart';
import 'package:app/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  signIn() async{
    setState(() {
      isLoading = true;
    });
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
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
  signInWithGoogle() async{
    final GoogleSignInAccount? googleUser =  await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
  @override
  Widget build(BuildContext context) {
    return 
      isLoading? Center(child: CircularProgressIndicator(),) : Scaffold(
        appBar: AppBar(title: Text("Login"),),
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
             ElevatedButton(onPressed: (()=>signInWithGoogle()), child: Text("Sign In With Google")),
            ElevatedButton(onPressed: (()=>signIn()), child: Text("Login")),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (()=>Get.to(SignUp())), child: Text("Register Now")),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (()=>Get.to(ForgetPassword())), child: Text("Forget Password"))
          ],
        ),
        )
      )
    ;
  }
}