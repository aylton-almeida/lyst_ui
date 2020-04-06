import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lystui/providers/auth.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/screens/signin/signin.screen.dart';
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
            ? Navigator.pushReplacementNamed(context, AppScreen.routeName)
            : Navigator.pushReplacementNamed(context, SignInScreen.routeName))
        .catchError((e) {
      print(e);
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
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
            'lib/assets/logo.png',
            width: 200,
          ),
          baseColor: Color(0xFFE8E3E3),
          highlightColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
