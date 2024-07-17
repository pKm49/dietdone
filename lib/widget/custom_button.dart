import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.theme,
      required this.onTap,
      required this.text});

  final String text;
  final ThemeData theme;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap, child: Text(text, style: theme.textTheme.labelLarge));
  }
}
