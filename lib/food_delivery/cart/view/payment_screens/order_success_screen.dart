import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/home/view/bottom_navigation_bar.dart';
import 'package:diet_diet_done/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSuccessSCreen extends StatelessWidget {
  const OrderSuccessSCreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: AppBarBackButton(),
              )),
              SizedBox(
                  height: size.height * 0.35,
                  child: Image(
                      image:
                          AssetImage("assets/background_image/bg image.png"))),
            ],
          ),
          SizedBox(
              height: size.height * 0.3,
              child: Image.asset("assets/gif/Successful page gif.gif")),
          Text(
            "Payment successful",
            style: TextStyle(
                color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          kHeight(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                " DONE ",
                style: TextStyle(
                    fontSize: 22,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "family",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          kHeight(size.height * 0.1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: () => Get.to(BottomNavBar()),
                child: Text(
                  "Shop Again",
                  style: Theme.of(context).textTheme.labelLarge,
                )),
          )
        ],
      ),
    );
  }
}
