import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/food_delivery/menu/model/meals_by_id_model.dart';
import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.mealsList,
    required this.theme,
  });

  final MealsByIdModel mealsList;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: kPrimaryColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Text(
          "\$ ${mealsList.price}",
          style: theme.textTheme.labelLarge,
        ),
      ),
    );
  }
}
