import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/Login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _HomeState();
}

class _HomeState extends State<ForgotPassword> {
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
                  onPressed: () {
                    // Add your login logic here
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
