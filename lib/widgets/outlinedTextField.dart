import 'package:flutter/material.dart';

class OutlinedTextField extends StatefulWidget {
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
  final double borderRadius;
  final double fontSize;
  final Color focusedColor;
  final Color errorColor;
  final Color borderColor;
  final Color enabledColor;
  final Color disabledColor;

  OutlinedTextField({
    Key key,
    @required this.focusedColor,
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
    this.focusNode,
    this.onEditingComplete,
    this.enabled,
    @required this.borderRadius,
    this.fontSize,
  }) : super(key: key);

  _OutlinedTextFieldState createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends State<OutlinedTextField> {
  FocusNode focusNode = FocusNode();

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
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(color: widget.focusedColor, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
                color: widget.enabledColor ?? Colors.white, width: 1.0),
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                  color: widget.disabledColor ?? Colors.grey, width: 1.0)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide:
                BorderSide(color: widget.errorColor ?? Colors.red, width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide:
                BorderSide(color: widget.errorColor ?? Colors.red, width: 1.0),
          ),
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
      ),
    );
  }
}
