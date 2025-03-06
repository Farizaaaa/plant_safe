import 'package:flutter/material.dart';
import 'package:plant_safe/screens/login_screen.dart';
import 'package:plant_safe/screens/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initailly show login
  bool showLogin = true;

  //function to toggle between login and register
  void toggleLoginRegister() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(
        onTap: toggleLoginRegister,
      );
    } else {
      return RegisterPage(
        onTap: toggleLoginRegister,
      );
    }
  }
}
