import 'package:flutter/material.dart';
import 'package:lystui/models/fabOptions.model.dart';
import 'package:lystui/screens/app/app.screen.dart';

class FabProvider with ChangeNotifier {
  //Add here initial BottomNavigationRoutes
  Map<TabItem, List<FabOptions>> fabOptions = {
    TabItem.categories: [FabOptions(isVisible: false)],
    TabItem.settings: [FabOptions(isVisible: false)],
  };

  void addFabOptions(TabItem tabItem, FabOptions options) {
    this.fabOptions[tabItem].add(options);
    notifyListeners();
  }

  void removeFabOptions(TabItem tabItem) {
    if (this.fabOptions[tabItem].length > 2) {
      this.fabOptions[tabItem].removeLast();
      notifyListeners();
    }
  }
}
