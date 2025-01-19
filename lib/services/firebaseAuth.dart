import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Login.dart';

SignUp(String userName, String email, String phone, String password) async {
  try {
    // Ensure the current user is logged in
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      // Handle the case when the user is not logged in
      print("No user is currently logged in.");
      return;
    }

    // Add user information to Firestore
    await FirebaseFirestore.instance.collection("user").doc(currentUser.uid).set({
      "userName": userName,
      "Email": email,
      "Phone": phone,
      "Date": DateTime.now(),
      "userid": currentUser.uid
    });

    // Navigate to the SignInScreen after the data is stored


  } catch (e) {
    // Handle errors
    print("Error during signup: $e");
  }
}

