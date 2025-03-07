import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plant_safe/components/login_button.dart';
import 'package:plant_safe/components/loginpage_text_field.dart';
import 'package:plant_safe/model/user_model.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //navigate to login page
  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});

  //registerfun-------------------------------------------------

  void register(BuildContext context) async {
    if (_passwordController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      log("Please fill all the fields");
      Fluttertoast.showToast(
          msg: "Please fill all the fields",
          textColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary);
    } else if (_passwordController.text == _confirmPasswordController.text) {
      await UserDataBox.saveLoginData(
          _emailController.text, _passwordController.text);
      log("User Registered: ${_emailController.text}");
      Fluttertoast.showToast(
          msg: "User Registered",
          textColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary);
    } else {
      log("Passwords do not match");
      Fluttertoast.showToast(
          msg: "Passwords do not match",
          textColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/register.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            //logo-------------------------------------------------
            const SizedBox(
              height: 100,
            ),
            Icon(Icons.message,
                size: 80, color: Theme.of(context).colorScheme.primary),

            SizedBox(
              height: size.height / 12,
            )

            //welcome back message----------------------------------------------
            ,

            Text("Welcome Back, You've been missed!",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18)),
            SizedBox(
              height: size.height / 14,
            ),

            //email textfiled------------------------------------------------

            LoginpageTextField(
              hintText: "Email",
              controller: _emailController,
            ),
            SizedBox(
              height: size.height / 15,
            ),

            //pwd textfield----------------------------------------------------

            LoginpageTextField(
              hintText: "Password",
              controller: _passwordController,
            ),
            SizedBox(
              height: size.height / 14,
            ),
            //pwd textfield----------------------------------------------------

            LoginpageTextField(
              hintText: "Confirm Password",
              controller: _confirmPasswordController,
            ),
            SizedBox(
              height: size.height / 14,
            ),
            //login button------------------------------------------------

            LoginButton(
              text: "Register",
              onTap: () {
                register(context);
              },
            ),
            SizedBox(
              height: size.height / 8.6,
            ),

            //register now------------------------------------------------

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 16,
                    )),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
