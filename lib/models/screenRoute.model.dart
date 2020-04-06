import 'package:flutter/cupertino.dart';

// Class declares to create routes for bottom navigation destinations
abstract class ScreenRoute extends StatefulWidget{
  final String routeName;

  ScreenRoute(this.routeName);
}
