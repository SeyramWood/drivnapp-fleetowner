import 'package:drivn/shared/utils/cached.network.image.dart';
import 'package:flutter/material.dart';


class CarCarousel extends StatefulWidget {
  const CarCarousel({
    super.key,
    required this.images,
  });
  final List<dynamic> images;
  @override
  State<CarCarousel> createState() => _CarCarouselState();
}

class _CarCarouselState extends State<CarCarousel> {
  final imageList = <String>[];
  getImages() {
    for (var image in widget.images) {
      imageList.add(image.image);
    }
  }

  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  @override
  void initState() {
    getImages();
    super.initState();
  }

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
            itemCount: imageList.length,
            onPageChanged: (value) {
              setState(() {
                _currentPageIndex = value;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: showImage(imageUrl: imageList[index]),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imageList.length,
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
