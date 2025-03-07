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
    Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) {
      return const LoginOrRegister();
    }));
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
      alignment: Alignment.topRight,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: SizedBox(
        height: size.height / 2,
        width: size.width / 3,
        child: Text(
          "Scan, Identify, Grow - Your Plant’s Health in a Tap!",
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
            color: const Color.fromARGB(255, 225, 235, 226),
          ),
        ),
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
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: SizedBox(
        width: size.width / 3,
        child: Text(
          "A healthy plant is a happy plant",
          style: GoogleFonts.lilitaOne(
            shadows: [
              const Shadow(
                blurRadius: 10.0,
                color: Color.fromARGB(255, 74, 202, 39),
                offset: Offset(5.0, 5.0),
              ),
            ],
            fontSize: 30,
            wordSpacing: Checkbox.width,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 14, 120, 8),
          ),
        ),
      ),
    );
  }
}
