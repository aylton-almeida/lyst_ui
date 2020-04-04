import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lystui/models/fabOptions.model.dart';
import 'package:lystui/providers/fab.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:lystui/widgets/privateRoute.dart';
import 'package:provider/provider.dart';

class ManageCategories extends StatefulWidget {
  static final String routeName = '/managecategories';
  final Function setFabOptions;

  const ManageCategories({Key key, this.setFabOptions}) : super(key: key);

  @override
  _ManageCategoriesState createState() => _ManageCategoriesState();
}

class _ManageCategoriesState extends State<ManageCategories> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<FabProvider>(context, listen: false);
      provider.addFabOptions(
          TabItem.settings,
          FabOptions(
            icon: Icons.add,
            isVisible: true,
            onPress: () => print('manage'),
          ));
    });
  }

  void _onBackPressed() {
    final fabProvider = Provider.of<FabProvider>(context, listen: false);
    fabProvider.removeFabOptions(TabItem.settings);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PrivateRoute(
      child: BackgroundImage(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _onBackPressed,
            ),
            title: Text('Manage Categories'),
          ),
          body: Center(
            child: Text(
              'Hello World',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
