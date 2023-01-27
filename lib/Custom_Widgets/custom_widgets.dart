import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget button(
  String text,
  double horizontalPadding,
  final screenWidth,
  Function onPress,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
    child: SizedBox(
      width: screenWidth,
      height: 59.h,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(47, 72, 167, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          onPressed: () => onPress(),
          child: Text(text,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Exo'))),
    ),
  );
}

Widget userInput(String textHint, bool password) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25.w),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: TextField(
          decoration:
              InputDecoration(border: InputBorder.none, hintText: textHint),
          obscureText: password,
        ),
      ),
    ),
  );
}

Image customImageBar(double customSize) {
  return Image.asset("images/image03.png",
      height: customSize, width: double.infinity, alignment: Alignment.topLeft);
}

Padding userInputInRow(String textHint, double horizontalPadding, double width,
    double height, double radius, IconData icon, borderWidth) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Color.fromARGB(255, 163, 163, 163), width: borderWidth),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              hintText: textHint,
              hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 135, 135, 135),
                  fontWeight: FontWeight.bold),
              suffixIcon: Icon(icon),
              border: InputBorder.none),
        ),
      ),
    ),
  );
}
