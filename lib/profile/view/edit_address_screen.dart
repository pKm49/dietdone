import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/controller/area_&_block_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/auth/sign_up/model/area_&_block_model.dart';
import 'package:diet_diet_done/auth/sign_up/widget/custom_app_bar.dart';
import 'package:diet_diet_done/auth/sign_up/widget/text_field.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/profile_config/api_service/create_address_service.dart';
import 'package:diet_diet_done/profile_config/controller/address_controller.dart';
import 'package:diet_diet_done/profile_config/controller/profile_config_controller.dart';
import 'package:diet_diet_done/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constraints/constraints.dart';

class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final areaBlockController = Get.find<AreaAndBlockController>();
    final signUpController = Get.find<SignUpController>();
    final addressController = Get.find<AddressController>();
    print("edit address screen");
    print(areaBlockController.areas.isNotEmpty);
    print(addressController.addresses[index].areaId);
    print(areaBlockController.areas.where((p0) =>
    p0.id==addressController.addresses[index].areaId
    ).toList());
    if(areaBlockController.areas.isNotEmpty){
      if(areaBlockController.areas.where((p0) =>
      p0.id==addressController.addresses[index].areaId
      ).toList().isNotEmpty){
       areaBlockController.selectedArea.value =  areaBlockController.areas.where((p0) =>
        p0.id==addressController.addresses[index].areaId
        ).toList()[0];
        areaBlockController.fetchBlocks(areaBlockController.selectedArea.value.id,

                addressController.addresses[index].blockId
        );
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // areaBlockController.fetchAreas();
      signUpController.areaController.text =
          addressController.addresses[index].areaName;
      signUpController.blockController.text =
          addressController.addresses[index].blockName;
      signUpController.streetController.text =
          addressController.addresses[index].street;
      signUpController.jedahController.text =
          addressController.addresses[index].jedha;
      signUpController.houseNumberController.text =
          addressController.addresses[index].houseNumber;
      signUpController.floorNoController.text =
          addressController.addresses[index].floorNumber;
      signUpController.flatNoController.text =
          addressController.addresses[index].floorNumber;
      signUpController.commentsController.text =
          addressController.addresses[index].comments;
 ;
    });
    final theme = Theme.of(context);
    final profileConfigController = Get.find<ProfileConfigController>();
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
                  "Edit Your Address",
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
                          areaBlockController.fetchBlocks(newValue.id,-1);
                        }
                      },
                      items: areaBlockController.areas.map((area) {
                        return DropdownMenuItem<GetAreaModel>(
                          value: area,
                          child: Text(
                            "${area.name} ",
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
                  hintText: "Place eg: office,home..",
                  controller: signUpController.commentsController,
                ),
                kHeight(50),
                CustomElevatedButton(
                    theme: theme,
                    onTap: () async {
                      log("update in...........");
                      print(areaBlockController.selectedArea.value.id.toString());
                      print(areaBlockController.selectedBlock.value.id.toString());
                      final prefs = await SharedPreferences.getInstance();
                      final mobile = prefs.getString("mobile");
                      await CreateAddressApiServices().updateAddress({
                        "address_id": addressController.allAddress[index].id,
                        "mobile": mobile,
                        "name": "home 2",
                        "area_id": areaBlockController.selectedArea.value.id,
                        "block_id": areaBlockController.selectedBlock.value.id,
                        "street": signUpController.streetController.text,
                        "jedha": signUpController.jedahController.text,
                        "house_number": signUpController.houseNumberController.text,
                        "floor_number": signUpController.floorNoController.text,
                        "apartment_no": signUpController.flatNoController.text,
                        "delivery_time": 4,
                        "comments": signUpController.commentsController.text
                      });
                      log("update out...........");
                    },
                    text: "Update")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
