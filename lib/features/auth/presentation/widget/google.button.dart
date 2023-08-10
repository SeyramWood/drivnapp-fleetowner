// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    Key? key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Divider(
              indent: 5,
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Or'),
            ),
            Expanded(child: Divider())
          ],
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: onTap,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/google.png'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
