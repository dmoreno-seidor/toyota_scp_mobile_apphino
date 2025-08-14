import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/formatters.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class ContainerMisPuntos extends StatefulWidget {
  final List aPuntosAcumualados;

  const ContainerMisPuntos({Key key, @required this.aPuntosAcumualados})
      : super(key: key);

  @override
  _ContainerMisPuntos createState() => _ContainerMisPuntos();
}

class _ContainerMisPuntos extends State<ContainerMisPuntos> {
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
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
          height: _responsive.ip(9.6),//64,

          margin: EdgeInsets.only( bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left:4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              
                                widget.aPuntosAcumualados[index]
                                    .sFecApertura==null?
                                    '':


                                formatObtenerDia(widget.aPuntosAcumualados[index]
                                    .sFecApertura)
                                    
                                    
                                    , //widget.textDia,
                                style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: _responsive.ip(2.4),//16.0,
                                    color: Color(0xFF000000))),
                            Text(
                               widget.aPuntosAcumualados[index]
                                    .sFecApertura==null?
                                    '':
                              formatObtenerNombreMes(widget
                                  .aPuntosAcumualados[index]
                                  .sFecApertura), //widget.textMes,
                              style: TextStyle(
                                  fontFamily: 'HelveticaNeue',
                                  fontWeight: FontWeight.bold,
                                  fontSize: _responsive.ip(1.8),//12.0,
                                  color: Color(0xFFE60012)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //     margin: EdgeInsets.only(
                  //         left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                  //     width: 1,
                  //     height: double.maxFinite,
                  //     color: Color(0xFFDADADC)),

                      Container(
                        margin: EdgeInsets.only(left: 1.5),
                                      height: _responsive.ip(5.4),//36,
                                      child: VerticalDivider(
                                        thickness: 1,
                                          
                                    )),

                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Concesionario',
                        style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.w500,
                            fontSize: _responsive.ip(1.8),//12.0,
                            color: Color(0xFF94949A))),
                    // SizedBox(
                    //   height: 2.5,
                    // ),
                    Container(
                      height: _responsive.ip(0.375),
                    ),
                    
                    Text(
                      widget.aPuntosAcumualados[index].sConcesionario
                      ==null
                      ?''
                      :widget.aPuntosAcumualados[index].sConcesionario
                      , 
                        // widget.aPuntosAcumualados[index]
                        //     .sNomLocal, //widget.textNombreConcesionario,
                            maxLines: 1,
                        style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold,
                            fontSize: _responsive.ip(2.1),//14.0,
                            color: Color(0xFF000000)))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 16.0),
                padding: EdgeInsets.only(left: 13, right: 12.5),
                height: _responsive.ip(3.6),//24,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xFFFFD34D)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${widget.aPuntosAcumualados[index].iPuntosAcumulados} Puntos",
                      style: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          fontSize: _responsive.ip(1.8),//12.0,
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
            boxShadow:  [AppConfig.boxShadow],
          ),
        ),
      ],
    ));
  }
}
