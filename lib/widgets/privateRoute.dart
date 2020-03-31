import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lystui/models/user.model.dart';
import 'package:lystui/providers/auth.provider.dart';
import 'package:lystui/screens/signin/signin.screen.dart';
import 'package:lystui/utils/alerts.utils.dart';
import 'package:provider/provider.dart';


class PrivateRoute extends StatefulWidget {
  final Widget child;

  const PrivateRoute({Key key, this.child}) : super(key: key);

  @override
  _PrivateRouteState createState() => _PrivateRouteState();
}

class _PrivateRouteState extends State<PrivateRoute> {
  void _validateUser(BuildContext context) async {
    User user =
        await Provider.of<AuthProvider>(context, listen: false).currentUser();
    if (user == null) {
      Alerts.showAlertDialog(
          context: context,
          title: "Você foi desconectado",
          content: "Você será redirecionado para a página de login",
          actions: [
            AlertAction(
                content: "Ok",
                action: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(SignInScreen.routeName);
                })
          ]);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance
        .addPostFrameCallback((_) => _validateUser(context));
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
