import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remindly_app/utils/constants.dart';

class MultilineTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? mycontroler;


  const MultilineTextField({super.key, this.hintText,this.mycontroler});

  @override
  // ignore: library_private_types_in_public_api
  _MultilineTextFieldState createState() => _MultilineTextFieldState();
}

class _MultilineTextFieldState extends State<MultilineTextField> {
  var remianText = 500;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            height: 180.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: const Color(0xFFF1F3F7),
            )),
        Container(
          padding: const EdgeInsets.only(left: 15, top: 2),
          child: TextField(
            style: TextStyle(
                color: Constant.primaryColor,
                fontFamily: "Quicksand",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600
            ),
            maxLines: 7,
            controller:widget.mycontroler,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle:  TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "Quicksand",
                color: Constant.primaryColor,
              ),
            ),
            onChanged: (String text) {
              print(text.length);
              setState(() {
                remianText = 500 - text.length;
              });
            },
          ),
        ),
        Positioned(
          bottom: 5,
          right: 15,
          child: Text(
            "$remianText",
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
