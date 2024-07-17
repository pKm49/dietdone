import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MenuBottomNavBar extends StatelessWidget {
  const MenuBottomNavBar({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_box_outlined,
                size: 40,
                color: kPrimaryColor,
              ),
            ),
            Text(
              "1x",
              style: theme.textTheme.titleMedium,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: kPrimaryColor, width: 3)),
                child: Center(
                  child: Icon(
                    Icons.remove,
                    color: kPrimaryColor,
                    size: 25,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.snackbar("successfully", "Item added to cart");
              },
              style: ElevatedButton.styleFrom(
                  maximumSize: const Size(150, 50),
                  side: const BorderSide(),
                  backgroundColor: kBlackColor),
              child: Text(
                "Add to Cart",
                style: theme.textTheme.labelLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
