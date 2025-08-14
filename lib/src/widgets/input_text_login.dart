import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class InputTextLogin extends StatefulWidget {
  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final String counterText;
  final String errorText;
  final bool obscureText;
  final Widget suffixIcon;
  final Function(String) onChanged;
  final BuildContext context;

  InputTextLogin(
      {Key key,
      this.keyboardType = TextInputType.text,
      this.hintText,
      @required this.labelText,
      this.counterText,
      this.errorText,
      this.obscureText = false,
      this.suffixIcon,
      @required this.onChanged,
      this.context})
      : super(key: key);

  @override
  _InputTextLoginState createState() => _InputTextLoginState();
}

class _InputTextLoginState extends State<InputTextLogin> {
  @override
  Widget build(BuildContext context) {
    Responsive _responsive = new Responsive(context);
    return TextField(
      // style: AppConfig.loginInputText,
      style: TextStyle(
          fontSize: _responsive.ip(2.1),
          fontFamily: "HelveticaNeue",
          color: Colors.white),
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
          hintStyle: TextStyle(
              fontSize: _responsive.ip(2.1),
              fontFamily: "HelveticaNeue",
              color: Colors.white),

          // AppConfig.loginInputText,
          labelStyle: TextStyle(
              fontSize: _responsive.ip(2.2),
              fontFamily: "HelveticaNeue",
              color: Colors.white),
          // AppConfig.loginInputText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: widget.hintText,
          labelText: widget.labelText,
          // counterText: widget.counterText,
          suffixIcon: widget.suffixIcon,
          errorText: widget.errorText),
      onChanged: widget.onChanged,
    );
  }
}
