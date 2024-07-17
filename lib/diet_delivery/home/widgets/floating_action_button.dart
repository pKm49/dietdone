import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/diet_delivery/home/api/get_support_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 100,
      child: InkWell(
        onTap: () async {
          toast("Redirecting to Whatsapp");
          await redirectToWhatsApp();
        },
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xFF075E54),
          child: const FaIcon(
            FontAwesomeIcons.whatsapp,
            color: kWhiteColor,
          ),
        ),
      ),
    );
  }

  Future<void> redirectToWhatsApp() async {
    final supportNumber = await GetSupportNumberApiService().getSupportNumber();

    final whatsappUrl = "https://wa.me/$supportNumber";

    if (await canLaunch(whatsappUrl)) {
      await launchUrlString(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
