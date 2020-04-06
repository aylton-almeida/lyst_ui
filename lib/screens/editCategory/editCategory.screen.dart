import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lystui/models/category.model.dart';
import 'package:lystui/models/fabOptions.model.dart';
import 'package:lystui/models/serviceException.model.dart';
import 'package:lystui/providers/category.provider.dart';
import 'package:lystui/providers/fab.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/utils/alerts.utils.dart';
import 'package:lystui/utils/errorTranslator.utils.dart';
import 'package:lystui/utils/validators.utils.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:lystui/widgets/keyboardDismissContainer.dart';
import 'package:lystui/widgets/personalizedTextField.dart';
import 'package:lystui/widgets/privateRoute.dart';
import 'package:provider/provider.dart';

const categoryColors = <Color>[
  Color(0xFFF44336),
  Color(0xFFF06292),
  Color(0xFFBA68C8),
  Color(0xFF9575CD),
  Color(0xFF4DD0E1),
  Color(0xFF4DB6AC),
  Color(0xFFDCE775),
  Color(0xFFFFD54F),
  Color(0xFFFFB74D),
  Color(0xFFFF8A65),
  Color(0xFFE0E0E0),
  Color(0xFF90A4AE),
];

class EditCategoryScreen extends StatefulWidget {
  static final String routeName = '/editcategory';

  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final _controllerName = TextEditingController();
  FocusNode _nameFocusNode;

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Color _selectedColor = categoryColors.first;

  int _categoryId;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _nameFocusNode.addListener(() => setState(() {}));
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

  @override
  void didChangeDependencies() {
    final Category categoryArgs = ModalRoute.of(context).settings.arguments;
    if (categoryArgs != null) {
      _controllerName.text = categoryArgs.title;
      setState(() {
        _selectedColor = categoryColors
            .firstWhere((color) => color.value == categoryArgs.color);
        _categoryId = categoryArgs.id;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _controllerName.dispose();
    super.dispose();
  }

  void _onBackPressed() {
    final fabProvider = Provider.of<FabProvider>(context, listen: false);
    fabProvider.removeFabOptions(TabItem.settings);
    Navigator.pop(context);
  }

  void _onClearPress(int id) {
    //TODO: implement
  }

  void _onDeletePress(int id) async {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    try {
      await categoryProvider.doDeleteCategory(id);
      _onBackPressed();
    } catch (e) {
      print(e);
      if (e is ServiceException && e.code != 'USER_NOT_CONNECTED')
        Alerts.showSnackBar(
            context: context,
            text: ErrorTranslator.categoryError(e),
            color: Colors.red);
      else
        Alerts.showSnackBar(
            context: context,
            text: 'An error happened, please try again later',
            color: Colors.red);
    }
  }

  void _onColorPressed(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  void _onFabPress() async {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    if (_formKey.currentState.validate()) {
      String msg;
      try {
        if (_categoryId == null) {
          await categoryProvider.doCreateCategory(
              _controllerName.text, _selectedColor.value);
          msg = 'Category created with success!';
        } else {
          await categoryProvider.doUpdateCategory(
              _categoryId, _controllerName.text, _selectedColor.value);
          msg = 'Category updated with success!';
        }
        Alerts.showSnackBar(context: context, text: msg, color: Colors.green);
        _onBackPressed();
      } catch (e) {
        print(e);
        if (e is ServiceException && e.code != 'USER_NOT_CONNECTED')
          Alerts.showSnackBar(
              context: context,
              text: ErrorTranslator.categoryError(e),
              color: Colors.red);
        else
          Alerts.showSnackBar(
              context: context,
              text: 'An error happened, please try again later',
              color: Colors.red);
      }
    } else
      Alerts.showSnackBar(
        context: context,
        text: 'Type a title for the category',
        color: Colors.red,
      );
  }

  @override
  Widget build(BuildContext context) {
    final Category categoryArgs = ModalRoute.of(context).settings.arguments;

    return PrivateRoute(
      child: KeyboardDismissContainer(
        child: BackgroundImage(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: _onBackPressed,
              ),
              title: Form(
                key: _formKey,
                child: PersonalizedTextField(
                  enabled: !_isLoading,
                  textInputAction: TextInputAction.done,
                  controller: _controllerName,
                  autocorrect: false,
                  validator: Validators.require,
                  textCapitalization: TextCapitalization.words,
                  focusNode: _nameFocusNode,
                  hintText: 'Category title...',
                  cursorColor: Theme.of(context).primaryColor,
                  showError: false,
                ),
              ),
            ),
            body: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin:
                    EdgeInsets.only(top: 20, bottom: 40, left: 10, right: 10),
                padding: EdgeInsets.all(20),
                width: double.infinity,
                color: Color(0xFF28262C).withOpacity(0.5),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Colors',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.horizontal,
                        spacing: 35,
                        runSpacing: 15,
                        children: categoryColors
                            .map((color) => InkWell(
                                  customBorder: CircleBorder(),
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                      border: _selectedColor == color
                                          ? Border.all(
                                              color: Colors.white,
                                              width: 3,
                                            )
                                          : null,
                                    ),
                                  ),
                                  onTap: () => _onColorPressed(color),
                                ))
                            .toList(),
                      ),
                      if (categoryArgs != null)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(height: 30),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Danger Zone',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 250,
                              child: OutlineButton(
                                onPressed: () => _onClearPress(categoryArgs.id),
                                textColor: Colors.white,
                                highlightedBorderColor: Colors.red,
                                splashColor: Colors.redAccent,
                                child: Text('CLEAR CATEGORY'),
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 2),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 250,
                              child: OutlineButton(
                                onPressed: () =>
                                    _onDeletePress(categoryArgs.id),
                                textColor: Colors.white,
                                highlightedBorderColor: Colors.red,
                                splashColor: Colors.redAccent,
                                child: Text('DELETE CATEGORY'),
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 2),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Be carefull! Deleting a category will delete all its lysts',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
