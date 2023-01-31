import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanny_app/Custom_Widgets/custom_widgets.dart';
import 'dart:math';

import 'package:tanny_app/Screens/Page07.dart';
import 'package:tanny_app/Screens/Page08.dart';

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
      lastDate: DateTime(2025),
      locale: Locale('es', 'ES'),
    ).then((value) => {setState(() => _currentDate = value!)});
  }

  void dayTurn() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Page07(jsonData: jsonData)));
  }

  void nightTurn() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Page08(jsonData: jsonData)));
  }

  var jsonData = [
    {"Equipo": "HOR-05", "Fecha": "25-03-2022", "Nombre": "Jorge Martinez"},
    {"Equipo": "VOL-07", "Fecha": "28-03-2022", "Nombre": "Maria Rodriguez"},
    {"Equipo": "HOR-05", "Fecha": "30-03-2022", "Nombre": "Juan Perez"},
    {"Equipo": "VOL-07", "Fecha": "01-04-2022", "Nombre": "Pedro Gonzalez"},
    {"Equipo": "HOR-05", "Fecha": "03-04-2022", "Nombre": "Sofia Hernandez"},
    {"Equipo": "VOL-07", "Fecha": "05-04-2022", "Nombre": "Andres Ortiz"},
    {"Equipo": "HOR-05", "Fecha": "08-04-2022", "Nombre": "Maria Garcia"},
    {"Equipo": "VOL-07", "Fecha": "10-04-2022", "Nombre": "Juan Gomez"},
    {"Equipo": "HOR-05", "Fecha": "13-04-2022", "Nombre": "Sandra Martinez"},
    {"Equipo": "VOL-07", "Fecha": "15-04-2022", "Nombre": "Carlos Rodriguez"},
    {"Equipo": "HOR-05", "Fecha": "08-04-2022", "Nombre": "Maria Garcia"},
    {"Equipo": "VOL-07", "Fecha": "10-04-2022", "Nombre": "Juan Gomez"},
    {"Equipo": "HOR-05", "Fecha": "13-04-2022", "Nombre": "Sandra Martinez"},
    {"Equipo": "VOL-07", "Fecha": "15-04-2022", "Nombre": "Carlos Rodriguez"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      appBar: customAppbar(context, "Mis Reportes"),
      body: ListView(
        children: [
          SizedBox(height: 25.h),
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
                                  color: Color.fromRGBO(47, 72, 167, 1),
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
          SizedBox(height: 18.h),
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
                  "CAM-03", 5.w, 178.w, 45.h, 5.r, Icons.search, 1.w),
            ],
          ),
          SizedBox(height: 35.h),
          Padding(
            padding: EdgeInsets.only(left: 45.w),
            child: Text(
              "Turno Día",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: 1.h),
          line(41.w),
          customList(jsonData, context, 3),
          Padding(
            padding: EdgeInsets.only(right: 50.w, top: 15.h),
            child: InkWell(
              onTap: dayTurn,
              child: Text(
                "+ Ver más",
                style: TextStyle(
                    color: Color(0xFF5E5E5E),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          SizedBox(height: 13.h),
          Padding(
            padding: EdgeInsets.only(left: 45.w),
            child: Text(
              "Turno Noche",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: 1.h),
          line(41.w),
          customList(jsonData, context, 3),
          Padding(
            padding: EdgeInsets.only(right: 50.w, top: 15.h),
            child: InkWell(
              onTap: nightTurn,
              child: Text(
                "+ Ver más",
                style: TextStyle(
                    color: Color(0xFF5E5E5E),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.right,
              ),
            ),
          )
        ],
      ),
    );
  }
}
