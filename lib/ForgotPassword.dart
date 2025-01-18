import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/Login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _HomeState();
}

class _HomeState extends State<ForgotPassword> {
  TextEditingController ForgotPasswordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ForgotPassword",style: TextStyle(color: Colors.black),),
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
                      controller: ForgotPasswordController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          enabledBorder: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.email)
                      ),
                    ),

                  ),
                ),

                SizedBox(height: 10.0,),
                ElevatedButton(
                  onPressed: () async{
                    var Email=ForgotPasswordController.text.trim();
                    try {
                      // Show loading indicator
                      showDialog(
                        context: context,
                        // barrierDismissible: false, // Prevent dismissing the dialog
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );

                      // Perform password reset
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: Email);
                      // Dismiss the loading indicator
                      Navigator.pop(context);
                      // Show success dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Forgot Password"),
                            content: Text(
                                "Password reset email has been successfully sent. Please check your email."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignInScreen()),
                                  );
                                },
                                child: Text("Ok"),
                              ),
                            ],
                          );
                        },
                      );
                    } on FirebaseAuthException catch (e) {
                      // Dismiss the loading indicator
                      Navigator.pop(context);

                      // Show error dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text(e.message ?? "An error occurred."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
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
                    "ForgotPassword",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,// Font size
                      fontWeight: FontWeight.bold, // Font weight
                      letterSpacing: 1.5, // Spacing between letters
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
