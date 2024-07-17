import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HighlightCenterNumberList extends StatefulWidget {
  const HighlightCenterNumberList({super.key});

  @override
  HighlightCenterNumberListState createState() =>
      HighlightCenterNumberListState();
}

class HighlightCenterNumberListState extends State<HighlightCenterNumberList> {
  final signUpController = Get.find<SignUpController>();
  final ScrollController _scrollController = ScrollController();
  int centerIndex = 2;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateCenterIndex);
  }

  void _updateCenterIndex() {
    final screenWidth = MediaQuery.of(context).size.width;
    final center = screenWidth / 2;
    final index = (_scrollController.offset + center) ~/ 80;

    setState(() {
      centerIndex = index;
      signUpController.height = centerIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          child: ListView.builder(
            itemCount: 153,
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 80,
                child: Center(
                  child: Text(
                    index.toString(),
                    style: index != centerIndex
                        ? const TextStyle(fontSize: 20, color: borderColor)
                        : const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
