import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/controller/area_&_block_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/auth/sign_up/model/area_&_block_model.dart';
import 'package:diet_diet_done/auth/sign_up/widget/custom_app_bar.dart';
import 'package:diet_diet_done/auth/sign_up/widget/text_field.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/profile_config/controller/profile_config_controller.dart';
import 'package:diet_diet_done/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../core/constraints/constraints.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final areaBlockController = Get.find<AreaAndBlockController>();
  @override
  void initState() {
    areaBlockController.fetchAreas();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileConfigController = Get.find<ProfileConfigController>();
    final signUpController = Get.find<SignUpController>();
    return Scaffold(
      appBar: CustomAppBar(
        iconColor: kPrimaryColor,
        onTapBackButton: () {
          Get.back();
        },
        onTapIconButton: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: profileConfigController.formKey,
            child: Column(
              children: [
                kHeight(20),
                Text(
                  "Enter Your Address",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
                kHeight(40),
                Form(child: Obx(
                  () {
                    return DropdownButtonFormField<GetAreaModel>(
                      value: areaBlockController.selectedArea.value,
                      onChanged: (GetAreaModel? newValue) {
                        if (newValue != null) {
                          areaBlockController.selectedArea.value = newValue;
                        }
                      },
                      items: areaBlockController.areas.map((area) {
                        return DropdownMenuItem<GetAreaModel>(
                          value: area,
                          child: Text(
                            "${area.name} - ${area.id.toString()} ",
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Area*',
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                )),
                kHeight(14),
                Form(child: Obx(
                  () {
                    return DropdownButtonFormField<GetBlockModel>(
                      value: areaBlockController.selectedBlock.value,
                      onChanged: (GetBlockModel? newValue) {
                        if (newValue != null) {
                          areaBlockController.selectedBlock.value = newValue;
                        }
                      },
                      items: areaBlockController.blocks.map((block) {
                        return DropdownMenuItem<GetBlockModel>(
                          value: block,
                          child: Text(
                            "${block.name}",
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Block*',
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                )),
                kHeight(14),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        obscure: false,
                        hintText: "Street*",
                        controller: signUpController.streetController,
                        validator: (value) => profileConfigController.validate(
                            value, "Please enter your Street"),
                      ),
                    ),
                    kWidth(14),
                    Expanded(
                      child: CustomTextField(
                        obscure: false,
                        hintText: "Jedah (optional)",
                        controller: signUpController.jedahController,
                      ),
                    )
                  ],
                ),
                kHeight(14),
                CustomTextField(
                  obscure: false,
                  keyboardType: TextInputType.number,
                  hintText: "House number*",
                  controller: signUpController.houseNumberController,
                  validator: (value) => profileConfigController.validate(
                      value, "Please enter your House number"),
                ),
                kHeight(14),
                CustomTextField(
                  obscure: false,
                  keyboardType: TextInputType.number,
                  hintText: "Floor No (optional)",
                  controller: signUpController.floorNoController,
                ),
                kHeight(14),
                CustomTextField(
                  obscure: false,
                  keyboardType: TextInputType.number,
                  hintText: "Flat No (optional)",
                  controller: signUpController.flatNoController,
                ),
                kHeight(14),
                CustomTextField(
                  obscure: false,
                  hintText: "Comments (optional)",
                  controller: signUpController.commentsController,
                ),
                kHeight(50),
                CustomElevatedButton(
                    theme: theme,
                    onTap: () {
                      signUpController.areaId =
                          areaBlockController.selectedArea.value.id;
                      signUpController.blockName =
                          areaBlockController.selectedBlock.value.id;
                      log("${signUpController.areaId} ${signUpController.blockName}");
                      profileConfigController.validation();
                    },
                    text: "Done")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
