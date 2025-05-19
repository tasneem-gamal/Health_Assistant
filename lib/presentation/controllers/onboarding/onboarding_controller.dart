import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController{
  static OnboardingController get instance => Get.find();

  final pageController = PageController();
  var currentPageIndex = 0.obs;

  void updatePageIndicator(index){
    currentPageIndex.value = index;
  }

  void nextPage(BuildContext context){
    if(currentPageIndex.value == 2){
      //context.pushNamed(Routes.onBoardingGetStartedView);
    } else{
      int page = currentPageIndex.value + 1 ;
      pageController.jumpToPage(page);
    }
  }
}