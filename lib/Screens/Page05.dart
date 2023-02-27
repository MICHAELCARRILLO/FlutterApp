import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tanny_app/Custom_Widgets/ImageWithDateOverlay%20.dart';
import 'package:tanny_app/Custom_Widgets/custom_widgets.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:tanny_app/Models/Admin.dart';
import 'package:tanny_app/Models/AdminReport.dart';
import 'package:tanny_app/Models/Machine.dart';
import 'package:tanny_app/Models/Operator.dart';
import 'package:tanny_app/Screens/provider.dart';
import '../Custom_Widgets/pdf_api.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:screenshot/screenshot.dart';
import 'package:flutter/rendering.dart';
import 'package:stamp_image/stamp_image.dart';

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<Uint8List> getAsset(String assetPath) async {
  ByteData data = await rootBundle.load(assetPath);
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

Future<File> addTextToImage(File imageFile, String text) async {
  img.Image? image = img.decodeImage(await imageFile.readAsBytes());
  var myFont =
      img.BitmapFont.fromZip(await getAsset("assets/fonts/Exo-Regular.zip"));

  img.drawString(image!, text,
      font: myFont, x: image.width - 1400, y: image.height - 300);
  Uint8List modifiedImageBytes = img.encodeJpg(image);
  DateTime now = DateTime.now();
  int millisecondsSinceEpoch = now.millisecondsSinceEpoch;

  File modifiedImageFile =
      File('${imageFile.path}_$millisecondsSinceEpoch.jpg');
  await modifiedImageFile.writeAsBytes(modifiedImageBytes);
  return modifiedImageFile;
}

String getDate() {
  var now = new DateTime.now();
  var formatter = new DateFormat('dd.MMMM.yyyy hh:mm:ss', 'es_ES');
  String formattedDate = formatter.format(now);
  return formattedDate;
}

Future<File> compressFile(File file) async {
  File compressedFile = await FlutterNativeImage.compressImage(
    file.path,
    quality: 40,
  );
  return compressedFile;
}

Future<void> imageToEditedImage(File image) async {
  final editedFile = await addTextToImage(image, getDate());
  final editedImageCompressed = await compressFile(editedFile);
}

Future<File> editAndCompressImage(File file) async {
  final compresFile = await compressFile(file);
  final editedImage = await addTextToImage(compresFile, getDate());
  return editedImage;
}

Uint8List getmyString(List<dynamic> args) {
  final Uint8List bytes = args[0];
  final img.BitmapFont myFont = args[1];
  final currentDate = args[2];
  img.Image? image = img.decodeImage(bytes);
  img.drawString(image!, currentDate,
      font: myFont, x: image.width - 1400, y: image.height - 300);
  Uint8List modifiedImageBytes = img.encodeJpg(image);
  return modifiedImageBytes;
}

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
  //List<GlobalKey> keysList = [];
  int currentImagesPicked = 0;
  OverlayEntry? entry;

  //screenShot
  ScreenshotController screenshotController = ScreenshotController();

  void showPdfLoadScreen() {
    final overlay = Overlay.of(context)!;

    entry = OverlayEntry(builder: (context) => buildPdfLoadScreen());
    overlay.insert(entry!);
  }

  void hidePdfLoadScreen() {
    entry?.remove();
    entry = null;
  }

  Widget buildPdfLoadScreen() {
    return Material(
      child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Generando PDF...",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 23, 67, 164),
                      fontFamily: 'Atmospheric')),
              SizedBox(height: 50),
              InkWell(
                  onTap: () => {Navigator.pop(context)},
                  child: SpinKitFadingCube(
                      color: Color.fromARGB(255, 25, 83, 209))),
              SizedBox(height: 30),
            ],
          )),
    );
  }

  void incrementsCurrentImagesPicked() {
    setState(() {
      currentImagesPicked++;
    });
  }

  Future<ui.Image> loadImage(File imageFile) async {
    // Read the file as bytes
    List<int> imageBytes = await imageFile.readAsBytes();
    Uint8List bytes = Uint8List.fromList(imageBytes);
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
    final filename = '${formatter.format(now)}_$milliseconds.jpg';
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/$filename';
    return path;
  }

  //metoh to generate current date yyyy-MM-dd

  Widget currDate() {
    return Text(
      getDate(),
      style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontSize: 17.sp,
          fontWeight: FontWeight.w700),
    );
  }

  void resultStamp(File file) {
    setState(() {
      editedImages.add(file);
    });
  }

  Future<void> imagesToEditedImages() async {
    if (images.isEmpty) return;

    List<File?> newImages = [];

    for (var element in images) {
      final editedFile = await addTextToImage(element!, getDate());
      final editedImageCompressed = await compressFile(editedFile);
      newImages.add(editedImageCompressed);
    }

    if (newImages.isNotEmpty) {
      setState(() {
        editedImages = newImages;
      });
    }
  }

  void ckeckValidPdfAndImages() async {
    showPdfLoadScreen();

    while (currentImagesPicked != editedImages.length) {
      await Future.delayed(const Duration(seconds: 1));
    }

    await onPdfButtonPressed().then((value) => {
          hidePdfLoadScreen(),
          showPrintedMessage('Éxito', 'Documento Guardado'),
          PdfApi.openFile(value),
          saveAdminReport(mainAdminReport)
        });
  }

  Future<File> onPdfButtonPressed() async {
    final pdfFile = await PdfApi.createPdf(
      editedImages,
      generateAdminReport(
        mainMachine,
        description.text,
        _turn!,
        _operator!,
      ),
    );

    return pdfFile;
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      var myFont = img.BitmapFont.fromZip(
          await getAsset("assets/fonts/Exo-Regular.zip"));
      final editedImage = await compute<List<dynamic>, Uint8List>(
          getmyString, [imageTemporary.readAsBytesSync(), myFont, getDate()]);

      final newEditedImage =
          await writeBytesToFile(editedImage, await generateImageFilename());

      setState(() {
        images.add(imageTemporary);
        editedImages.add(newEditedImage);
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
          SizedBox(
            height: 25.h,
          ),
          InkWell(
            onTap: () async {
              PermissionStatus cameraStatus = await Permission.camera.request();

              if (cameraStatus == PermissionStatus.granted) {
                pickImage();
                incrementsCurrentImagesPicked();
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
          button(
              "Guardar Pdf", 25.w, screenWidth, () => ckeckValidPdfAndImages()),
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
