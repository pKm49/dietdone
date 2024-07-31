import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hintText,
      this.keyboardType,
      required this.controller,
      this.validator,
      this.suffixIcon,
      required this.obscure});

  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final Icon? suffixIcon;
  final bool obscure;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    // final FocusNode _focusNode = FocusNode();
    return TextFormField(
      // focusNode: _focusNode,
      obscureText: obscure,
      keyboardType: keyboardType,

      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
      validator: validator,
    );
  }
}
