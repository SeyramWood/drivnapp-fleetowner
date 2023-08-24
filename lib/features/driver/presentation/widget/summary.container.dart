import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class SummaryContainer extends StatelessWidget {
  const SummaryContainer(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.color});
  final String title;
  final String subTitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: white, fontWeight: FontWeight.bold),
              ),
              Text(
                subTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
