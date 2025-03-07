import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_safe/screens/slide_show_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SlideShowScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
            opacity: _animation,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/s.png",
                      ),
                      fit: BoxFit.cover)),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: size.height / 6,
                      width: size.width / 2,
                      child: Text(
                        "Plant Safe",
                        style: GoogleFonts.lilitaOne(
                          fontSize: 30,
                          shadows: [
                            const Shadow(
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 40, 125, 21),
                              offset: Offset(2.0, 5.0),
                            ),
                          ],
                          wordSpacing: Checkbox.width,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 111, 202, 120),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height / 4,
                    left: size.width / 3,
                    child: SizedBox(
                      height: size.height / 3,
                      width: size.width / 3,
                      child: Image.asset("assets/images/logo.png"),
                    ),
                  ),
                ],
              ),
            ) // Your splash image
            ),
      ),
    );
  }
}
