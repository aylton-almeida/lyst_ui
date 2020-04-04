import 'package:flutter/material.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/screens/categories/categories.screen.dart';
import 'package:lystui/screens/manageCategories/manageCategories.dart';
import 'package:lystui/screens/settings/settings.screen.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem, this.setFabOptions});

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;
  final Function setFabOptions;

  //Declare subRoutes
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    if (this.tabItem == TabItem.categories)
      return {
        CategoriesScreen.routeName: (context) => CategoriesScreen(
              setFabOptions: setFabOptions,
            ),
      };
    else
      return {
        SettingsScreen.routeName: (context) => SettingsScreen(),
        ManageCategories.routeName: (context) => ManageCategories(
              setFabOptions: setFabOptions,
            ),
      };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);

    return Navigator(
        key: navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              builder: (context) => routeBuilders[settings.name](context));
        });
  }
}
