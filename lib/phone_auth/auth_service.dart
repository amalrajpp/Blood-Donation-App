import 'package:blood/fitness_app_home_screen.dart';
import 'package:blood/ui_view/user_role.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../ui_view/details_screen.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> signup(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var collection = FirebaseFirestore.instance.collection('user');
      String uid = FirebaseAuth.instance.currentUser!.uid;
      collection
          .doc(uid) // <-- Document ID
          .set({'uid': uid}) // <-- Your data
          .then((_) => print('Added'))
          .catchError((error) => print('Add failed: $error'));
      await fetchUserRole();
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => DetailsScreen()));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
    } catch (e) {}
  }

  Future<void> signin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await fetchUserRole();
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => FitnessAppHomeScreen()));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      }
    } catch (e) {}
  }

  Future<void> signout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  Future<String?> fetchUserRole() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('user').doc(uid).get();
      String role = userDoc['role'];
      UserManager().setRole(role);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_role', role);
      print("success");
    } catch (e) {
      print('Error fetching role: $e');
      return null;
    }
  }
}
