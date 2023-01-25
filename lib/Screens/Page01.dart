import 'package:flutter/material.dart';

class Page01 extends StatelessWidget {
  const Page01({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Design your TODOs",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
            const SizedBox(height: 35),
            button("Administrador", 15.0, screenWidth),
            const SizedBox(height: 15),
            button("Trabajador", 15.0, screenWidth),
          ],
        )),
      ),
    );
  }
}

Widget button(String text, double horizontalPadding, final screenWidth) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
    child: SizedBox(
      width: screenWidth,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(47, 72, 167, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onPressed: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(text,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
          )),
    ),
  );
}
