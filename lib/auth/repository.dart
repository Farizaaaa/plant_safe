import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plant_safe/components/bottom_navigation_bar.dart';
import 'package:plant_safe/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  /// **Email Validation**
  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  //----------------- Login Function -----------------//
  void login(BuildContext context, TextEditingController emailController,
      TextEditingController passwordController) async {
    if (!context.mounted) return;

    final storedUser = await UserDataBox.getLoginData();

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      log("Please fill all the fields");
      Fluttertoast.showToast(
          msg: "Please fill all fields",
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return;
    }

    if (!_isValidEmail(emailController.text)) {
      log("Invalid email format");
      Fluttertoast.showToast(
          msg: "Invalid email format",
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return;
    }

    if (storedUser == null ||
        storedUser.email != emailController.text ||
        storedUser.password != passwordController.text) {
      log("Invalid Email or Password");
      Fluttertoast.showToast(
          msg: "Invalid Email or Password",
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return;
    }

    log("Login Successful");
    Fluttertoast.showToast(
        msg: "Login Successful",
        textColor: Colors.white,
        backgroundColor: Colors.green);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', storedUser.email);
    await prefs.setString('password', storedUser.password);

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const BottomNavScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  //----------------- Register Function -----------------//
  void register(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController) async {
    if (!context.mounted) return;

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      log("Please fill all the fields");
      Fluttertoast.showToast(
          msg: "Please fill all fields",
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return;
    }

    if (!_isValidEmail(emailController.text)) {
      log("Invalid email format");
      Fluttertoast.showToast(
          msg: "Invalid email format",
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      log("Passwords do not match");
      Fluttertoast.showToast(
          msg: "Passwords do not match",
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return;
    }

    final existingUser = await UserDataBox.getLoginData();
    if (existingUser != null && existingUser.email == emailController.text) {
      log("User already exists");
      Fluttertoast.showToast(
          msg: "User already registered",
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return;
    }

    await UserDataBox.saveLoginData(
        emailController.text, passwordController.text);
    log("User Registered: ${emailController.text}");

    Fluttertoast.showToast(
        msg: "Registration Successful",
        textColor: Colors.white,
        backgroundColor: Colors.green);

    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const BottomNavScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}
