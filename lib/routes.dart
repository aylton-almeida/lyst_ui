import 'package:flutter/material.dart';
import 'package:lystui/providers/auth.provider.dart';
import 'package:lystui/providers/category.provider.dart';
import 'package:lystui/providers/fab.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/screens/signin/signin.screen.dart';
import 'package:lystui/utils/app.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Routes {
  final isDev;

  //Declare main app routes
  final routes = <String, WidgetBuilder>{
    AppScreen.routeName: (context) => AppScreen(),
    SignInScreen.routeName: (context) => SignInScreen(),
  };

  final appTheme = ThemeData(
    primaryColor: Color(0xFFba0dab),
    primaryColorLight: Color(0xFFD134C4),
    accentColor: Color(0xFFba0dab),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: Color(0xFFba0dab),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  );

  //Add providers here
  final providers = <SingleChildWidget>[
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => CategoryProvider()),
    ChangeNotifierProvider(create: (context) => FabProvider(),)
  ];

  Routes({this.isDev}) {
    runApp(MultiProvider(
      providers: providers,
      child: MaterialApp(
        navigatorKey: Application.globalNavigation,
        debugShowCheckedModeBanner: false,
        title: "Lyst",
        routes: routes,
        initialRoute: AppScreen.routeName,
        theme: appTheme,
      ),
    ));
  }
}
