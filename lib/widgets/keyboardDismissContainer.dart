import 'package:flutter/cupertino.dart';
import 'package:lystui/utils/keyboard.utils.dart';

class KeyboardDismissContainer extends StatelessWidget {
  final Widget child;

  KeyboardDismissContainer({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: child,
    );
  }
}
