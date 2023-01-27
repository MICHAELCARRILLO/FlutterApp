import 'package:flutter/material.dart';
import 'package:tanny_app/Screens/Page01.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData customTheme() {
    return ThemeData(
        primarySwatch: MaterialColor(0xFF2F48A7, <int, Color>{
      50: Color.fromRGBO(47, 72, 167, .1),
      100: Color.fromRGBO(47, 72, 167, .2),
      200: Color.fromRGBO(47, 72, 167, .3),
      300: Color.fromRGBO(47, 72, 167, .4),
      400: Color.fromRGBO(47, 72, 167, .5),
      500: Color.fromRGBO(47, 72, 167, .6),
      600: Color.fromRGBO(47, 72, 167, .7),
      700: Color.fromRGBO(47, 72, 167, .8),
      800: Color.fromRGBO(47, 72, 167, .9),
      900: Color.fromRGBO(47, 72, 167, 1),
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: "Tanny App",
        home: Page01(),
        theme: customTheme(),
      ),
      designSize: const Size(390, 845),
    );
  }
}
