import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/food_delivery/cart/view/payment_screens/order_success_screen.dart';
import 'package:diet_diet_done/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHeight(10),
            Text(
              "Your Order(3)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            kHeight(10),
            Text(
              "RECOMMENDED PAYMENT",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            kHeight(5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Text(
                          "Edit",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/profile_icon/mastercard.svg",
                      ),
                      Text("****8014"),
                      Spacer(),
                      Text("01/28")
                    ],
                  )
                ],
              ),
            ),
            kHeight(20),
            Text(
              "OTHER PAYMENT OPTIONS",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            kHeight(5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset("assets/profile_icon/Cash.svg"),
                      kWidth(5),
                      Text("Cash on Delivery"),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.keyboard_arrow_down_rounded))
                    ],
                  ),
                  kHeight(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset("assets/profile_icon/Credit card.svg"),
                      kWidth(5),
                      Text("Credit/Debit card"),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.keyboard_arrow_down_rounded))
                    ],
                  ),
                  Divider(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.keyboard_arrow_down_rounded))
                ],
              ),
            ),
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
                    Get.to(OrderSuccessSCreen());
                  },
                  child: Text(
                    "Place Order",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: kBlackColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
