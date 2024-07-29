import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/profile/view/edit_address_screen.dart';
import 'package:diet_diet_done/profile_config/model/get_address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddressCard extends StatelessWidget {
  AddressCard({super.key, this.addressList, this.index});
  GetAddressModel? addressList;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: borderColor)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: borderColor)),
                child: SvgPicture.asset("assets/icon/Add Address.svg"),
              ),
              kWidth(10),
              Expanded(
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    addressList!.comments,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: SizedBox(
                  width: 40,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(EditAddressScreen(
                            index: index!,
                          ));
                        },
                        icon: Icon(
                          Icons.edit_outlined,
                          size: 18,
                        ),
                      ),
                      Divider(
                        color: kBlackColor,
                        height: 1,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          kHeight(10),
          Row(
            children: [
              Expanded(
                child: Text(
                    "${addressList!.areaName}, ${addressList!.street} Street, Block ${addressList!.blockName}, ${addressList!.jedha} jedha, house No: ${addressList!.houseNumber}, flat No: ${addressList!.floorNumber}, Comments: ${addressList!.comments}"),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: borderColor)),
                height: 80,
                width: 80,
                child: const Icon(Icons.location_on_outlined),
              )
            ],
          ),
        ],
      ),
    );
  }
}
