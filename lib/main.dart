import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SlideShowScreen(),
    );
  }
}

class SlideShowScreen extends StatefulWidget {
  const SlideShowScreen({super.key});

  @override
  _SlideShowScreenState createState() => _SlideShowScreenState();
}

class _SlideShowScreenState extends State<SlideShowScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      // 3 slides (0,1,2)
      _controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      _exitSlideShow();
    }
  }

  void _exitSlideShow() {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Welcome to Plant Safe",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
      );
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
              SlidePage(imagePath: 'assets/images/logo.png'),
              SlidePage(imagePath: 'assets/images/logo.png'),
              SlidePage(imagePath: 'assets/images/logo.png'),
            ],
          ),
          // Page Indicator
          Positioned(
            bottom: 70,
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: const WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Colors.white,
                dotColor: Colors.grey,
              ),
            ),
          ),
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
                child: Text(
                  _currentPage == 2 ? "Exit" : "Skip",
                  style: const TextStyle(fontSize: 12, color: Colors.white),
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
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                ),
                child: Text(
                  _currentPage == 2 ? "Exit" : "Next",
                  style: const TextStyle(fontSize: 12, color: Colors.white),
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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.green, Colors.white],
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              alignment: Alignment.centerRight,
              height: size.height / 6,
              width: size.width / 2,
              child: Text(
                "Plant Safe",
                style: GoogleFonts.righteous(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 11, 177, 2),
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
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
        ],
      ),
    );
  }
}
