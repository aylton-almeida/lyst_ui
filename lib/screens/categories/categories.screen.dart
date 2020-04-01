import 'package:flutter/material.dart';
import 'package:lystui/models/category.model.dart';
import 'package:lystui/models/screenRoute.model.dart';
import 'package:lystui/providers/category.provider.dart';
import 'file:///C:/Users/aylto/codigos/aulas/lab4/lyst_ui/lib/widgets/backgroundImage.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends ScreenRoute {
  CategoriesScreen() : super('/');

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshCategories();
  }

  @override
  void dispose() {
    refreshKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> refreshCategories() async {
    refreshKey.currentState?.show(atTop: false);

    await Provider.of<CategoryProvider>(context, listen: false)
        .doUpdateCategories();
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
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider(color: Colors.transparent);

          final index = i ~/ 2;
          return _buildRow(categories[index]);
        },
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
        category.title,
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Image.asset(
            'lib/assets/logo.png',
            width: 100,
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF848484).withOpacity(0.1),
        ),
        body: _buildCategories(categoriesProvider.categories),
      ),
    );
  }
}
