import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/drawer.dart';
import 'package:my_app/components/text_field.dart';
import 'package:my_app/components/wall_post.dart';
import 'package:my_app/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();

  void SignOut () async{
    FirebaseAuth.instance.signOut();
  }

  void postMessage(){
    //only post if there is somethiing in the textfield
    if(textController.text.isNotEmpty){
      FirebaseFirestore.instance.collection("User Posts")
      .add(
        {"UserEmail":currentUser.email,
      'Message':textController.text,
      'TimeStamp':Timestamp.now(),
      'Likes':[],
    }
    );

    //clear textfield
    setState(() {
      textController.clear();
    });
    }

  }

  // goto profile

  void goToProfile(){
    Navigator.pop(context);
    Navigator.push(context, 
    MaterialPageRoute(builder: (context)=>const ProfilePage(),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        onProfileTap: goToProfile,
        onSignOutTap: SignOut,
      ),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("Notice Board"),
      centerTitle: true,
      
      backgroundColor: Colors.grey[900],
     
      ),

      body: Column(
        children: [

          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
              .collection("User Posts")
              .orderBy("TimeStamp",descending: false)
              .snapshots(),
              builder:(context, snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                      final post = snapshot.data!.docs[index];
                      return WallPost(messsage: post['Message'], user: post['UserEmail'],
                      postId: post.id,
                      likes: List<String>.from(post['Likes']?? []),);

                  },
                  );
                } else if(snapshot.hasError){
                  return Center(
                    child: Text('Error:${snapshot.error}'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },

          )),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child:
                 MyTextField
                 (controller: textController, hintText: 'Write Something on notice board',
                  obscureText: false)),

                  IconButton(onPressed: postMessage,
                   icon: Icon(Icons.arrow_circle_up))
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(bottom:20.0),
            child: Text('Logged in as '+ currentUser.email!,
            style: TextStyle(color: Colors.grey[500]),),
          ),

        ]),
    
    );
  }
}