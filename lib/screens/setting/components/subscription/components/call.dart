import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remindly_app/utils/constants.dart';

import '../../../../../utils/assets_image_path.dart';

class CallScreen extends StatelessWidget {
  CallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: InkWell(
            onTap: (){
              Fluttertoast.showToast(msg: " subcription features will available soon ",backgroundColor: Colors.black);
            },
            child: Image.asset(
              AppAssets.callpkg,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(
            25.sp,
          ),
          child: Container(
            alignment: Alignment.centerRight,
            height: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$1.99",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Quicksand",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "Call Subscription (3 Months)  ",
                  style: TextStyle(
                    color:Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Quicksand",
                  ),
                ),
            Icon(Icons.info_outline,size: 34.sp,color: Colors.white,)
              ],
            ),
          ),
        )
      ],
    );
  }
}
