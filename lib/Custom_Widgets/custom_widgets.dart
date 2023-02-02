import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';

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
      height: 62.h,
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

Padding line(
  double horizontalPadding,
) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
    child: Container(
      width: double.infinity, // set the width to take up the full screen
      height: 1, // set the height of the rectangle
      decoration: BoxDecoration(
        color: Color(0xff838383), // set the color of the rectangle
        border: Border.all(color: Color(0xff838383), width: 2), // add a border
      ),
    ),
  );
}

Padding customListItem(String machine, String date, String name) {
  return Padding(
    padding: EdgeInsets.only(left: 40.w, top: 16.h, bottom: 3.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                machine,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                date,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(102, 102, 102, 1)),
              )
            ],
          ),
          Expanded(
              child: Align(
            alignment: Alignment.centerRight,
            child: Text(name,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400)),
          )),
          SizedBox(width: 15.w),
          Icon(
            Icons.navigate_next,
            color: Color.fromRGBO(153, 153, 153, 1),
            size: 30,
          ),
          SizedBox(width: 40.w),
        ]),
        SizedBox(
          height: 6.h,
        ),
        SizedBox(
          width: 308.w,
          height: 0.5.h,
          child: Divider(
            color: Color.fromRGBO(131, 131, 131, 1),
            thickness: 1,
          ),
        )
      ],
    ),
  );
}

ListView customList(var jsonData, BuildContext context, int itemsToShow) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: min(jsonData.length, itemsToShow),
    itemBuilder: (context, int index) {
      var item = jsonData[index];
      return customListItem(item['Equipo']!, item['Fecha']!, item['Nombre']!);
    },
  );
}

InkWell customBackButton(BuildContext context, double size, Color color) {
  return InkWell(
    onTap: () => {
      Navigator.pop(context),
    },
    child: SizedBox(
      width: 40.w,
      height: 35.h,
      child: Icon(Icons.arrow_back_ios_new_outlined, size: size, color: color),
    ),
  );
}

AppBar customAppbar(BuildContext context, String text) {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 247, 247, 247),
    shadowColor: Color.fromARGB(255, 247, 247, 247),
    elevation: 0,
    centerTitle: true,
    leading: IconButton(
      icon:
          customBackButton(context, 25, const Color.fromRGBO(102, 102, 102, 1)),
      onPressed: () {
        // Perform action when icon is pressed
      },
    ),
    title: Text(
      text,
      style: TextStyle(
          color: const Color.fromRGBO(77, 75, 75, 1),
          fontSize: 20.sp,
          fontWeight: FontWeight.w700),
      textAlign: TextAlign.left,
    ),
  );
}
