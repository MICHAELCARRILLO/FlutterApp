import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanny_app/Custom_Widgets/custom_widgets.dart';
import 'dart:math';

class Page07 extends StatefulWidget {
  final List<Map<String, String>> jsonData;

  const Page07({super.key, required this.jsonData});

  @override
  State<Page07> createState() => _Page07State();
}

class _Page07State extends State<Page07> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      appBar: customAppbar(context, "Turno Día"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 45.w),
            child: Text(
              "Todos los reportes",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: 1.h),
          line(41.w),
          SizedBox(
            height: 5.h,
          ),
          Expanded(
              child:
                  customList(widget.jsonData, context, widget.jsonData.length)),
          SizedBox(
            height: 50.h,
          ),
        ],
      ),
    );
  }
}
