import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/text_field.dart';

// ignore: camel_case_types
class login_page extends StatefulWidget {
  final Function ()? onTap;
  const login_page({super.key,
  required this.onTap});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {

  final emailTextController =TextEditingController();
  final passwordTextController =TextEditingController();

  void signIn()async {

    //
    showDialog(context: context,
     builder: (context)=> const Center(
      child: CircularProgressIndicator(),
     ));
    try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailTextController.text,
     password: passwordTextController.text);
     
    // pop dialgoue
    Navigator.pop(context);

  }
  on FirebaseAuthException catch(e){
    // pop dialgoue
    Navigator.pop(context);
    displayMessage(e.code);
  }
  }

  void displayMessage(String messsage ){
    showDialog(context: context, builder: (context)=>AlertDialog(title: Text(messsage),));
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child:Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
        children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.lock,
              size: 100,
            ),
            const SizedBox(height: 50),
             Text("Welcome Back! You've been missed.",
            style: TextStyle(color: Colors.grey[700])
            ),
            const SizedBox(height: 25),

            MyTextField(controller: emailTextController, hintText: 'Email', obscureText: false),
            const SizedBox(height: 10),
            MyTextField(controller: passwordTextController, hintText: 'Password', obscureText: true),

            const SizedBox(height: 20),
            MyButton(
              onTap: signIn ,
             text: 'Sign In'),

             const SizedBox(height: 20),

             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Not a member?',
              style: TextStyle(color: Colors.grey[700])
              ,),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: widget.onTap,

                child: const Text('Register now', 
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),),
              )
             ],)



        ],
      ),
          )))
    );
  }
}
