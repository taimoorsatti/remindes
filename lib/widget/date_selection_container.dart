

import 'package:flutter/material.dart';

class DateSelectionContainer extends StatelessWidget {
  final String? myText;
  final VoidCallback? myOnTap;
  final double ?myHeight;

  const DateSelectionContainer({
    @required this.myText,
    @required this.myOnTap,
    this.myHeight = 51,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: myOnTap,
      child: Container(
        height: myHeight,
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Opacity(
          opacity: 0.64,
          child: Center(
            child: Text(
              myText??"",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Quicksand",
                    fontSize: 15,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
