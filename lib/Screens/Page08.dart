import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanny_app/Custom_Widgets/custom_widgets.dart';
import 'package:tanny_app/Models/AdminReport.dart';

class Page08 extends StatefulWidget {
  final List<AdminReport> myAdminReportsAtNight;
  const Page08({super.key, required this.myAdminReportsAtNight});

  @override
  State<Page08> createState() => _Page08State();
}

class _Page08State extends State<Page08> {
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
              child: customList(widget.myAdminReportsAtNight, context,
                  widget.myAdminReportsAtNight.length)),
          SizedBox(
            height: 50.h,
          ),
        ],
      ),
    );
  }
}
