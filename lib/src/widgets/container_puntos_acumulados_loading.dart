import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class ContainerPuntosAcumuladosLoading extends StatefulWidget {


  ContainerPuntosAcumuladosLoading({
    Key key,
  }) : super(key: key);

  @override
  _ContainerPuntosAcumuladosLoading createState() => _ContainerPuntosAcumuladosLoading();
}

class _ContainerPuntosAcumuladosLoading extends State<ContainerPuntosAcumuladosLoading> {
  
  @override
  Widget build(BuildContext context) {
    final _responsive = Responsive(context);

    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
        left: 24, right: 24, top: _responsive.hp(2)),
        height: 62,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        // margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF96969b),
            ),
            borderRadius: BorderRadius.circular(5.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Container(
                width: 138,
              height: 13,
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
              height: 5.0,
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
