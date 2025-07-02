import 'package:Quarry/features/authentications/screens_onboarding/final_board.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController{
  static OnBoardingController get instance => Get.find();

  ///variable
   final pageController = PageController();
   Rx<int> currentPageIndex = 0.obs;


  ///update current index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  ///Jump to the specific dot selector page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }
  /// Update current index & jump to next page
  void nextPage(){
    if(currentPageIndex.value == 4){
      final storage = GetStorage();
      storage.write('IsFirstTime', false);
      Get.offAll(()=>FinalBoard());
    } else{
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  /// Update current index & jump to last page
  void skipPage(){
    Get.offAll(()=>FinalBoard());
  }
}