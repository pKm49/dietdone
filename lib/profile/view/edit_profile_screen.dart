import 'dart:convert';

import 'package:diet_diet_done/auth/sign_up/controller/local_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/getProfileController.dart';
import 'package:diet_diet_done/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key, required this.profileController});
  final GetProfileController profileController;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? mobile;
  final signUpController = Get.find<SignUpController>();
  final signUpLocalController = Get.find<LocalController>();

  @override
  void initState() {
    getNumber();
    assignProfileDetailsToTextEditingController();
    super.initState();
  }

  // @override
  // void dispose() async {
  //   if (signUpLocalController.selectedImage != null) {
  //     log("disposing.. selecting image");
  //     await signUpLocalController.selectedImage!.delete();
  //     log("disposed.. selecting image");
  //   }

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    getNumber();
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const AppBarBackButton()
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                        signUpLocalController.profileImage == ""
                            ? Image.network(widget.profileController.profileList[0]
                            .profilePicture ==
                            ""
                            ? profileImageNetworkLink
                            : widget.profileController.profileList[0]
                            .profilePicture!)
                            .image
                            : Image.memory(base64Decode(signUpLocalController.profileImage.value))
                            .image),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: () async {
                        await signUpLocalController.pickImageFromGallery();
                        signUpLocalController.imageToBase64();
                      },
                      child: SvgPicture.asset(
                        "assets/profile_icon/Profile.svg",
                        height: 25,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "${widget.profileController.profileList[0].firstName} ${widget.profileController.profileList[0].lastName}",
                    style: theme.textTheme.titleLarge,
                  ),
                  kHeight(10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[100]),
                    child: Text(widget.profileController.profileList[0].email),
                  ),
                ],
              ),
              Column(
                children: [
                  EditProfileTile(
                      text: "Phone:",
                      text2:
                          "${widget.profileController.profileList[0].mobile}"),
                  kHeight(5),
                  MyTextFormField(
                      text: "Email :",
                      controller: signUpController.emailController),
                  kHeight(5),
                  MyTextFormField(
                      text: "First Name :",
                      controller: signUpController.englishFirstName),
                  kHeight(5),
                  MyTextFormField(
                      text: "Last Name :",
                      controller: signUpController.englishLastName),
                ],
              ),
              kHeight(size.height * 0.1),
              ElevatedButton(
                  onPressed: () async {
                    if(signUpLocalController.selectedImage != null){
                      Uint8List imageBytes = signUpLocalController.selectedImage!.readAsBytesSync();

                      signUpController.updateUserProfile(
                          widget.profileController.profileList[0].mobile,
                          signUpController.englishLastName.text,
                          signUpController.englishFirstName.text,
                          signUpController.emailController.text,base64Encode(imageBytes));
                    }else{


                      signUpController.updateUserProfile(
                          widget.profileController.profileList[0].mobile,
                          signUpController.englishLastName.text,
                          signUpController.englishFirstName.text,
                          signUpController.emailController.text,null);
                    }

                  },
                  child: Text(
                    "Done",
                    style: theme.textTheme.labelLarge,
                  )),
              kHeight(10)
            ],
          ),
        ),
      ),
    );
  }

  getNumber() async {
    final prefs = await SharedPreferences.getInstance();
    mobile = await prefs.getString("mobile");
  }

  assignProfileDetailsToTextEditingController() async {
    signUpController.emailController.text =
        widget.profileController.profileList[0].email == ""
            ? ""
            : widget.profileController.profileList[0].email;

    signUpController.englishFirstName.text =
        widget.profileController.profileList[0].firstName;
    signUpController.englishLastName.text =
        widget.profileController.profileList[0].lastName;
  }
}

class EditProfileTile extends StatelessWidget {
  const EditProfileTile({
    super.key,
    required this.text,
    required this.text2,
  });

  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                text,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            kWidth(8),
            Expanded(flex: 2, child: Text(text2)),
            kWidth(8),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
            )
          ],
        ),
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const MyTextFormField({
    Key? key,
    required this.text,
    required this.controller,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                text,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  isDense: true,

                  fillColor: Colors.transparent,
                  filled: true,
                  // border: InputBorder.none,
                ),
              ),
            ),
            kWidth(8),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
