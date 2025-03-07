import 'package:flutter/material.dart';
import 'package:plant_safe/auth/repository.dart';
import 'package:plant_safe/components/login_button.dart';
import 'package:plant_safe/components/loginpage_text_field.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //navigate to login page
  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
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
              image: AssetImage("assets/images/register.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              //logo-------------------------------------------------
              const SizedBox(
                height: 50,
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
                  AuthRepo().register(context, _emailController,
                      _passwordController, _confirmPasswordController);
                },
              ),
              SizedBox(
                height: size.height / 20,
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
      ),
    );
  }
}
