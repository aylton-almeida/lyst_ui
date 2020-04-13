import 'package:flutter/material.dart';
import 'package:lystui/utils/keyboard.utils.dart';
import 'package:lystui/utils/validators.utils.dart';
import 'package:lystui/widgets/personalizedTextField.dart';

class SignUpTab extends StatefulWidget {
  @override
  _SignUpTabState createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> {

  bool _isLoading = false;
  bool _isObscure = true;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();

  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onObscurePassPress() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _onConnectPress() {
    dismissKeyboard(context);
    if (_formKey.currentState.validate()) {
      //TODO: Implement
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 30 ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              PersonalizedTextField(
                enabled: !_isLoading,
                textInputAction: TextInputAction.next,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_emailFocusNode),
                controller: _nameController,
                validator: Validators.require,
                textCapitalization: TextCapitalization.none,
                hintText: 'Type your name...',
                labelText: 'Name',
                focusNode: _nameFocusNode,
                cursorColor: Theme.of(context).primaryColor,
                showError: true,
              ),
              const SizedBox(height: 20),
              PersonalizedTextField(
                enabled: !_isLoading,
                textInputAction: TextInputAction.next,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_passwordFocusNode),
                controller: _emailController,
                autocorrect: true,
                validator: Validators.validateEmail,
                textCapitalization: TextCapitalization.none,
                hintText: 'Type your email...',
                labelText: 'Email',
                focusNode: _emailFocusNode,
                cursorColor: Theme.of(context).primaryColor,
                showError: true,
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
                hintText: 'Type your password...',
                labelText: 'Password',
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
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                width: 320,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0)),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  child: Text('SING UP'),
                  onPressed: _onConnectPress,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
