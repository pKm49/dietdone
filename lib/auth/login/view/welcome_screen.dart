import 'package:diet_diet_done/auth/login/api/get_access_token_service.dart';
import 'package:diet_diet_done/auth/login/view/login_screen.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
              child: Image.asset(
            "assets/background_image/jpeg-optimizer_pexels-nataliya-vaitkevich-5794883.jpg",
            fit: BoxFit.cover,
          )),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  kHeight(200),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: const Image(
                          image: AssetImage("assets/logo/Group 13233.png"))),
                  kHeight(50),
                  const Text(
                    "Fast delivery at\n Your doorstep",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: kWhiteColor),
                  ),
                  const Text(
                    "a few taps on your phone, and a world of culinary\ndelights arrives. With a diverse array of cuisines\njust a click away, you can savor global flavors\nfrom the comfort of home.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kWhiteColor),
                  ),
                  kHeight(20),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => kWhiteColor)),
                      onPressed: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool("hasSeenWelcomeScreen", true);
                        await GetAccessTokenService().getAccessToken();
                        Get.to(LoginScreen());
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: kBlackColor),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
