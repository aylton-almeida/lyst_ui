import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lystui/screens/home/home.screen.dart';

class Routes {

  final routes = <String, WidgetBuilder>{
    HomeScreen.routeName: (context) => HomeScreen(),
  };

  final appTheme = ThemeData(
    primaryColor: Color(0xFFba0dab),
  );

  Routes() {
    runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Lyst",
          routes: routes,
          initialRoute: HomeScreen.routeName,
          theme: appTheme,
        )
    );
  }
}