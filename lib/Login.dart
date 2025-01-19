import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/Home.dart';
import 'package:todoapp/signUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/services/firebaseAuth.dart';


import 'ForgotPassword.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _HomeState();
}

class _HomeState extends State<SignInScreen> {
  TextEditingController EmailController=TextEditingController();
  TextEditingController PasswordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 300.0,
                  alignment: Alignment.center,
                  child: Lottie.asset("assets/Animation - 1736890968846.json"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextField(
                      controller: EmailController,
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
                      controller: PasswordController,
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
                    var Email=EmailController.text.toString();
                    var Pass=PasswordController.text.toString();
                    try{
                     final users= (await FirebaseAuth.instance.signInWithEmailAndPassword(
                         email: Email, password: Pass)).user;

                     if(users?.email==Email){
                       showDialog(context: context, builder: (BuildContext context){
                         return AlertDialog(
                           title: Text("Email incorrect",style: TextStyle(color: Colors.red),),
                           actions: [
                             TextButton(onPressed: (){
                               Navigator.pop(context);
                             }, child: Text("ok"))
                           ],
                         );
                       },);
                     }else if(users.hashCode==Pass){
                       showDialog(context: context, builder: (BuildContext context){
                         return AlertDialog(
                           title: Text("password is incorrect",style: TextStyle(color: Colors.red),),
                           actions: [
                             TextButton(onPressed: (){
                               Navigator.pop(context);
                             }, child: Text("Ok"))
                           ],
                         );
                       });
                     }
                     if (users != null) {
                       // Login successful
                       showDialog(
                         context: context,
                         builder: (BuildContext context) {
                           return AlertDialog(
                             title: Text("Login Success"),
                             content: Text("Welcome back!"),
                             actions: [
                               TextButton(
                                 child: Text("OK"),
                                 onPressed: () {
                                   Navigator.pop(context); // Close the dialog
                                   Navigator.pushReplacement(
                                       context, MaterialPageRoute(builder: (context) => Home()));
                                 },
                               ),
                             ],
                           );
                         },
                       );
                     } else {
                       // Login failed
                       showDialog(
                         context: context,
                         builder: (BuildContext context) {
                           return AlertDialog(
                             title: Text("Login Failed"),
                             content: Text("Email or Password is incorrect. Please try again."),
                             actions: [
                               TextButton(
                                 child: Text("OK"),
                                 onPressed: () {
                                   Navigator.pop(context); // Close the dialog
                                 },
                               ),
                             ],
                           );
                         },
                       );
                     }



                    } on FirebaseAuthException catch (e){
                      print("Error $e");

                    }
                    // Add your login logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shadowColor: Colors.tealAccent, // Shadow color
                    elevation: 4, // Elevation for shadow effect
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,// Font size
                      fontWeight: FontWeight.bold, // Font weight
                      letterSpacing: 1.5, // Spacing between letters
                    ),
                  ),
                ),
        
                SizedBox(height: 10.0,),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                    },
                  child: Container(
                    child: Card(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Forgot Pasword"),
                    )),
                  ),
                ),
                SizedBox(height: 10.0,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  },
                  child: Container(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Don't have an account SignUp"),
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
