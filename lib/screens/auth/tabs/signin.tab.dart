import 'package:flutter/material.dart';
import 'package:lystui/providers/auth.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/utils/alerts.utils.dart';
import 'package:lystui/utils/errorTranslator.utils.dart';
import 'package:lystui/utils/keyboard.utils.dart';
import 'package:lystui/utils/validators.utils.dart';
import 'package:lystui/widgets/personalizedTextField.dart';
import 'package:provider/provider.dart';
import '../auth.i18n.dart';

class SignInTab extends StatefulWidget {
  @override
  _SignInTabState createState() => _SignInTabState();
}

class _SignInTabState extends State<SignInTab> {
  bool _isLoading = false;
  bool _isObscure = true;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onObscurePassPress() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _onConnectPress() async {
    dismissKeyboard(context);
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      try {
        await authProvider.doSignInUser(
            _emailController.text, _passwordController.text);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppScreen.routeName, (_) => false);
      } catch (e) {
        print(e);
        Alerts.showSnackBar(
            context: context,
            text: ErrorTranslator.authError(e),
            color: Colors.red);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: _isLoading,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  PersonalizedTextField(
                    enabled: !_isLoading,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
                    controller: _emailController,
                    autocorrect: true,
                    validator: Validators.validateEmail,
                    textCapitalization: TextCapitalization.none,
                    hintText: 'Type your email...'.i18n,
                    labelText: 'Email',
                    focusNode: _emailFocusNode,
                    cursorColor: Theme.of(context).primaryColor,
                    showError: true,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 20),
                  PersonalizedTextField(
                    enabled: !_isLoading,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: _onConnectPress,
                    controller: _passwordController,
                    autocorrect: true,
                    validator: Validators.validatePassword,
                    textCapitalization: TextCapitalization.none,
                    hintText: 'Type your password...'.i18n,
                    labelText: 'Password'.i18n,
                    focusNode: _passwordFocusNode,
                    cursorColor: Theme.of(context).primaryColor,
                    showError: true,
                    obscureText: _isObscure,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: _onObscurePassPress,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 40,
                    width: _isLoading ? 80 : 320,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0)),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      child: _isLoading
                          ? Transform.scale(
                              scale: 1 / 2,
                              child: CircularProgressIndicator(
                                  backgroundColor: Colors.white))
                          : Text('connect'.i18n.toUpperCase()),
                      onPressed: _onConnectPress,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
