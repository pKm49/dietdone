import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Ingredients extends StatelessWidget {
  const Ingredients({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          height: 45,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
          child: SvgPicture.asset(imageUrl),
        ),
        kWidth(10)
      ],
    );
  }
}

class IngredientWidget extends StatelessWidget {
  const IngredientWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Ingredients",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        kHeight(10),
        const Row(
          children: [
            Ingredients(imageUrl: "assets/gradient_icon/onion.svg"),
            Ingredients(imageUrl: "assets/gradient_icon/Spinch.svg"),
            Ingredients(imageUrl: "assets/gradient_icon/Meat.svg"),
            Ingredients(imageUrl: "assets/gradient_icon/Tomato.svg"),
          ],
        ),
      ],
    );
  }
}
