import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/food_delivery/cart/view/payment_screens/confirm_order_scree.dart';
import 'package:diet_diet_done/profile/view/adress_details_screens.dart';
import 'package:diet_diet_done/profile/widgets/address_card.dart';
import 'package:diet_diet_done/profile_config/view/address_form_screen.dart';
import 'package:diet_diet_done/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class PaymentShippingAddressScreen extends StatelessWidget {
  const PaymentShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Order(3)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            kHeight(10),
            Text("SHIPPING ADDRESS"),
            kHeight(10),
            AddressCard(),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Price Details",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Divider(
                  color: Colors.grey[200],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total MRP",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "\$30.72",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                kHeight(15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Discount on"), Text("-\$3.27")],
                ),
                kHeight(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Coupon Discount"),
                    const Text(
                      "Apply Coupon",
                    )
                  ],
                ),
                kHeight(5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Shipping Free"), Text("Free")],
                ),
                kHeight(20),
                ElevatedButton(
                  onPressed: () {
                    Get.to(AddressForm(
                      onTap: () {
                        Get.to(ConfirmOrderScreen());
                      },
                    ));
                  },
                  child: Text(
                    "Continue",
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
