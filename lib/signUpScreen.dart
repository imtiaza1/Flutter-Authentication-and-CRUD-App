import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/Login.dart';
import 'package:todoapp/services/firebaseAuth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _HomeState();
}

class _HomeState extends State<SignUpScreen> {
  TextEditingController userController=TextEditingController();
  TextEditingController emaiController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  User? currentUser=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUpScreen",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 250.0,
                  alignment: Alignment.center,
                  child: Lottie.asset("assets/Animation - 1736890968846.json"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextField(
                      controller: userController,
                      decoration: InputDecoration(
                          hintText: "User Name",
                          enabledBorder: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.person)
                      ),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextField(
                      controller: emaiController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          enabledBorder: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.email)
                      ),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          hintText: "Phone",
                          enabledBorder: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.phone)
                      ),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          enabledBorder: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.password)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                ElevatedButton(
                  onPressed: () async{
                    // Add your login logic here
                    var userName=userController.text.trim();
                    var email=emaiController.text.trim();
                    var phone=phoneController.text.toString();
                    var password=passwordController.text.trim();
                    try {
                      showDialog(context: context, builder: (BuildContext contex){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      SignUp(userName,email,phone,password);
                      Navigator.pop(context);
                      showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("Success"),
                          content: Text("Sign-up was successful!"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignInScreen())
                              );
                            }, child: Text("Ok"))
                          ],
                        );
                      });
                    } on FirebaseAuthException catch (e) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text(e.message?? ""), // Display the error message
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close dialog
                                },
                                child: Text("Ok"),
                              ),
                            ],
                          );
                        },
                      );
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shadowColor: Colors.tealAccent, // Shadow color
                    elevation: 5, // Elevation for shadow effect
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,// Font size
                      fontWeight: FontWeight.bold, // Font weight
                      letterSpacing: 1.5, // Spacing between letters
                    ),
                  ),
                ),

                SizedBox(height: 10.0,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                  },
                  child: Container(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Already have an account Sign In"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
