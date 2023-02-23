import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart' as material;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:tanny_app/Models/AdminReport.dart';
import 'package:tanny_app/Models/Machine.dart';

class User {
  final String name;
  final int age;

  const User({required this.name, required this.age});
}

class PdfApi {
  static Container customRow(String first, String second) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: PdfColor.fromHex("#000000")),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: PdfColor.fromHex("#000000")),
              ),
              child: Padding(
                  child: Text(first,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.left),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: PdfColor.fromHex("#000000")),
              ),
              child: Padding(
                  child: Text(second,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center),
                  padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
          ),
        ],
      ),
    );
  }

  static Container customRowTitle(String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: PdfColor.fromHex("#000000")),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: PdfColor.fromHex("#000000")),
              ),
              child: Padding(
                  child: Text(title,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  padding: EdgeInsets.symmetric(vertical: 15)),
            ),
          ),
        ],
      ),
    );
  }

  static Padding customImagePadding(final img) {
    return Padding(
        padding: EdgeInsets.only(right: 8),
        child: Container(
            width: 250,
            height: 350,
            child: Expanded(child: Image(img, fit: BoxFit.fitWidth))));
  }

  static Future<File> createPdf(
      List<File?> files, AdminReport adminReport) async {
    final pdf = Document();

    pdf.addPage(Page(
      build: ((context) => Container(
            child: Column(
              children: [
                customRowTitle("INFORMACION DEL OPERADOR"),
                customRow("NOMBRE :", adminReport.operator.name),
                customRow("APELLIDOS :", adminReport.operator.lastname),
                customRow("DNI :", adminReport.operator.dni),
                customRow("CARGO :", adminReport.operator.responsability),
                customRowTitle("INFORMACION DE DAÑO MATERIAL Y/O OPEACIONAL"),
                customRow("CODIGO DEL EQUIPO: :", adminReport.machine.code),
                customRow("PLACA :", adminReport.machine.licensePlate),
                customRow("EQUIPO :", adminReport.machine.description),
                customRow("MARCA :", adminReport.machine.brand),
                customRow("DESCRIPCION DEL DAÑO OCASIONADO :",
                    adminReport.description),
                customRow("FECHA :", adminReport.date),
                customRowTitle("FOTOS TOMADAS"),
              ],
            ),
          )),
    ));

    //adding Images
    for (var i = 0; i < files.length; i += 4) {
      final image1 =
          files[i] != null ? MemoryImage(files[i]!.readAsBytesSync()) : null;
      final image2 = files.length > i + 1
          ? MemoryImage(files[i + 1]!.readAsBytesSync())
          : null;
      final image3 = files.length > i + 2
          ? MemoryImage(files[i + 2]!.readAsBytesSync())
          : null;
      final image4 = files.length > i + 3
          ? MemoryImage(files[i + 3]!.readAsBytesSync())
          : null;

      if (files.length == 1) {
        pdf.addPage(Page(build: (context) => Center(child: Image(image1!))));
      } else {
        pdf.addPage(Page(
            build: (context) => Column(children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (image1 != null) customImagePadding(image1),
                        if (image2 != null) customImagePadding(image2),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (image3 != null) customImagePadding(image3),
                        if (image4 != null) customImagePadding(image4),
                      ],
                    ),
                  ),
                ])));
      }
    }

    return saveDocument(name: "newsoc1.pdf", pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFilex.open(url);
  }
}
