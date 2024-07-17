import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarWithTitleAndButton extends StatelessWidget {
  const CustomAppBarWithTitleAndButton(
      {super.key, required this.title, required this.action});

  final String title;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [AppBarBackButton(), kWidth(1), Text(title), action],
      ),
    );
  }
}

//this is the button which we use to translate from english to arabic
class LocalizationButton extends StatelessWidget {
  const LocalizationButton({
    super.key,
    required this.onTapIconButton,
    required this.iconColor,
  });

  final void Function()? onTapIconButton;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

// this is custom back button which is used as back button all over the app
class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
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
    );
  }
}
