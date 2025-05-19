import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/presentation/view/screens/onboarding/onboarding_get_started_view.dart';

class OnboardingController extends GetxController{
  static OnboardingController get instance => Get.find();

  final pageController = PageController();
  var currentPageIndex = 0.obs;

  void updatePageIndicator(index){
    currentPageIndex.value = index;
  }

  void nextPage(BuildContext context){
    if(currentPageIndex.value == 3){
      context.push(const OnboardingGetStartedView());
    } else{
      int page = currentPageIndex.value + 1 ;
      pageController.jumpToPage(page);
    }
  }

  void skipToLastPage(BuildContext context){
    context.pushAndRemoveUntil(const OnboardingGetStartedView());
  }
}