import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanny_app/Custom_Widgets/custom_widgets.dart';
import 'package:tanny_app/Screens/Page02.dart';
import 'package:tanny_app/Screens/Page06.dart';

class Page04 extends StatelessWidget {
  const Page04({super.key});
  void myReports(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Page06()));
  }

  void mechanicReport(BuildContext context) {}
  void allMachines(BuildContext context) {}
  void allMechanics(BuildContext context) {}

  void logOut(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Page02()));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: Column(
        children: [
          Container(
            color: const Color.fromRGBO(47, 72, 167, 1),
            child: Column(children: [
              customImageBar(138.h),
              Image(
                image: AssetImage("images/image04.png"),
                height: 130.h,
              ),
              SizedBox(height: 16.h),
              Text(
                "Bienvenido Tanny Nina",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 7.h,
              ),
              InkWell(
                onTap: () => {logOut(context)},
                child: Text(
                  "Salir",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
            ]),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Buen Día",
                style: TextStyle(
                    color: new Color(0xFF4870FF),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 40.w, width: 24.w),
            ],
          ),
          SizedBox(height: 13.h),
          button("Mis Reportes", 25.w, screenWidth, () => myReports(context)),
          SizedBox(height: 13.h),
          button("Reporte de Mecánicos", 25.w, screenWidth,
              () => mechanicReport(context)),
          SizedBox(height: 35.h),
          button("Todos los Equipos", 25.w, screenWidth,
              () => allMachines(context)),
          SizedBox(height: 13.h),
          button("Todos los Mecánico", 25.w, screenWidth,
              () => allMechanics(context)),
        ],
      ),
    );
  }
}
