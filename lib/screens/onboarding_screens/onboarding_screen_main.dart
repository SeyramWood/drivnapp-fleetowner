import 'package:drivn_app/screens/onboarding_screens/intro_page_1.dart';
import 'package:drivn_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import 'intro_page_2.dart';
import 'intro_page_3.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Skip or Back
                GestureDetector(
                  onTap: () {
                    if (onLastPage) {
                      _controller.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _controller.jumpToPage(2);
                    }
                  },
                  child: Text(onLastPage ? "Back" : "Skip"),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(),
                ),
                // Next or Done
                GestureDetector(
                  onTap: () {
                    if (onLastPage) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return WelcomeScreen();
                          },
                        ),
                      );
                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(onLastPage ? "Done" : "Next"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
