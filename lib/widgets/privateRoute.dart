import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lystui/models/user.model.dart';
import 'package:lystui/providers/auth.provider.dart';
import 'package:lystui/screens/signin/signin.screen.dart';
import 'package:lystui/utils/alerts.utils.dart';
import 'package:lystui/utils/app.dart';
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
          title: "You were disconnected",
          content: "You will be redirected to the Sign In page",
          actions: [
            AlertAction(
                content: "Ok",
                action: () {
                  Application.globalNavigation.currentState.pop();
                  Application.globalNavigation.currentState
                      .pushNamedAndRemoveUntil(SignInScreen.routeName, (route) => false);
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
  Widget build(BuildContext context) {
    _validateUser(context);
    return widget.child;
  }
}
