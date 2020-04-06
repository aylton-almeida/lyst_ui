import 'package:flutter/material.dart';
import 'package:lystui/models/screenRoute.model.dart';

class Destination {
  const Destination({
    this.title,
    this.icon,
    this.child,
    this.routes,
  }) : this.hasRoutes = routes != null;

  final String title;
  final IconData icon;
  final Widget child;
  final bool hasRoutes;
  final List<ScreenRoute> routes;
}
