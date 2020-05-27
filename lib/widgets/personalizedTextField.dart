import 'package:flutter/material.dart';

class PersonalizedTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final Function validator;
  final TextEditingController controller;
  final bool autocorrect;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final Function onChanged;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Function onEditingComplete;
  final bool enabled;
  final double fontSize;
  final Color focusedColor;
  final Color errorColor;
  final Color borderColor;
  final Color enabledColor;
  final Color disabledColor;
  final Color cursorColor;
  final bool showError;
  final bool showBorder;
  final int maxLines;

  PersonalizedTextField({
    Key key,
    this.errorColor,
    this.borderColor,
    this.enabledColor,
    this.disabledColor,
    this.hintText,
    this.labelText,
    this.validator,
    @required this.controller,
    this.autocorrect,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText,
    this.textCapitalization,
    this.onChanged,
    this.textInputAction,
    @required this.focusNode,
    this.onEditingComplete,
    this.enabled,
    this.fontSize,
    this.focusedColor,
    this.cursorColor,
    @required this.maxLines,
    bool showBorder,
    bool showError,
  })  : this.showError = showError ?? true,
        this.showBorder = showBorder ?? true,
        super(key: key);

  _PersonalizedTextFieldState createState() => _PersonalizedTextFieldState();
}

class _PersonalizedTextFieldState extends State<PersonalizedTextField> {
  FocusNode focusNode = FocusNode();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Theme.of(context).accentColor,
        accentColor: Theme.of(context).primaryColor,
      ),
      child: TextFormField(
        style: TextStyle(fontSize: widget.fontSize, color: Colors.white),
        enabled: widget.enabled,
        focusNode: focusNode,
        onEditingComplete: widget.onEditingComplete,
        textInputAction: widget.textInputAction,
        controller: widget.controller,
        autocorrect: widget.autocorrect ?? true,
        validator: widget.validator,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          border: widget.showBorder ? null : InputBorder.none,
          enabledBorder: widget.showBorder
              ? UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    style: BorderStyle.solid,
                  ),
                )
              : InputBorder.none,
          errorStyle: widget.showError ? null : TextStyle(fontSize: 0),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.8),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color:
                widget.focusNode.hasFocus ? widget.focusedColor : Colors.white,
          ),
          suffixIcon: widget.suffixIcon,
        ),
        keyboardType: widget.keyboardType ?? TextInputType.text,
        obscureText: widget.obscureText ?? false,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.sentences,
        onChanged: widget.onChanged,
        cursorColor: widget.cursorColor ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
