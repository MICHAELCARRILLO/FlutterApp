import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanny_app/Custom_Widgets/custom_widgets.dart';

class Page05 extends StatefulWidget {
  const Page05({super.key});

  @override
  State<Page05> createState() => _Page05State();
}

class _Page05State extends State<Page05> {
  int? _turn = 1;
  int? _machine = 1;
  int? _operator = 1;

  void _handleTurn(int? value) {
    setState(() {
      _turn = value;
    });
  }

  void _handleMachine(int? value) {
    setState(() {
      _machine = value;
    });
  }

  void _handleOperator(int? value) {
    setState(() {
      _operator = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: ListView(
        children: [
          SizedBox(height: 60.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 49.w),
            child: Text(
              "Información de daño Material/Operacional",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 28.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Turno",
                style: TextStyle(
                    color: Color.fromRGBO(77, 75, 75, 1),
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 40.w),
              Radio(value: 1, groupValue: _turn, onChanged: _handleTurn),
              Text(
                "Día",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(width: 30.w),
              Radio(value: 2, groupValue: _turn, onChanged: _handleTurn),
              Text(
                "Noche",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 26.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              userInputInRow("Código del equipo", 25.w, 220.w, 45.h, 12.r,
                  IconData(0x00000000), 1.w),
              SizedBox(width: 15.w),
              InkWell(
                onTap: () => {},
                child: Text(
                  "Buscar",
                  style: TextStyle(
                      color: Color.fromRGBO(77, 75, 75, 1),
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          SizedBox(height: 25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Equipo",
                style: TextStyle(
                    color: Color.fromRGBO(77, 75, 75, 1),
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 30.w),
              Radio(value: 1, groupValue: _machine, onChanged: _handleMachine),
              Text(
                "HOR-05",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.w),
            child: Text(
              "Operador",
              style: TextStyle(
                  color: Color.fromRGBO(77, 75, 75, 1),
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 18.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 40.w),
              Radio(
                  value: 1, groupValue: _operator, onChanged: _handleOperator),
              Text(
                "Juan Avalo",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(width: 30.w),
              Radio(
                  value: 2, groupValue: _operator, onChanged: _handleOperator),
              Text(
                "Hector Peres",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: SizedBox(
              height: 135.h,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(12.r)),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Descripción del daño...',
                    ),
                    minLines: 1,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt,
                size: 50.sp,
                color: Color.fromRGBO(146, 146, 146, 1.0),
              ),
              SizedBox(
                width: 15.w,
              ),
              Text(
                "Tomar fotos.",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          button("Guardar Pdf", 25.w, screenWidth, () {}),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
