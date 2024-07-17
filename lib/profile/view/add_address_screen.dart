import 'package:diet_diet_done/auth/sign_up/controller/area_&_block_controller.dart';
import 'package:diet_diet_done/auth/sign_up/model/area_&_block_model.dart';
import 'package:diet_diet_done/auth/sign_up/widget/custom_app_bar.dart';
import 'package:diet_diet_done/auth/sign_up/widget/text_field.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/profile_config/controller/address_controller.dart';
import 'package:diet_diet_done/profile_config/controller/profile_config_controller.dart';
import 'package:diet_diet_done/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constraints/constraints.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late final areaBlockController = AreaAndBlockController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      areaBlockController.fetchAreas();
      areaBlockController.fetchBlocks();
    });
    final addressController = Get.find<AddressController>();
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
            key: addressController.addressKey,
            child: Column(
              children: [
                kHeight(20),
                Text(
                  "Enter Your New Address",
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
                            "${block.id}",
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
                        controller: addressController.streetController,
                        validator: (value) => profileConfigController.validate(
                            value, "Please enter your Street"),
                      ),
                    ),
                    kWidth(14),
                    Expanded(
                      child: CustomTextField(
                        obscure: false,
                        hintText: "Jedah (optional)",
                        controller: addressController.jedahController,
                      ),
                    )
                  ],
                ),
                kHeight(14),
                CustomTextField(
                  obscure: false,
                  keyboardType: TextInputType.number,
                  hintText: "House number*",
                  controller: addressController.houseNumberController,
                  validator: (value) => profileConfigController.validate(
                      value, "Please enter your House number"),
                ),
                kHeight(14),
                CustomTextField(
                  obscure: false,
                  keyboardType: TextInputType.number,
                  hintText: "Floor No (optional)",
                  controller: addressController.floorNoController,
                ),
                kHeight(14),
                CustomTextField(
                  obscure: false,
                  keyboardType: TextInputType.number,
                  hintText: "Flat No (optional)",
                  controller: addressController.flatNoController,
                ),
                kHeight(14),
                CustomTextField(
                  obscure: false,
                  hintText: "Comments (optional)",
                  controller: addressController.commentsController,
                ),
                kHeight(50),
                Obx(
                  () => addressController.isLoading.value
                      ? CircularProgressIndicator()
                      : CustomElevatedButton(
                          theme: theme,
                          onTap: () async {
                            if (addressController.addressKey.currentState!
                                .validate()) {
                              addressController.area = await areaBlockController
                                  .selectedArea.value.id;
                              addressController.block =
                                  await areaBlockController
                                      .selectedBlock.value.id;
                              await addressController.createAddress();
                            }
                          },
                          text: "Done"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
