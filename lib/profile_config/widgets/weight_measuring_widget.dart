import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeightCenterNumberList extends StatefulWidget {
  const WeightCenterNumberList({Key? key}) : super(key: key);

  @override
  WeightCenterNumberListState createState() => WeightCenterNumberListState();
}

class WeightCenterNumberListState extends State<WeightCenterNumberList> {
  final ScrollController _scrollController = ScrollController();
  final signUpController = Get.find<SignUpController>();

  int centerIndex = 2;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateCenterIndex);
  }

  void _updateCenterIndex() {
    final screenWidth = MediaQuery.of(context).size.width;
    final center = screenWidth / 2;
    final itemWidth = 80; // Adjust according to your item width
    final index = (_scrollController.offset + center) ~/ itemWidth;

    setState(() {
      centerIndex = index;
      signUpController.weight = centerIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 210,
        itemBuilder: (context, index) {
          bool isMultipleOfFive = index % 5 == 0;
          return GestureDetector(
            onTap: () {
              setState(() {
                centerIndex = index;
                signUpController.weight = centerIndex;
              });
            },
            child: Container(
              width: 80, // Adjust according to your item width
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 35,
                        child: VerticalDivider(
                          thickness: 3,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        child: VerticalDivider(
                          thickness: 3,
                          color: centerIndex == index
                              ? Colors.black
                              : Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        child: VerticalDivider(
                          thickness: 3,
                          color: centerIndex == index
                              ? Colors.black
                              : Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        child: VerticalDivider(
                          thickness: 3,
                          color: centerIndex == index
                              ? Colors.black
                              : Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        child: VerticalDivider(
                          thickness: 3,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    index.toString(),
                    style: TextStyle(
                      fontSize: centerIndex == index ? 35 : 18,
                      fontWeight: centerIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
