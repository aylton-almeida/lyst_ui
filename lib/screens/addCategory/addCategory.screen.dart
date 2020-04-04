import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lystui/models/fabOptions.model.dart';
import 'package:lystui/providers/fab.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:lystui/widgets/privateRoute.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatefulWidget {
  static final String routeName = '/addcategory';

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<FabProvider>(context, listen: false);
      provider.addFabOptions(
          TabItem.settings,
          FabOptions(
            icon: Icons.done,
            isVisible: true,
            onPress: _onFabPress,
          ));
    });
  }

  void _onBackPressed() {
    final fabProvider = Provider.of<FabProvider>(context, listen: false);
    fabProvider.removeFabOptions(TabItem.settings);
    Navigator.pop(context);
  }

  //TODO: Implement
  void _onFabPress() {
    print('add');
  }

  @override
  Widget build(BuildContext context) {
    return PrivateRoute(
      child: BackgroundImage(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _onBackPressed,
            ),
            title: Text('Add category'),
          ),
        ),
      ),
    );
  }
}
