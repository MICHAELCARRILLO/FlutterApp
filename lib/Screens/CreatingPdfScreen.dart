import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tanny_app/Screens/provider.dart';

class PdfLoadingScreen extends StatefulWidget {
  const PdfLoadingScreen({super.key});

  @override
  State<PdfLoadingScreen> createState() => _PdfLoadingScreenState();
}

class _PdfLoadingScreenState extends State<PdfLoadingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        body: SizedBox(
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
            )));
  }
}
