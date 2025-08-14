import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class ContainerConcesionario extends StatefulWidget {
  final String textDia;
  final String textMes;
  final String textConcesionario;
  final String textFecha;
  final String textCantidad;
  final String image;
  final String textPremio;

  ContainerConcesionario({
    Key key, 
    @required this.textDia,
    @required this.textMes,
    @required this.textConcesionario,
    @required this.textFecha,
    @required this.textCantidad,
     @required this.image,
    @required this.textPremio,
  }) : super(key: key);

  @override
  _ContainerConcesionario createState() => _ContainerConcesionario();
}

class _ContainerConcesionario extends State<ContainerConcesionario> {
  //bool isExpanded = false,

  @override
  Widget build(BuildContext context) {
    final _responsive = Responsive(context);
    bool isExpanded = false;
    return Container(
      margin: EdgeInsets.only(
          left: _responsive.wp(6), right: _responsive.wp(6), bottom: 10.0),
      width: MediaQuery.of(context).size.width,
      child: ExpansionTile(
        title: Container(
          padding: EdgeInsets.only(
              left: _responsive.wp(1),
              right: _responsive.wp(1),
              top: 12.0,
              bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(widget.textDia,
                          style: TextStyle(
                              fontFamily: 'HelveticaNeue',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                              color: Color(0xFF000000))),
                      Text(widget.textMes,
                          style: TextStyle(
                              fontFamily: 'HelveticaNeue',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: Color(0xFFE60012)))
                    ],
                  ),
                  Container(
                      height: 65,
                      child: VerticalDivider(
                          //color: Colors.pinkAccent
                          )),
                  Container(
                    width: 80,
                      child: Image.network( 
                        widget.image,
                        //'https://http2.mlstatic.com/jaqueta-inter-de-milo-20172018-2-cores-frete-gratis-D_NQ_NP_613009-MLB26157520549_102017-F.jpg',
                                           
                      fit: BoxFit.fill,
                  )),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Premio',
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: Color(0xFF94949A))),
                        SizedBox(height: 3.5),
                        Text(widget.textPremio,
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                color: Color(0xFF000000)))
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        trailing: Icon(
          isExpanded ? Icons.keyboard_arrow_up 
          : Icons.keyboard_arrow_down,
          color: Color(0xFFE60012),
          size: 30.0,
        ),
        onExpansionChanged: (bool expanding) {
          setState(() {
            isExpanded = expanding;
          });
        },
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 42, right: 80),
                  height: 150,
                  child: VerticalDivider(
                      //color: Colors.pinkAccent
                      )),
              Flexible(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Concesionario',
                                  style: TextStyle(
                                      fontFamily: 'HelveticaNeue',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      color: Color(0xFF94949A))),
                              SizedBox(
                                height: 3.5,
                              ),
                              Text(widget.textConcesionario,
                                  style: TextStyle(
                                      fontFamily: 'HelveticaNeue',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      color: Color(0xFF000000)))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          //top: 12.0,
                          bottom: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Fecha',
                                  style: TextStyle(
                                      fontFamily: 'HelveticaNeue',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      color: Color(0xFF94949A))),
                              SizedBox(
                                height: 3.5,
                              ),
                              Text(widget.textFecha,
                                  style: TextStyle(
                                      fontFamily: 'HelveticaNeue',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      color: Color(0xFF000000)))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          //top: 12.0,
                          bottom: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Cantidad',
                                  style: TextStyle(
                                      fontFamily: 'HelveticaNeue',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      color: Color(0xFF94949A))),
                              SizedBox(
                                height: 3.5,
                              ),
                              Text(widget.textCantidad,
                                  style: TextStyle(
                                      fontFamily: 'HelveticaNeue',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      color: Color(0xFF000000)))
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow:  [AppConfig.boxShadow],
      ),
    );
  }
}
