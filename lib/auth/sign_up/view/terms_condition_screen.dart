import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Terms & Conditions",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            Text(
              "Conditions for canceling a subscription to Diet Done\n◦ If the customer decides to cancel the subscription on the first day or 48 hours before the end of the first week, the amount of a week’s subscription will be deducted and completed.\n◦ If the customer decides to cancel the subscription 48 hours before the end of the second week, the two-week subscription amount will be deducted and supplemented.\n◦ If the customer decides to cancel the subscription 24 hours or more before the end of the second week, the customer cannot refund any amount and can roll over the subscription for 3 months.\nNote: The value of the one or two-week subscription is not calculated by dividing the amount by 4 or 2, but it has other criteria.\nThe service of stopping and activating the subscription\n◦ To stop certain days during subscription, it must be 48 hours or more in advance through the application\n◦ To activate any suspended day, it must be 48 hours or more ago through the application",
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
