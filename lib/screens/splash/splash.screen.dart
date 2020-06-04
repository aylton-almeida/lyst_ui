import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lystui/providers/auth.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/screens/auth/auth.screen.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  static final routeName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkIfAuthenticated() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    authProvider
        .currentUser()
        .then((user) => user != null
            ? Navigator.pushNamedAndRemoveUntil(
                context, AppScreen.routeName, (_) => false)
            : Navigator.pushNamedAndRemoveUntil(
                context, AuthScreen.routeName, (_) => false))
        .catchError((e) {
      print(e);
      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (_) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance
        .addPostFrameCallback((_) => checkIfAuthenticated());
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: Center(
        child: Shimmer.fromColors(
          child: Image.asset(
            'assets/images/logo.png',
            width: 200,
          ),
          baseColor: Color(0xFFE8E3E3),
          highlightColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
