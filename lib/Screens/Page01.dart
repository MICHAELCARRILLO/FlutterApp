import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanny_app/Screens/Page02.dart';
import '../Custom_Widgets/custom_widgets.dart';

class Page01 extends StatelessWidget {
  const Page01({super.key});

  void onPressAdmin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Page02()));
  }

  void onPressWorker() {
    print("dos");
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: customAppBar(),
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: Column(
        children: [
          customImageBar(190.h),
          Image(
            image: AssetImage("images/image01.png"),
            height: 210.h,
          ),
          SizedBox(height: 70.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 57.w),
            child: Text("Design your TODOs",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30.sp)),
          ),
          SizedBox(height: 50.h),
          button(
              "Administrador", 23.w, screenWidth, () => onPressAdmin(context)),
          SizedBox(height: 29.h),
          button("Trabajador", 23.w, screenWidth, onPressWorker),
        ],
      ),
    );
  }
}
