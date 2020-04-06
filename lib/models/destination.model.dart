import 'package:flutter/material.dart';

class Destination {
  Destination({
    @required this.title,
    @required this.icon,
  }) : this.navigatorKey = GlobalKey<NavigatorState>();

  final String title;
  final IconData icon;
  final GlobalKey<NavigatorState> navigatorKey;
}
