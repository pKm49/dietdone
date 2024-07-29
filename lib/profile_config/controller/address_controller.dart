import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/controller/area_&_block_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/profile_config/api_service/create_address_service.dart';
import 'package:diet_diet_done/profile_config/api_service/get_address_service.dart';
import 'package:diet_diet_done/profile_config/model/address_model.dart';
import 'package:diet_diet_done/profile_config/model/get_address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddressController extends GetxController {
  final addressKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxList<GetAddressModel> addresses = <GetAddressModel>[].obs;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController blockController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController jedahController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController floorNoController = TextEditingController();
  final TextEditingController flatNoController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();
  RxList<GetAddressModel> allAddress = <GetAddressModel>[].obs;
  final signUpController = Get.find<SignUpController>();
  int? area;
  int? block;
  createAddress() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final mobileNumber = await prefs.getString("mobile");
      log(mobileNumber.toString(), name: "saved mobile number");
      String? jedhaValue =
          jedahController.text.isNotEmpty ? jedahController.text.trim() : "";
      int houseNumberValue = houseNumberController.text.isNotEmpty
          ? int.parse(houseNumberController.text.trim())
          : 1;
      int floorNumberValue = floorNoController.text.isNotEmpty
          ? int.parse(floorNoController.text.trim())
          : 2;
      String commentsValue = commentsController.text.isNotEmpty
          ? commentsController.text.trim()
          : "";

      if (signUpController.mobileNumber == null) {
        signUpController.mobileNumber = mobileNumber;
      }

      await CreateAddressApiServices().createNewAddress(CreateAddressModel(
        mobile: signUpController.mobileNumber!,
        nickname: "Office",
        area: area!,
        block: block!,
        street: streetController.text.trim(),
        jedha: jedhaValue,
        houseNumber: houseNumberValue,
        floorNumber: floorNumberValue,
        comments: commentsValue,
        apartmentNo: 9,
        deliveryTime: 8,
      ));
    } catch (e) {
      isLoading.value = false;
      log("Error while creating adding address $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAddress() async {
    try {
      await GetAddressApiServices().fetchAddressData().then((address) {
        print("address");
        print(address.toString());
        allAddress.value = address;
        return addresses.value = address;
      });
      log(addresses.toString(), name: "fetched address");
    } catch (e) {
      log("Failed to fetch data: $e", name: "error");
    }
  }

  searchAddress(String enterKeyword) {
    if (enterKeyword.isEmpty) {
      allAddress.value = addresses;
    } else {
      allAddress.value = addresses
          .where((element) => element.name
              .toLowerCase()
              .contains(enterKeyword.toLowerCase().trim()))
          .toList();
    }
  }

  updateAddress() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final mobileNumber = await prefs.getString("mobile");
      log(mobileNumber.toString(), name: "aelfedkj");
      String? jedhaValue = jedahController.text.isNotEmpty
          ? jedahController.text.trim()
          : "Not mentioned";
      int houseNumberValue = houseNumberController.text.isNotEmpty
          ? int.parse(houseNumberController.text.trim())
          : 0;
      int floorNumberValue = floorNoController.text.isNotEmpty
          ? int.parse(floorNoController.text.trim())
          : 0;
      String commentsValue = commentsController.text.isNotEmpty
          ? commentsController.text.trim()
          : "Not mentioned";

      await CreateAddressApiServices().updateAddress(CreateAddressModel(
        mobile: signUpController.mobileNumber!,
        nickname: "Office",
        area: area!,
        block: block!,
        street: streetController.text.trim(),
        jedha: jedhaValue,
        houseNumber: houseNumberValue,
        floorNumber: floorNumberValue,
        comments: commentsValue,
        apartmentNo: 9,
        deliveryTime: 8,
      ));
    } catch (e) {
      isLoading.value = false;
      log("Error while update address");
    } finally {
      isLoading.value = false;
    }
  }

  deleteAddress() {
    final response =
        http.delete(Uri.parse(ApiConfig.baseUrl + ApiConfig.address));
  }
}
