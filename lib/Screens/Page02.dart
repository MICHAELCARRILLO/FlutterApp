import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanny_app/Screens/Page03.dart';
import '../Custom_Widgets/custom_widgets.dart';
import 'package:http/http.dart' as http;

class Page02 extends StatefulWidget {
  const Page02({super.key});

  @override
  State<Page02> createState() => _Page02State();
}

class _Page02State extends State<Page02> {
  Future logIn(TextEditingController username, TextEditingController password,
      BuildContext context) async {
    final url = Uri.parse(
        "https://tannyapp.fly.dev/api/admins/${username.text}/${password.text}");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Page03()));
    } else if (response.statusCode == 404) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario o contraseña incorrectos')));
    } else {
      throw Exception('Failed to get admin.');
    }
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: customAppBar(),
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: ListView(
        children: [
          customImageBar(190.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 49.w),
            child: const Text("Bienvenido!",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
                textAlign: TextAlign.center),
          ),
          SizedBox(height: 17.h),
          SizedBox(
              width: 210.w,
              height: 210.h,
              child: const Image(image: AssetImage("images/image02.png"))),
          SizedBox(height: 45.h),
          userInput("Usuario", false, username),
          SizedBox(height: 20.h),
          userInput("Contraseña", true, password),
          SizedBox(height: 35.h),
          button("Iniciar Sesión", 23.w, screenWidth,
              () => logIn(username, password, context)),
        ],
      ),
    );
  }
}
