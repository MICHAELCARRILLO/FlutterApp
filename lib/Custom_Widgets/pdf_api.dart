import 'dart:ffi';
import 'dart:io';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class User {
  final String name;
  final int age;

  const User({required this.name, required this.age});
}

class PdfApi {
  static Future<File> generateCenteredText(List<File?> files) async {
    final pdf = Document();

    //Adding table info

    final headers = ["Users"];
    final users = [
      User(name: "Paul", age: 12),
      User(name: "Roberto", age: 19),
      User(name: "Mario", age: 32),
      User(name: "Palacio", age: 33),
    ];

    final data = users.map((e) => [e.name, e.age]).toList();
    pdf.addPage(Page(
        build: ((context) => Table(
              children: [
                TableRow(children: [
                  Center(child: Text("Im the main title")),
                  Container(),
                ]),
                TableRow(children: [
                  Center(child: Text("Value 1")),
                  Center(child: Text("Value 2")),
                ]),
                TableRow(children: [
                  Center(child: Text("Value 4")),
                  Center(child: Text("Value 5")),
                ]),
              ],
            ))));

    //adding Images
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

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFilex.open(url);
  }
}
