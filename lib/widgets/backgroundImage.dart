import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final child;

  const BackgroundImage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/background.png"),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter
        ),
      ),
      child: child,
    );
  }
}
