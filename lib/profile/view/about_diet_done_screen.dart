import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/profile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AboutDietDoneScreen extends StatelessWidget {
  const AboutDietDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(title: "Diet Done"),
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey[100],
                child:
                    SvgPicture.asset("assets/about_page_icons/About Diet.svg"),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Diet Step: Your\npersonalized journey",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                        "At DietStep, we're committed to helping you achieve your health and wellness goals in a way that's tailored to your lifestyle. Our mobile application is designed to make your journey towards a healthier you both effortless and enjoyable"),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          maximumSize: const Size(150, 45),
                          backgroundColor: kBlackColor),
                      child:
                          Text("Know more", style: theme.textTheme.labelLarge),
                    ),
                    Text(
                      "What We Offers",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const WhatWeOfferCardGroup(
                      imageUrl1: 'assets/about_page_icons/Tailored Website.svg',
                      title1: 'Tailored\nWebsite',
                      imageUrl2: 'assets/about_page_icons/Smart Tracking.svg',
                      title2: 'Smart\nTracking',
                      imageUrl3: 'assets/about_page_icons/Healthy Meal.svg',
                      title3: 'Healthy\nMeal',
                      imageUrl4: 'assets/about_page_icons/Guidance.svg',
                      title4: 'Expert\nGuidance',
                    ),
                    Text(
                      "Our Mission",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "We believe that achieving a balanced and healthy lifestyle shouldn’t be a one-size-fits-all approach. Our mission is to empower individuals like you to make informed choices about their health through personalized guidance, support, and a community-driven approach"),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          maximumSize: const Size(150, 45),
                          backgroundColor: kBlackColor),
                      child: Text(
                        "Know more",
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WhatWeOfferCardGroup extends StatelessWidget {
  const WhatWeOfferCardGroup({
    super.key,
    required this.imageUrl1,
    required this.title1,
    required this.imageUrl2,
    required this.title2,
    required this.imageUrl3,
    required this.title3,
    required this.imageUrl4,
    required this.title4,
  });

  final String imageUrl1;
  final String title1;
  final String imageUrl2;
  final String title2;
  final String imageUrl3;
  final String title3;
  final String imageUrl4;
  final String title4;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            WhatWeOfferCards(imageUrl: imageUrl1),
            Text(
              title1,
              textAlign: TextAlign.center,
            )
          ],
        ),
        Column(
          children: [
            WhatWeOfferCards(imageUrl: imageUrl2),
            Text(
              title2,
              textAlign: TextAlign.center,
            )
          ],
        ),
        Column(
          children: [
            WhatWeOfferCards(imageUrl: imageUrl3),
            Text(
              title3,
              textAlign: TextAlign.center,
            )
          ],
        ),
        Column(
          children: [
            WhatWeOfferCards(imageUrl: imageUrl4),
            Text(
              title4,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ],
    );
  }
}

class WhatWeOfferCards extends StatelessWidget {
  const WhatWeOfferCards({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.grey[100],
      child: SvgPicture.asset(imageUrl),
    );
  }
}
