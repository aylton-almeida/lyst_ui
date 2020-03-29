import 'package:flutter/material.dart';
import 'package:lystui/models/category.model.dart';
import 'package:lystui/models/screenRoute.model.dart';
import 'file:///C:/Users/aylto/codigos/aulas/lab4/lyst_ui/lib/widgets/backgroundImage.dart';

class CategoriesScreen extends ScreenRoute {
  CategoriesScreen() : super('/');

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
        final categoriesList = <Category>[
        new Category()
        ];

        @override
        Widget build(BuildContext context) {
        return BackgroundImage(
        child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
        title: Image.asset(
        'lib/assets/logo.png',
        width: 100,
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF848484).withOpacity(0.1),
        ),
        body: Center(
          child: Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
