import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanny_app/Screens/Page03.dart';
import '../Custom_Widgets/custom_widgets.dart';

class Page02 extends StatelessWidget {
  const Page02({super.key});

  void logIn(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Page03()));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: customAppBar(),
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: ListView(
        children: [
          customImageBar(190.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 49.w),
            child: const Text("Bienvenido!",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
                textAlign: TextAlign.center),
          ),
          SizedBox(height: 17.h),
          SizedBox(
              width: 210.w,
              height: 210.h,
              child: const Image(image: AssetImage("images/image02.png"))),
          SizedBox(height: 45.h),
          userInput("Usuario", false),
          SizedBox(height: 20.h),
          userInput("Contraseña", true),
          SizedBox(height: 35.h),
          button("Iniciar Sesión", 23.w, screenWidth, () => logIn(context)),
        ],
      ),
    );
  }
}
