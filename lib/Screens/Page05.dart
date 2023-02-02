import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tanny_app/Custom_Widgets/custom_widgets.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Custom_Widgets/pdf_api.dart';

class Page05 extends StatefulWidget {
  const Page05({super.key});

  @override
  State<Page05> createState() => _Page05State();
}

class _Page05State extends State<Page05> {
  int? _turn = 1;
  int? _machine = 1;
  int? _operator = 1;

  List<File?> images = [];

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        images.add(imageTemporary);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

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
      appBar: customAppbar(context, "Información de daño Material/Operacional"),
      body: ListView(
        children: [
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
                  Icons.pending_actions, 1.w),
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

          //images here
          Container(
            height: 350,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Image.file(images[index]!),
                );
              },
            ),
          ),
          SizedBox(
            height: 25.h,
          ),

          InkWell(
            onTap: () async {
              PermissionStatus cameraStatus = await Permission.camera.request();

              if (cameraStatus == PermissionStatus.granted) {
                pickImage();
              }
              if (cameraStatus == PermissionStatus.denied) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      "Necesita autorizar los permisos para usar la camara."),
                ));
              }
              if (cameraStatus == PermissionStatus.permanentlyDenied) {
                openAppSettings();
              }
            },
            child: Row(
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
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          button("Guardar Pdf", 25.w, screenWidth, () async {
            final pdfFile = await PdfApi.createPdf(images);
            showPrintedMessage("Succeed", "Saved at ${pdfFile.path}");
            PdfApi.openFile(pdfFile);
          }),
          SizedBox(height: 35.h),
        ],
      ),
    );
  }

  Widget buildImage(File? image, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      color: Colors.grey,
      child: Image.file(
        image!,
        fit: BoxFit.cover,
      ),
    );
  }

  showPrintedMessage(String title, String message) {
    Flushbar(
        title: title,
        message: message,
        duration: Duration(seconds: 10),
        icon: Icon(Icons.info, color: Colors.blue))
      ..show(context);
  }
}
