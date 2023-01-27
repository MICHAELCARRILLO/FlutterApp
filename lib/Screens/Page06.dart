import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanny_app/Custom_Widgets/custom_widgets.dart';

class Page06 extends StatefulWidget {
  const Page06({super.key});

  @override
  State<Page06> createState() => _Page06State();
}

class _Page06State extends State<Page06> {
  DateTime _currentDate = DateTime.now();

  String formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return "$day-$month-$year";
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2025))
        .then((value) => {setState(() => _currentDate = value!)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: ListView(
        children: [
          SizedBox(height: 35.h),
          Padding(
            padding: EdgeInsets.only(left: 66.w),
            child: Text(
              "Mis Reportes",
              style: TextStyle(
                  color: Color.fromRGBO(77, 75, 75, 1),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 49.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Fecha",
                style: TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.left,
              ),
              SizedBox(width: 35.w),
              InkWell(
                onTap: _showDatePicker,
                child: Container(
                  width: 180.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Stack(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10.w, height: 40.h),
                          Expanded(
                            child: Text(
                              formatDate(_currentDate),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 135, 135, 135),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Icon(Icons.date_range)),
                          SizedBox(width: 10.w),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Equipo",
                style: TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.left,
              ),
              SizedBox(width: 27.w),
              userInputInRow(
                  "CAM-03", 10.w, 178.w, 40.h, 5.r, Icons.search, 1.w),
            ],
          )
        ],
      ),
    );
  }
}
