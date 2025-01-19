import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blue,
        actions: [
          GestureDetector(
            onTap: ()async{
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=>SignInScreen()));
            },
              child: Icon(Icons.logout)
          ),
        ],
      ),
    );
  }
}
