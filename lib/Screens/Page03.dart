import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanny_app/Custom_Widgets/custom_widgets.dart';
import 'package:tanny_app/Screens/Page04.dart';
import 'package:tanny_app/Screens/Page05.dart';

class Page03 extends StatelessWidget {
  const Page03({super.key});

  void registerMachine(BuildContext context) {}
  void reportDamage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Page05()));
  }

  void history(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Page04()));
  }

  void registerOperator(BuildContext context) {}
  void registerMechanic(BuildContext context) {}
  void logOut(BuildContext context) {
    Navigator.pop(context);
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
          button("Registrar Equipo", 25.w, screenWidth,
              () => registerMachine(context)),
          SizedBox(height: 13.h),
          button(
              "Reportar Daño", 25.w, screenWidth, () => reportDamage(context)),
          SizedBox(height: 13.h),
          button("Historial", 25.w, screenWidth, () => history(context)),
          SizedBox(height: 35.h),
          button("Registrar Operador", 25.w, screenWidth,
              () => registerOperator(context)),
          SizedBox(height: 13.h),
          button("Registrar Mecánico", 25.w, screenWidth,
              () => registerMechanic(context)),
        ],
      ),
    );
  }
}
