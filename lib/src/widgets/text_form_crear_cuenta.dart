import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class TextFormCrearCuenta extends StatefulWidget {
  final String initialValue;
  final InputBorder border;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final Function(String) validator;
  final Function(String) onSaved;
  final Function(String) onChange;

  final List<TextInputFormatter> inputFormatters;

  const TextFormCrearCuenta(
      {Key key,
      this.initialValue,
      this.border,
      this.keyboardType,
      this.suffixIcon,
      this.hintText,
      this.labelText,
      this.obscureText = false,
      this.validator,
      this.inputFormatters,
      this.onSaved,
      this.onChange})
      : super(key: key);

  @override
  _TextFormCrearCuenta createState() => _TextFormCrearCuenta();
}

class _TextFormCrearCuenta extends State<TextFormCrearCuenta> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Container(
      child: TextFormField(
        initialValue: widget.initialValue,
        obscureText: widget.obscureText,
        textCapitalization: TextCapitalization.sentences,
        textAlign: TextAlign.start,
        onSaved: widget.onSaved,
        inputFormatters: widget.inputFormatters,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: new EdgeInsets.symmetric(
              vertical: responsive.ip(2.5), horizontal: 10.0),
          hintStyle: TextStyle(
              fontSize: responsive.ip(2.1),
              fontFamily: "HelveticaNeue",
              fontWeight: FontWeight.w500,
              color: Color(0xFF94949A)),
          labelStyle: TextStyle(
              fontSize: responsive.ip(2.2),
              fontFamily: "HelveticaNeue",
              fontWeight: FontWeight.w500,
              color: Color(0xFF94949A)),
          border: widget.border,
          hintText: widget.hintText,
          labelText: widget.labelText,
          suffixIcon: widget.suffixIcon,
        ),
        validator: widget.validator,
        onChanged: widget.onChange,
      ),
    );
  }
}
