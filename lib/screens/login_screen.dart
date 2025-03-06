import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plant_safe/components/bottom_navigation_bar.dart';
import 'package:plant_safe/components/login_button.dart';
import 'package:plant_safe/components/loginpage_text_field.dart';
import 'package:plant_safe/model/user_model.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //navigate to register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  //login fun
  void login(BuildContext context) async {
    final storedUser = await UserDataBox.getLoginData();
    if (!context.mounted) return;
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      log("Please fill all the fields");

      Fluttertoast.showToast(
          msg: "Please fill all the fields",
          textColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary);
    } else if (storedUser != null &&
        storedUser.email == _emailController.text &&
        storedUser.password == _passwordController.text) {
      log("Login Successful");

      Fluttertoast.showToast(
          msg: "Login Successful",
          textColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary);

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const BottomNavScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } else {
      Fluttertoast.showToast(
          msg: "Invalid Email or Password",
          textColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary);
      log("Invalid Email or Password");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            //logo-------------------------------------------------

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

            //email textfield------------------------------------------------

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

            //login button------------------------------------------------

            LoginButton(
              text: "Login",
              onTap: () {
                login(context);
              },
            ),
            SizedBox(
              height: size.height / 4,
            ),

            //register now------------------------------------------------

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
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
                    "Register now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
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
