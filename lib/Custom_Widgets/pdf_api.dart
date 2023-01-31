import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generateCenteredText(List<File?> files) async {
    final pdf = Document();

    for (var i = 0; i < files.length; i += 2) {
      final image1 =
          files[i] != null ? MemoryImage(files[i]!.readAsBytesSync()) : null;
      final image2 = files.length > i + 1
          ? MemoryImage(files[i + 1]!.readAsBytesSync())
          : null;

      if (files.length == 1) {
        pdf.addPage(Page(build: (context) => Center(child: Image(image1!))));
      } else {
        pdf.addPage(Page(
            build: (context) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (image1 != null) Expanded(child: Image(image1)),
                      if (image2 != null) Expanded(child: Image(image2)),
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

  // static Future openFile(File file) async {
  //   final url = file.path;

  //   await OpenFile.open(url);
  // }
}
