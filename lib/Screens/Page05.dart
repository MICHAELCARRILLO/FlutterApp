import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tanny_app/Custom_Widgets/ImageWithDateOverlay%20.dart';
import 'package:tanny_app/Custom_Widgets/custom_widgets.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:tanny_app/Models/Admin.dart';
import 'package:tanny_app/Models/AdminReport.dart';
import 'package:tanny_app/Models/Machine.dart';
import 'package:tanny_app/Models/Operator.dart';
import '../Custom_Widgets/pdf_api.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:screenshot/screenshot.dart';
import 'package:flutter/rendering.dart';

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
  List<File?> editedImages = [];
  Widget newImagee = Container();
  Uint8List? myBytes;
  final GlobalKey<State<StatefulWidget>> _widgetKey = GlobalKey();

  Future<ui.Image> loadImage(File imageFile) async {
    // Read the file as bytes
    List<int> imageBytes = await imageFile.readAsBytes();

    // Convert the bytes to Uint8List
    Uint8List bytes = Uint8List.fromList(imageBytes);

    // Decode the image from the Uint8List
    ui.Image decodedImage = await decodeImageFromList(bytes);

    return decodedImage;
  }

  Future<File> writeBytesToFile(Uint8List bytes, String fileName) async {
    final file = File(fileName);
    return await file.writeAsBytes(bytes);
  }

  Future<String> generateImageFilename() async {
    final now = DateTime.now();
    final formatter = DateFormat('yyyyMMdd_HHmmss_SSS');
    final milliseconds = now.millisecond.toString().padLeft(3, '0');
    final filename = '${formatter.format(now)}_$milliseconds.png';
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/$filename';
    return path;
  }

  Future pickImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;
      final imageTemporary = File(image.path);

      // Create a date string with the current date

      final overlayWidget =
          ImageWithDateOverlay(imageFile: imageTemporary, date: "2023-02-02");

      setState(() {
        newImagee = overlayWidget;
      });

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

  TextEditingController machineCode = TextEditingController();
  TextEditingController description = TextEditingController();

  Machine mainMachine = Machine();
  AdminReport mainAdminReport = AdminReport(
      id: 0,
      description: "",
      date: "",
      turn: "",
      operator: Operator(
          id: 0,
          name: "",
          lastname: "",
          dni: "",
          responsability: "",
          machineId: 0),
      machine: Machine());

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              userInputInRow("Código del equipo", 25.w, 170.w, 45.h, 12.r, 1.w,
                  machineCode),
              InkWell(
                onTap: () => {
                  if (machineCode.text.isEmpty)
                    {
                      Flushbar(
                        message: "Ingrese el código del equipo",
                        duration: Duration(seconds: 3),
                      )..show(context)
                    }
                  else
                    {
                      searchMachine(machineCode),
                    }
                },
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
              if (mainMachine.code != "") ...[
                Radio(
                    value: 1, groupValue: _machine, onChanged: _handleMachine),
                Text(
                  mainMachine.code,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
                )
              ]
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
              SizedBox(width: 30.w),
              if (mainMachine.operators != null) ...[
                for (var i = 0; i < mainMachine.operators.length; i++) ...[
                  Radio(
                    value: i,
                    groupValue: _operator,
                    onChanged: _handleOperator,
                  ),
                  Text(
                    "${mainMachine.operators[i].name} ${mainMachine.operators[i].lastname.split(' ')[0]}",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: 10.w),
                ],
              ]
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
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Descripción del daño...',
                    ),
                    minLines: 1,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    controller: description,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 25.h),
          images.length == 0
              ? Container()
              : Container(
                  height: 320.h,
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
          editedImages.length == 0
              ? Container()
              : Container(
                  height: 520.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: editedImages.length,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Image.file(editedImages[index]!),
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
                pickImage(context);
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
          // if (myBytes != null) ...[Image.memory(myBytes!)],
          images.isNotEmpty
              ? RepaintBoundary(
                  key: _widgetKey,
                  child: ImageWithDateOverlay(
                      imageFile: images[0]!, date: DateTime.now().toString()),
                )
              : Container(),

          SizedBox(height: 30.h),
          button("Guardar Pdf", 25.w, screenWidth, () async {
            //thing we have to save the image first then transfor it to file

            final boundury = await _widgetKey.currentContext!.findRenderObject()
                as RenderRepaintBoundary;
            final image = await boundury.toImage();
            final byteData =
                await image.toByteData(format: ImageByteFormat.png);
            final bytes = byteData!.buffer.asUint8List();

            File newFile =
                await writeBytesToFile(bytes, await generateImageFilename());

            setState(() {
              editedImages.add(newFile);
            });

            print("BYTESSS $bytes");

            final pdfFile = await PdfApi.createPdf(
                editedImages,
                generateAdminReport(
                    mainMachine, description.text, _turn!, _operator!));
            showPrintedMessage("Éxito", "Documento Guardado");
            PdfApi.openFile(pdfFile);
            saveAdminReport(mainAdminReport);
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

  Future searchMachine(TextEditingController machineCode) async {
    final url = Uri.parse(
        'https://tannyapp.fly.dev/api/machines/${machineCode.text.toUpperCase()}');

    final machine = await http.get(url);

    if (machine.statusCode == 200) {
      final machineJson = jsonDecode(machine.body);

      List<Operator> operators = [];
      for (var operator in machineJson['operators']) {
        Operator newOperator = Operator(
            id: operator['id'],
            name: operator['name'],
            lastname: operator['lastname'],
            dni: operator['dni'],
            responsability: operator['responsability'],
            machineId: operator['machineId']);
        operators.add(newOperator);
      }

      Machine newMachine = Machine(
          id: machineJson['id'],
          code: machineJson['code'],
          licensePlate: machineJson['licensePlate'],
          description: machineJson['description'],
          observation: machineJson['observation'],
          brand: machineJson['brand'],
          registeredDate: machineJson['registeredDate'],
          operators: operators);

      setState(() {
        mainMachine = newMachine;
      });
    } else {
      print(machine.statusCode);
    }
  }

  String currentDate() {
    var now = DateTime.now();
    var formatter = DateFormat("yyyy-MM-dd");
    return formatter.format(now);
  }

  AdminReport generateAdminReport(
      Machine machine, String description, int turn, int operatorNumb) {
    String myTurn = turn == 1 ? 'DAY' : 'NIGHT';
    //the option select is invert
    Operator operator =
        operatorNumb == 1 ? machine.operators[1] : machine.operators[0];
    AdminReport adminReport = AdminReport(
        id: 0,
        description: description,
        date: currentDate(),
        turn: myTurn,
        operator: operator,
        machine: machine);

    setState(() {
      mainAdminReport = adminReport;
    });
    return adminReport;
  }
}

Future saveAdminReport(AdminReport mainAdminReport) async {
  final Url = Uri.parse('https://tannyapp.fly.dev/api/admin-reports');
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode(mainAdminReport.toJson());
  final response = await http.post(Url, headers: headers, body: body);
}
