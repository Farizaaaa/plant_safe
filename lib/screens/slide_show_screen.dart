import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_safe/auth/login_or_register.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SlideShowScreen extends StatefulWidget {
  const SlideShowScreen({super.key});

  @override
  _SlideShowScreenState createState() => _SlideShowScreenState();
}

class _SlideShowScreenState extends State<SlideShowScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 1) {
      // 3 slides (0,1,2)
      _controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else if (_currentPage == 1) {
      _controller.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void _exitSlideShow() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const LoginOrRegister();
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero),
    );
    
    
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            children: const [
              SlidePageBeta(imagePath: 'assets/images/s.png'),
              SlidePage(imagePath: 'assets/images/slide_two.png'),
            ],
          ),
          // Page Indicator
          Positioned(
            bottom: 20,
            child: SmoothPageIndicator(
              controller: _controller,
              count: 2,
              effect: const WormEffect(
                dotHeight: 5,
                dotWidth: 5,
                activeDotColor: Colors.white,
                dotColor: Colors.grey,
              ),
            ),
          ),
          if (_currentPage != 0)
            Positioned(
              bottom: 20,
              left: 10,
              child: SizedBox(
                height: 45,
                width: size.width / 5,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.green,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                  child: const Text(
                    "Back",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 20,
            right: 10,
            child: SizedBox(
              height: 45,
              width: size.width / 5,
              child: ElevatedButton(
                onPressed: _currentPage == 1 ? _exitSlideShow : _nextPage,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SlidePage extends StatelessWidget {
  final String imagePath;

  const SlidePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
     
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                height: size.height / 2,
                width: size.width / 2,
                child: Text(
                  "Scan, Identify, Grow - Your Plant’s Health in a Tap!",
                  style: GoogleFonts.lilitaOne(
                    shadows: [
                      const Shadow(
                        blurRadius: 10.0,
                        color: Color.fromARGB(255, 74, 202, 39),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 14, 120, 8),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 20,
            right: 0,
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
    );
  }
}

class SlidePageBeta extends StatelessWidget {
  final String imagePath;

  const SlidePageBeta({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // **Balance Layout**
        children: [
          // **App Name & Logo - Centered**
          Column(
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

          // **Welcome Text - Centered**
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome to PlantSafe",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lilitaOne(
                      fontSize: 18, // Smaller size
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 14, 120, 8),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "\nA healthy plant is a happy plant",
                    textAlign: TextAlign.center,
          style: GoogleFonts.lilitaOne(
            shadows: [
              const Shadow(
                blurRadius: 10.0,
                color: Color.fromARGB(255, 74, 202, 39),
                offset: Offset(5.0, 5.0),
              ),
            ],
                      fontSize: 30,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 14, 120, 8),
          ),
        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
