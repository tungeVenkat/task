import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_intern/secondpage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/back2.jpeg"), // Background image path
          fit: BoxFit.cover, // Adjust how the image fills the container
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Set to transparent to show the background
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Select Template",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(height: 10),
            Container(
              height: 400,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: PageView(
                  controller: _controller,
                  children: [
                    Image.asset("images/resume2.png"),
                    GestureDetector(
                      child: Image.asset("images/main_resume.png"),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondPage()),
                      ),
                    ),
                    Image.asset("images/resume3.png"),
                    Image.asset("images/resume4.png"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            SmoothPageIndicator(
              controller: _controller,
              count: 4,
              effect: const JumpingDotEffect(
                dotColor: Colors.black,
                activeDotColor: Colors.white,
                dotHeight: 20,
                dotWidth: 20,
                spacing: 15,
                verticalOffset: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
