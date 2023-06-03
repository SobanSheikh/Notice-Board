import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/text_field.dart';

class Register_Page extends StatefulWidget {
  final Function()? onTap;
  const Register_Page({super.key,
    this.onTap});

  @override
  State<Register_Page> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Register_Page> {

  final emailTextController =TextEditingController();
  final passwordTextController =TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  void SignUp() async{
    showDialog(context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),);


    if(passwordTextController.text!=confirmPasswordTextController.text)
    {
      Navigator.pop(context);
      displayMessage("Passwords don't match");
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text,
         password: passwordTextController.text);

         Navigator.pop(context);
      
    } on FirebaseAuthException catch (e) {
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
             Text("Lets create your account.",
            style: TextStyle(color: Colors.grey[700])
            ),
            const SizedBox(height: 25),

            MyTextField(controller: emailTextController, hintText: 'Email', obscureText: false),
            const SizedBox(height: 10),
            MyTextField(controller: passwordTextController, hintText: 'Password', obscureText: true),

            const SizedBox(height: 10),
            MyTextField(controller: confirmPasswordTextController, hintText: 'Confirm Password', obscureText: true),

            

            const SizedBox(height: 20),
            MyButton(
              onTap: SignUp,
             text: 'Sign Up'),

             const SizedBox(height: 20),

             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Already have an account?',
              style: TextStyle(color: Colors.grey[700])
              ,),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: widget.onTap,

                child: const Text('Login', 
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