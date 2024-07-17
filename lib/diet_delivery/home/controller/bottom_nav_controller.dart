import 'package:diet_diet_done/diet_delivery/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  int currentTab = 1;

  Widget currentScreen = const HomeScreen();

  void updateScreen(Widget screen, int index) {
    currentScreen = screen;
    currentTab = index;
    update();
  }
}
