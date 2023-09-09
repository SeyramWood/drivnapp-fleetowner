import 'package:drivn/features/auth/presentation/views/account.type.view.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class OnbordingPage extends StatefulWidget {
  const OnbordingPage({super.key});

  @override
  State<OnbordingPage> createState() => _OnbordingPageState();
}

class _OnbordingPageState extends State<OnbordingPage> {
  final PageController _pageController = PageController();

  List pages = [
    {
      "img": 'assets/onb1.jpg',
      "title": "Endless options",
      "description":
          "We offer diverse array of chauffeur drive services. Our chauffeur drive and luxury service allows you to travel in a safe and relaxed way.",
    },
    {
      "img": 'assets/onb2.jpg',
      "title": "Drive confidently",
      "description":
          "We also provides short-term corporate mini leases from one month to a year.",
    },
    {
      "img": 'assets/onb3.jpg',
      "title": "24/7 support",
      "description":
          "You can also book our luxury chauffeur drive service for your weddings and special occasions."
    },
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(pages[index]["img"]),
                                    fit: BoxFit.cover),
                              )),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Text(
                          pages[index]['title'],
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            pages[index]["description"],
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 16, height: 1.5),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: _pageIndicators(
                          pages: pages, context: context, index: index),
                    ),
                    Row(
                      children: [
                        onbordingButtons(
                          title: index == pages.length - 1 ? "" : "Skip",
                          onTap: () =>
                              _pageController.jumpToPage(pages.length - 1),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        CommonButton(
                          bgd: blue,
                          title: index == pages.length - 1
                              ? "Get Started"
                              : "Next >>>",
                          onPressed: () => index == pages.length - 1
                              ? Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AccountTypeView(),
                                  ),
                                  (route) => false,
                                )
                              : _pageController.nextPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.ease),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

GestureDetector onbordingButtons({void Function()? onTap, String? title}) {
  return GestureDetector(
      onTap: onTap,
      child: Text(
        title!,
        style: const TextStyle(fontSize: 16),
      ));
}

List<Widget> _pageIndicators({pages, index, BuildContext? context}) {
  List<Container> indicators = [];

  for (int i = 0; i < pages.length; i++) {
    indicators.add(
      Container(
        width: i == index ? 20 : 6,
        height: 6,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: i == index ? blue : red,
          borderRadius: i == index
              ? BorderRadius.circular(50)
              : BorderRadius.circular(50),
        ),
      ),
    );
  }
  return indicators;
}

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key, this.onPressed, this.title, this.bgd, this.side});
  final Color? bgd;
  final String? title;
  final MaterialStateProperty<BorderSide?>? side;

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: bgd,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        child: Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
