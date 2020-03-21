import 'package:flutter/material.dart';
import 'package:lystui/models/destination.model.dart';
import 'package:lystui/models/screenRoute.model.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return widget.destination.hasRoutes
        ? Navigator(onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(
          settings: settings,
          builder: (context) =>
              widget.destination.routes
                  .firstWhere((ScreenRoute route) =>
              route.routeName == settings.name));
    })
        : widget.destination.child;
  }
}
