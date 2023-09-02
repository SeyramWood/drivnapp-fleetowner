import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';

class CarCarousel extends StatefulWidget {
  const CarCarousel({Key? key}) : super(key: key);

  @override
  State<CarCarousel> createState() => _CarCarouselState();
}

class _CarCarouselState extends State<CarCarousel> {
  final images = <String>[
    'assets/bg.png',
    'assets/car1.png',
    'assets/otp.png',
    'assets/tick.png',
    'assets/logo.png'
  ];
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (value) {
              setState(() {
                _currentPageIndex = value;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        images[index],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPageIndex == index ? Colors.red : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
