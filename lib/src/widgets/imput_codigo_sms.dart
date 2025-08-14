import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextCodigo extends StatefulWidget {
  final TextInputType keyboardType;
  final bool autofocus;
  final bool obscureText;
  final TextEditingController controller;
  final String counterText;
  final String errorText;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final InputBorder border;

  InputTextCodigo({
    Key key,
    this.keyboardType = TextInputType.text,
    this.autofocus,
    this.controller,
    this.counterText,
    this.errorText,
    this.focusNode,
    this.obscureText = false,
    this.onChanged,
    this.border,
  }) : super(key: key);

  @override
  _InputTextCodigo createState() => _InputTextCodigo();
}

class _InputTextCodigo extends State<InputTextCodigo> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLength: 1,
      maxLengthEnforced: true,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
      border: widget.border, counterText: "", errorText: widget.errorText),
      onChanged: widget.onChanged,
    );
  }
}
