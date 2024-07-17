import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/food_delivery/cart/view/payment_screens/payment_shipping_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text("My Cart"),
        centerTitle: true,
        actions: [
          InkWell(
            child: SvgPicture.asset("assets/icon/Notification.svg"),
          ),
          kWidth(20)
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const Text("Your Order(3)",
                  style: TextStyle(
                    fontSize: 18,
                  )),
              kHeight(18),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) => Column(
                  children: [
                    Card(
                      elevation: 0,
                      color: Colors.grey[100],
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/temp_images/tasty-chicken-cheese-salad-plate-on-transparent-background-png.png",
                            fit: BoxFit.fill,
                            height: 100,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Peanut Salad"),
                              Row(
                                children: [
                                  const Text(
                                    "\$6.69",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  kWidth(10),
                                  const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  const Text("4.5"),
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.do_not_disturb_on,
                                        color: kPrimaryColor,
                                      )),
                                  const Text("1x"),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.add_circle,
                                        color: kPrimaryColor,
                                      )),
                                ],
                              ),
                              const Text("\$6.50")
                            ],
                          )
                        ],
                      ),
                    ),
                    kHeight(10)
                  ],
                ),
              ),
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                      InkWell(
                          onTap: () {
                            Get.dialog(AlertDialog(
                              title: const Text("Apply Your Coupon Code Here"),
                              actions: [
                                const TextField(
                                  textAlign: TextAlign.center,
                                  decoration:
                                      InputDecoration(hintText: "S2fghN5f"),
                                ),
                                kHeight(10),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Apply",
                                      style: theme.textTheme.labelLarge,
                                    ))
                              ],
                            ));
                          },
                          child: const Text(
                            "Apply Coupon",
                            style: TextStyle(color: kPrimaryColor),
                          ))
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
                      Get.to(PaymentShippingAddressScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBlackColor,
                    ),
                    child: Text(
                      "Place Order",
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                  kHeight(
                    size.height * 0.07,
                  )
                ],
              )
            ],
          )),
    );
  }
}
