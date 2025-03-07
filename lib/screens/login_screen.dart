
import 'package:flutter/material.dart';
import 'package:plant_safe/auth/repository.dart';
import 'package:plant_safe/components/login_button.dart';
import 'package:plant_safe/components/loginpage_text_field.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //navigate to register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login.png"),
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
                  AuthRepo()
                      .login(context, _emailController, _passwordController);
                },
              ),
              SizedBox(
                height: size.height / 7,
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
      ),
    );
  }
}
