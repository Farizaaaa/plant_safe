import 'package:flutter/material.dart';

class LoginpageTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  const LoginpageTextField(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: hintText == "Password" && hintText == "Confirm Password"
            ? true
            : false,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary)),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
