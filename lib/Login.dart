import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/Home.dart';
import 'package:todoapp/signUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ForgotPassword.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _HomeState();
}

class _HomeState extends State<SignInScreen> {
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(color: Colors.black),
        ),
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
                          suffixIcon: Icon(Icons.email)),
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
                          suffixIcon: Icon(Icons.password)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var email = EmailController.text.trim();
                    var password = PasswordController.text.trim();

                    try {
                      // Show the loading dialog
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(child: CircularProgressIndicator());
                        },
                      );

                      // Attempt to sign in
                      final userCredential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      // Dismiss the loading dialog
                      Navigator.pop(context);

                      // Show success dialog
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
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } on FirebaseAuthException catch (e) {
                      // Dismiss the loading dialog
                      Navigator.pop(context);

                      // Show error dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Login Failed"),
                            content: Text(
                                e.message ?? "An unexpected error occurred."),
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
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shadowColor: Colors.tealAccent,
                    elevation: 4,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                  child: Container(
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Forgot Pasword"),
                    )),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
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
