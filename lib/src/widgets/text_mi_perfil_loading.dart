import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class TextMiPerfilLoading extends StatefulWidget {


  TextMiPerfilLoading({
    Key key,
  }) : super(key: key);

  @override
  _TextMiPerfilLoading createState() => _TextMiPerfilLoading();
}

class _TextMiPerfilLoading extends State<TextMiPerfilLoading> {
  
  @override
  Widget build(BuildContext context) {
    final _responsive = Responsive(context);

    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
        left: 15, right: 15, top: 9),
        height: _responsive.ip(7.8),//52,
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        // margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFDADADC),
            ),
            borderRadius: BorderRadius.circular(3.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Container(
                width: _responsive.ip(20.7),//138,
              height: _responsive.ip(1.95),//13,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          color: Color(0xffE5E5E5),
                        ),
                      )),
                
            SizedBox(
              height: 2.0,
            ),
            Expanded(
                  child: Container(
                      margin: EdgeInsets.only(
                        top: 3, bottom: 3),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          color: Color(0xffE5E5E5),
                        ),
                      )),
                )
          ],
        )
    );
  }
}
