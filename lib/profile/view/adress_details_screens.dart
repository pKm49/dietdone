import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/profile/view/add_address_screen.dart';
import 'package:diet_diet_done/profile/widgets/address_card.dart';
import 'package:diet_diet_done/profile_config/controller/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressDetailsScreen extends StatelessWidget {
  const AddressDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.find<AddressController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addressController.fetchAddress();
    });
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 41,
                height: 41,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: borderColor,
                  ),
                  color: kWhiteColor,
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            Text(
              "Address",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            InkWell(
              onTap: () => Get.to(AddAddressScreen()),
              child: Container(
                height: 35,
                width: 38,
                decoration: BoxDecoration(
                    color: kBlackColor, borderRadius: BorderRadius.circular(5)),
                child: Icon(
                  Icons.add,
                  color: kWhiteColor,
                  size: 20,
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            kHeight(10),
            SearchBar(
              controller: addressController.searchController,
              onChanged: (value) => addressController.searchAddress(value),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)))),
              side: MaterialStatePropertyAll(BorderSide(color: borderColor)),
              elevation: MaterialStatePropertyAll(0),
              leading: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintStyle:
                  MaterialStatePropertyAll(TextStyle(color: Colors.grey)),
              hintText: "Find Address here...",
            ),
            kHeight(20),
            Expanded(child: Obx(
              () {
                return addressController.allAddress.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: addressController.allAddress.length,
                        separatorBuilder: (context, index) => kHeight(10),
                        itemBuilder: (context, index) {
                          final addressList =
                              addressController.addresses[index];
                          return AddressCard(
                            addressList: addressList,
                            index: index,
                          );
                        },
                      );
              },
            ))
          ],
        ),
      ),
    );
  }
}
