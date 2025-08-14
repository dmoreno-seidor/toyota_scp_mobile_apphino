import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class ContainerMisPuntos extends StatefulWidget {
  final List aPuntosAcumualados;

  const ContainerMisPuntos({Key key, @required this.aPuntosAcumualados}) : super(key: key); 

 

  @override
  _ContainerMisPuntos createState() => _ContainerMisPuntos();
}

class _ContainerMisPuntos extends State<ContainerMisPuntos> {
  @override

  Widget build(BuildContext context) {
    return  ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: _buildPuntosAcumuladosList,
                  itemCount: widget.aPuntosAcumualados.length,
                  shrinkWrap: true,

                );

    
  }




  Widget _buildPuntosAcumuladosList(
    BuildContext context,
    int index,
  ) {
    final _responsive = Responsive(context);
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: _responsive.wp(88),
          // height: _responsive.hp(14),
          height: 95,

          margin: EdgeInsets.only(left: 10, right: 10, top: _responsive.hp(2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text( widget.aPuntosAcumualados[index],//19,
                              style: TextStyle(
                                  fontFamily: 'HelveticaNeue',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0,
                                  color: Color(0xFF000000))),
                          Text(
                            widget.aPuntosAcumualados[index],//DIC
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: Color(0xFFE60012)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                      width: 1,
                      height: double.maxFinite,
                      color: Color(0xFFDADADC)),
                ],
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Concesionario',
                        style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: Color(0xFF94949A))),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(widget.aPuntosAcumualados[index],
                        style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Color(0xFF000000)))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 70.0, right: 10.0),
                height: 28,
                width: 98,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xFFFFD34D)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                     widget.aPuntosAcumualados[index], // 100Puntos
                      style: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C1C1C)),
                    ),
                  ],
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [AppConfig.boxShadow],
          ),
        ),
      ],
    ));
  }
}
