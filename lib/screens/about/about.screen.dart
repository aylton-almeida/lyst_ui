import 'package:flutter/material.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:lystui/widgets/privateRoute.dart';


class AboutScreen extends StatefulWidget {
  static final String routeName = '/about';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  @override
  Widget build(BuildContext context) {

    return PrivateRoute(
      child: BackgroundImage(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
            ),
            title: Text('Manage Categories'),
          ),
          body: Hero(
            tag: 'categoriesList',
          ),
        ),
      ),
    );
  }
}
