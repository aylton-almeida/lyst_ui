import 'package:flutter/material.dart';
import 'package:lystui/models/screenRoute.model.dart';
import 'package:lystui/widgets/backgroundImage.dart';

class CategoriesScreen extends ScreenRoute {
  CategoriesScreen() : super('/');

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Lyst"),
          backgroundColor: Color(0xFF848484).withOpacity(0.1),
        ),
        body: Center(
          child: Text('Home', style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
