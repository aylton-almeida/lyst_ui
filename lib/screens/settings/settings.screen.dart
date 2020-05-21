import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lystui/models/category.model.dart';
import 'package:lystui/models/fabOptions.model.dart';
import 'package:lystui/models/serviceException.model.dart';
import 'package:lystui/providers/auth.provider.dart';
import 'package:lystui/providers/category.provider.dart';
import 'package:lystui/screens/auth/auth.screen.dart';
import 'package:lystui/providers/fab.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/screens/categories/manageCategories.screen.dart';
import 'package:lystui/utils/alerts.utils.dart';
import 'package:lystui/utils/errorTranslator.utils.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:provider/provider.dart';
import 'package:lystui/utils/string.extension.dart';
import 'package:lystui/screens/settings/settings.screen.i18n.dart';

//TODO: include languge change button

class SettingsScreen extends StatefulWidget {
  static final String routeName = '/';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshCategories();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<FabProvider>(context, listen: false);
      if (provider.fabOptions[TabItem.settings].length == 1)
        provider.addFabOptions(TabItem.settings, FabOptions(isVisible: false));
    });
  }

  @override
  void dispose() {
    refreshKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> refreshCategories() async {
    refreshKey.currentState?.show(atTop: false);

    try {
      await Provider.of<CategoryProvider>(context, listen: false)
          .doUpdateCategories();
    } catch (e) {
      if (e is ServiceException && e.code != 'USER_NOT_CONNECTED')
        Alerts.showSnackBar(
            context: context,
            text: ErrorTranslator.authError(e),
            color: Colors.red);
    }
  }

  void _onManagePress() =>
      Navigator.of(context).pushNamed(ManageCategoriesScreen.routeName);

  //TODO: Implement
  void _onAboutUsTap() {}

  Future<void> _onLogoutTap() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.doSignOutUser();
    Navigator.of(context, rootNavigator: true)
        .pushReplacementNamed(AuthScreen.routeName);
  }

  Widget _buildCategories(List<Category> categories) {
    return RefreshIndicator(
      backgroundColor: Theme.of(context).primaryColor,
      color: Colors.white,
      key: refreshKey,
      onRefresh: refreshCategories,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        itemCount: categories.length,
        itemBuilder: (context, i) => _buildRow(categories[i]),
      ),
    );
  }

  Widget _buildRow(Category category) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: Color(category.color),
            shape: BoxShape.circle,
          ),
        ),
      ),
      title: Text(
        category.title.capitalize(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoryProvider>(context);

    return BackgroundImage(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/logo.png',
            width: 100,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Categories'.i18n,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 320,
                child: Hero(
                  tag: 'categoriesList',
                  child: _buildCategories(categoriesProvider.categories),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: RaisedButton(
                  child: Text(
                    'manage categories'.i18n.toUpperCase(),
                  ),
                  onPressed: _onManagePress,
                ),
              ),
              Divider(
                height: 20,
                indent: 30,
                endIndent: 30,
                color: Theme.of(context).primaryColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      splashColor: Theme.of(context).primaryColor,
                      highlightColor: Theme.of(context).primaryColorLight,
                      onTap: _onAboutUsTap,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'About us'.i18n,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      splashColor: Colors.red,
                      highlightColor: Colors.redAccent,
                      onTap: _onLogoutTap,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Logout'.i18n,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
