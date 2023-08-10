import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child, this.backgroundColor,

  });
  final void Function()? onPressed;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 55,
        width: MediaQuery.sizeOf(context).width,
        child: ElevatedButton(
          onPressed: onPressed,
          child: child,
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(backgroundColor)),
        ) //this extention indicate a loading progress when the button is pressed,
        );
  }
}
