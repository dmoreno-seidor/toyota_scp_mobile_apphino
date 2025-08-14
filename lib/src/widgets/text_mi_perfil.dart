import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class TextMiPerfil extends StatefulWidget {
  final String labelTextTitulo;
  final String labelTextValue;

  TextMiPerfil({
    Key key,
    @required this.labelTextTitulo,
    @required this.labelTextValue,
  }) : super(key: key);

  @override
  _TextMiPerfil createState() => _TextMiPerfil();
}

class _TextMiPerfil extends State<TextMiPerfil> {
  
  @override
  Widget build(BuildContext context) {
    final _responsive = Responsive(context);

    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
        left: 16, right: 16, top: 8),
        height: _responsive.ip(8),//52,
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFDADADC),
            ),
            borderRadius: BorderRadius.circular(3.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.labelTextTitulo,
              style: TextStyle(
                fontFamily: "HelveticaNeue",
                fontSize: _responsive.ip(1.65),//11.0,
                color: Color(0xFF94949A),
              ),
            ),
            // SizedBox(
            //   height: 2.0,
            // ),
            Container(height: _responsive.ip(0.3),),
            Text(
              (widget.labelTextValue),
              style: TextStyle(
                fontFamily: "HelveticaNeue",
                fontSize: _responsive.ip(2.4),//16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C1C1C)
              ),
              maxLines: 1,
            )
          ],
        )
    );
  }
}
