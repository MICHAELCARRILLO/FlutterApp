import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanny_app/Custom_Widgets/custom_widgets.dart';
import 'package:tanny_app/Models/AdminReport.dart';
import 'dart:math';

import 'package:tanny_app/Screens/Page07.dart';
import 'package:tanny_app/Screens/Page08.dart';

import 'package:http/http.dart' as http;

class Page06 extends StatefulWidget {
  const Page06({super.key});

  @override
  State<Page06> createState() => _Page06State();
}

class _Page06State extends State<Page06> {
  DateTime _currentDate = DateTime.now();
  List<AdminReport> myAdminReportsAtDay = [];
  List<AdminReport> myAdminReportsAtNight = [];
  TextEditingController machineController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllAdminResport();
  }

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
    ).then((value) => {
          setState(() => _currentDate = value!),
        });
  }

  void dayTurn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Page07(myAdminReportsAtDay: myAdminReportsAtDay)));
  }

  void nightTurn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Page08(myAdminReportsAtNight: myAdminReportsAtNight)));
  }

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
                onTap: () {
                  _showDatePicker();
                },
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 70.w),
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
                  "CAM-03", 0, 128.w, 45.h, 5.r, 1.w, machineController),
              SizedBox(width: 10.w),
              SizedBox(
                width: 45.w,
                height: 45.h,
                child: MaterialButton(
                  onPressed: getAllAdminResport,
                  color: Color.fromARGB(255, 42, 97, 169),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 255, 255, 255),
                    size: 20.sp,
                  ),
                ),
              )
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
          customList(myAdminReportsAtDay, context, 3),
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
          customList(myAdminReportsAtNight, context, 3),
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

  Future getAllAdminResport() async {
    setState(() {
      myAdminReportsAtDay = [];
      myAdminReportsAtNight = [];
    });

    DateTime date = _currentDate;

    final url;

    if (machineController.text == "") {
      url = Uri.parse(
          'https://tannyapp.fly.dev/api/admin-reports/MyDate=${date.toString().substring(0, 10)}');
    } else {
      url = Uri.parse(
          'https://tannyapp.fly.dev/api/admin-reports/date=${date.toString().substring(0, 10)}&machine_code=${machineController.text.toUpperCase()}');
    } //admin-reports/date=2023-01-01&machine_code=HOR-04

    print(url);
    final response = await http.get(url);
    List<AdminReport> adminReports = [];

    if (response.statusCode == 200) {
      final adminReportsJson = List.from(jsonDecode(response.body));
      adminReportsJson.forEach((element) {
        AdminReport newAdminReport = AdminReport.fromJson(element);
        adminReports.add(newAdminReport);
      });

      List<AdminReport> adminReportsAtDay = [];
      List<AdminReport> adminReportsAtNight = [];

      adminReports.forEach((element) {
        if (element.turn == "DAY") {
          adminReportsAtDay.add(element);
        } else {
          adminReportsAtNight.add(element);
        }
      });

      setState(() {
        myAdminReportsAtDay = adminReportsAtDay;
        myAdminReportsAtNight = adminReportsAtNight;
      });
    } else {
      print(response.statusCode);
    }
  }
}
