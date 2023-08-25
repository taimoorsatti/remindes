// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:remindly_app/controllers/onboarding/onboarding_controller.dart';
//
// import '../../services/ads/app_open_manager.dart';
// import '../../utils/constants.dart';
// import 'components/button.dart';
// class RequestRideView extends StatefulWidget {
//   @override
//   _RequestRideViewState createState() => _RequestRideViewState();
// }
//
// class _RequestRideViewState extends State<RequestRideView> {
//   late PageController controller;
//   OnboardingController controllerOnboarding = Get.put(OnboardingController());
//   @override
//
//
//   @override
//   void initState() {
//     super.initState();
//     controller = PageController();
//   }
//
//   Widget _buildPageIndicator(bool isCurrentPage) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 5.0),
//       height: isCurrentPage ? 12.0.h : 8.0.h,
//       width: isCurrentPage ? 12.0.w : 8.0.w,
//       decoration: BoxDecoration(
//         color: isCurrentPage ? Colors.white : Colors.grey[400],
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
//         statusBarIconBrightness: Brightness.light,
//         statusBarBrightness: Brightness.light,
//         systemNavigationBarColor: Constant.primaryColor,
//         statusBarColor: Constant.secondaryColor,
//         systemNavigationBarIconBrightness: Brightness.light);
//     SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
//     return Container(
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: Constant.primaryColor,
//           body: Container(
//             decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     stops: [
//                   0.1,
//                   0.9,
//                 ],
//                     colors: [
//                   Constant.secondaryColor,
//                   Constant.primaryColor
//                 ])),
//             height: MediaQuery.of(context).size.height,
//             child: PageView(
//               controller: controller,
//               onPageChanged: (index) {
//                 setState(() {
//                   controllerOnboarding.slideIndex = index;
//                 });
//               },
//               children: <Widget>[
//                 SlideTile(
//                     imagePath: controllerOnboarding.imgList[0],
//                     title: controllerOnboarding.imgList1[0],
//                     desc: controllerOnboarding.imgList2[0]),
//                 SlideTile(
//                     imagePath: controllerOnboarding.imgList[1],
//                     title: controllerOnboarding.imgList1[1],
//                     desc: controllerOnboarding.imgList2[1]),
//                 SlideTile(
//                     imagePath: controllerOnboarding.imgList[2],
//                     title: controllerOnboarding.imgList1[2],
//                     desc: controllerOnboarding.imgList2[2]),
//               ],
//             ),
//           ),
//           bottomSheet: Container(
//             height: 50.h,
//             color: Constant.primaryColor,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 for (int i = 0; i < 3; i++)
//                   i == controllerOnboarding.slideIndex
//                       ? _buildPageIndicator(true)
//                       : _buildPageIndicator(false),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class SlideTile extends StatelessWidget {
//   String? imagePath, title, desc;
//
//   SlideTile({this.imagePath, this.title, this.desc});
//
//   OnboardingController controllerOnboarding = Get.put(OnboardingController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 15.0.sp),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(height: 20.sp),
//           Container(
//             height:250.h,
//             width: Get.width-60.w,
//
//             //width: 215,
//
//             decoration: BoxDecoration(
//                 //color: Colors.black,
//                 //borderRadius: BorderRadius.circular(100),
//                 shape: BoxShape.circle),
//             child: Image.asset(
//               imagePath ?? "",
//               fit: BoxFit.contain,
//             ),
//           ),
//           SizedBox(
//             height: 30.h,
//           ),
//           Container(
//             // margin: EdgeInsets.only(bottom: 100),
//             child: Column(
//               children: [
//                 Container(
//                   child: Text(
//                     title ?? "",
//                     textAlign: TextAlign.center,
//                     style:  TextStyle(
//                       fontFamily: 'Quicksand',
//                       color: Colors.black,
//                       fontSize: 2.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: 30.h,
//           ),
//           controllerOnboarding.slideIndex == 2
//               ? Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
//                   child: OnboardingButton(),
//                 )
//               : Container()
//         ],
//       ),
//     );
//   }
// }
//
//
//
