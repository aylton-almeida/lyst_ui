import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  final child;

  const BackgroundImageWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
