import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constraints/const_colors.dart';
import '../../../core/constraints/constraints.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.onTapBackButton,
      this.backgroundColor,
      required this.onTapIconButton,
      this.iconColor,
      this.text});

  final void Function()? onTapBackButton;
  final void Function()? onTapIconButton;
  final Color? backgroundColor;
  final Color? iconColor;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          kWidth(10),
          GestureDetector(
            onTap: onTapBackButton,
            child: Container(
              width: 41,
              height: 41,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: borderColor,
                ),
                color: kWhiteColor,
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            IconButton(
                onPressed: onTapIconButton,
                icon: Icon(
                  Icons.language,
                  color: iconColor,
                )),
            Text(
              "English".tr,
              style: TextStyle(color: iconColor),
            ),
            kWidth(30)
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
