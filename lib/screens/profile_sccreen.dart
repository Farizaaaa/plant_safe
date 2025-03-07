import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_safe/auth/login_or_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? email;

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!context.mounted) return;

    Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const LoginOrRegister();
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero),
    );
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    return null;
  }

  @override
  void initState() {
    super.initState();
    getUserEmail();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/common.png",
                ),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(email ?? "",
                    style: GoogleFonts.lilitaOne(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 14, 120, 8),
                    )),
                SizedBox(height: size.height / 18),
                GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Center(
                      child: SizedBox(
                        width: size.width / 3,
                        height: size.height / 18,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          onPressed: () {
                            _logout(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Logout',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              const Icon(Icons.logout, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                alignment: Alignment.centerRight,
                height: size.height / 6,
                width: size.width / 2,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Plant Safe",
                      style: GoogleFonts.lilitaOne(
                        shadows: [
                          const Shadow(
                            blurRadius: 10.0,
                            color: Color.fromARGB(255, 74, 202, 39),
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 14, 120, 8),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 18, // **Relative Scaling**
                      child: Image.asset(
                        "assets/images/logo.png",
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
