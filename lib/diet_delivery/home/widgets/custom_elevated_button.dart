import 'package:flutter/material.dart';

class ElevatedButton2 extends StatelessWidget {
  const ElevatedButton2({
    super.key,
    required this.size,
    required this.backgroundColor,
    required this.textColor,
    this.onPressed,
    required this.text,
  });

  final Size size;
  final Color backgroundColor;
  final Color textColor;
  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40))),
          backgroundColor: backgroundColor,
          fixedSize: Size(size.width * 0.5, size.height * 0.04),
        ),
        onPressed: onPressed,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: TextStyle(color: textColor),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
