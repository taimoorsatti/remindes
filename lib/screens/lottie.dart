import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LottieScreen extends StatelessWidget {
  const LottieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
        Center(
      child:
          Lottie.asset('assets/gifs/data.json', height: 120.sp, width: 120.sp),
    );
  }
}
