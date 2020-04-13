import 'package:flutter/material.dart';
import 'package:lystui/screens/allNotes/allNotes.screen.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/screens/categories/categories.screen.dart';
import 'package:lystui/screens/editCategory/editCategory.screen.dart';
import 'package:lystui/screens/manageCategories/manageCategories.screen.dart';
import 'package:lystui/screens/notes/notes.screen.dart';
import 'package:lystui/screens/settings/settings.screen.dart';

class TabNavigator extends StatefulWidget {
  TabNavigator({this.navigatorKey, this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  HeroController _heroController;

  @override
  void initState() {
    super.initState();
    _heroController = HeroController(createRectTween: _createRectTween);
  }

  RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    if (this.widget.tabItem == TabItem.categories)
      return {
        CategoriesScreen.routeName: (context) => CategoriesScreen(),
        NotesScreen.routeName: (context) => NotesScreen(),
        AllNotes.routeName: (context) => AllNotes(),
      };
    else
      return {
        SettingsScreen.routeName: (context) => SettingsScreen(),
        ManageCategoriesScreen.routeName: (context) => ManageCategoriesScreen(),
        EditCategoryScreen.routeName: (context) => EditCategoryScreen(),
      };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);

    return Navigator(
        key: widget.navigatorKey,
        observers: [_heroController],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => routeBuilders[settings.name](context));
        });
  }
}
