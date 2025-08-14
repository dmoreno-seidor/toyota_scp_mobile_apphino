import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/models/mis_premios_model.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/formatters.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

import '../app_config.dart';

class ContainerMisPremios extends StatefulWidget {
  // final String textDia;
  // final String textMes;
  // final String textConcesionario;
  // final String textFecha;
  // final String textCantidad;
  // final String image;
  // final String textPremio;
  final MisPremiosModel misPremiosModel;

  ContainerMisPremios({
    Key key, 
    // @required this.textDia,
    // @required this.textMes,
    // @required this.textConcesionario,
    // @required this.textFecha,
    // @required this.textCantidad,
    //  @required this.image,
    // @required this.textPremio,
    @required this.misPremiosModel,
  }) : super(key: key);

  @override
  _ContainerMisPremios createState() => _ContainerMisPremios();
}

class _ContainerMisPremios extends State<ContainerMisPremios> {
  //bool isExpanded = false,

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: _buildMisPremiosList,
                  itemCount: widget.misPremiosModel.premios.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,

                );

    
  }

  Widget _buildMisPremiosList(
    BuildContext context,
    int index,
  ) {
    print(index);
    final _responsive = Responsive(context);
    // bool isExpanded = false;
    int selected = 0;
    return Container(
      //  height: 64,
      margin: EdgeInsets.only(
           bottom: 8.0),
      width: MediaQuery.of(context).size.width,
      child: ExpansionTile(
        title: Container(
         height: _responsive.ip(7.5),//50,
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Row(
                children: <Widget>[
                  Container(
                    // padding: EdgeInsets.only(left:4.0),
                    child: Column(
                      children: <Widget>[
                        Text(formatObtenerDia(widget.misPremiosModel.premios[index].fecha),
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(2.4),//16.0,
                                color: Color(0xFF000000))),
                        Text(formatObtenerNombreMes(widget.misPremiosModel.premios[index].fecha),//widget.textMes,
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(1.8),//12.0,
                                color: Color(0xFFE60012)))
                      ],
                    ),
                  ),
                  
                  Container(
                        margin: EdgeInsets.only(left: 1.5),
                                      height: _responsive.ip(5.4),
                                      child: VerticalDivider(
                                        thickness: 1,
                                          
                                    )),


                                    
                  Container(
                    width: _responsive.ip(6.54),//45,
                     height: _responsive.ip(6.7),//46,
                    margin: EdgeInsets.only(left: 2,right: 6),
                      child: Image.network( 
                        widget.misPremiosModel.premios[index].imagen
                                                    .replaceAll('/bridge/',
                                                        "${AppConfig.api_host_docService}"),
                                                fit: BoxFit.fill,
                  )),
                  Flexible(
                    child: 
                    Container(
                      padding: EdgeInsets.only( left: 12.0),
                      child: Column(
                        
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Premio',
                              style: TextStyle(
                                  fontFamily: 'HelveticaNeue',
                                  fontWeight: FontWeight.w500,
                                  fontSize: _responsive.ip(1.8),//12.0,
                                  color: Color(0xFF94949A))),
                          
                          


                               widget.misPremiosModel.premios[index].isExpanded?   Text(widget.misPremiosModel.premios[index].descrip,
                          
                              style: TextStyle(
                                  fontFamily: 'HelveticaNeue',
                                  fontWeight: FontWeight.bold,
                                  fontSize: _responsive.ip(2.0),//14.0,
                                  color: Color(0xFF000000))) : 
                                  Text(widget.misPremiosModel.premios[index].descrip,
                          maxLines: 1,//widget.textPremio,
                          overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'HelveticaNeue',
                                  fontWeight: FontWeight.bold,
                                  fontSize: _responsive.ip(2.1),//14.0,
                                  color: Color(0xFF000000)))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        trailing: Icon(
          widget.misPremiosModel.premios[index].isExpanded ? Icons.keyboard_arrow_up 
          : Icons.keyboard_arrow_down,
          color: Color(0xFFE60012),
          size: _responsive.ip(3.75)//25.0,
        ),
        // onExpansionChanged: (bool expanding) {
        //   setState(() {
        //     isExpanded = expanding;
        //   });
        // },
        onExpansionChanged: ((newState) {
          if (newState)
            setState(() {
              Duration(seconds: 20000);
              selected = index;
              widget.misPremiosModel.premios[index].isExpanded = newState;
              // print(newState);
            });
          else
            setState(() {
              widget.misPremiosModel.premios[index].isExpanded = newState;
              selected = index;
            });
        }),
        children: <Widget>[
          Container(
            //GNM----
            // padding: EdgeInsets.only(left: _responsive.wp(8)),
            margin: EdgeInsets.only(left:40 ),
            //GNM----
            child: Row(
              children: <Widget>[
                Container(
                    // padding: EdgeInsets.only( right: _responsive.wp(19)),
                    margin: EdgeInsets.only(right:
                    _responsive.ip(8.8),
                    // _responsive.wp(18) 
                    left: _responsive.ip(1.2)
                    ),
                    height: _responsive.ip(17.25),//115,
                    child: VerticalDivider(
                      thickness: 1,
                        //color: Colors.pinkAccent
                        )),
                Flexible(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only( bottom: 12.0),
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
                                        fontSize: _responsive.ip(1.8),//12.0,
                                        color: Color(0xFF94949A))),
                                // SizedBox(
                                //   height: 3.5,
                                // ),
                                Text(widget.misPremiosModel.premios[index].concesionario,//widget.textConcesionario,
                                    style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        fontWeight: FontWeight.bold,
                                        fontSize: _responsive.ip(2.1),//14.0,
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
                                        fontSize: _responsive.ip(1.8),//12.0,
                                        color: Color(0xFF94949A))),
                                // SizedBox(
                                //   height: 3.5,
                                // ),
                                Text(widget.misPremiosModel.premios[index].fecha,//widget.textFecha,
                                    style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: _responsive.ip(2.1),//14.0,
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
                                        fontSize: _responsive.ip(1.8),//12.0,
                                        color: Color(0xFF94949A))),
                                // SizedBox(
                                //   height: 3.5,
                                // ),
                                Text(widget.misPremiosModel.premios[index].cantidad,//widget.textCantidad,
                                    style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: _responsive.ip(2.1),//14.0,
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
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [AppConfig.boxShadow
        ],
      ),
      // height: 125,
    );

  }


  // @override
  // Widget build(BuildContext context) {
  //   final _responsive = Responsive(context);
  //   bool isExpanded = false;
  //   return Container(
  //     margin: EdgeInsets.only(
  //         left: _responsive.wp(6), right: _responsive.wp(6), bottom: 10.0),
  //     width: MediaQuery.of(context).size.width,
  //     child: ExpansionTile(
  //       title: Container(
  //         padding: EdgeInsets.only(
  //             left: _responsive.wp(1),
  //             right: _responsive.wp(1),
  //             top: 12.0,
  //             bottom: 12.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Row(
  //               children: <Widget>[
  //                 Column(
  //                   children: <Widget>[
  //                     Text(widget.textDia,
  //                         style: TextStyle(
  //                             fontFamily: 'HelveticaNeue',
  //                             fontStyle: FontStyle.normal,
  //                             fontWeight: FontWeight.w500,
  //                             fontSize: 18.0,
  //                             color: Color(0xFF000000))),
  //                     Text(widget.textMes,
  //                         style: TextStyle(
  //                             fontFamily: 'HelveticaNeue',
  //                             fontWeight: FontWeight.w500,
  //                             fontSize: 14.0,
  //                             color: Color(0xFFE60012)))
  //                   ],
  //                 ),
  //                 Container(
  //                     height: 65,
  //                     child: VerticalDivider(
  //                         //color: Colors.pinkAccent
  //                         )),
  //                 Container(
  //                   width: 80,
  //                     child: Image.network( 
  //                       widget.image,
  //                       //'https://http2.mlstatic.com/jaqueta-inter-de-milo-20172018-2-cores-frete-gratis-D_NQ_NP_613009-MLB26157520549_102017-F.jpg',
                                           
  //                     fit: BoxFit.fill,
  //                 )),
  //                 Flexible(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: <Widget>[
  //                       Text('Premio',
  //                           style: TextStyle(
  //                               fontFamily: 'HelveticaNeue',
  //                               fontWeight: FontWeight.w500,
  //                               fontSize: 14.0,
  //                               color: Color(0xFF94949A))),
  //                       SizedBox(height: 3.5),
  //                       Text(widget.textPremio,
  //                           style: TextStyle(
  //                               fontFamily: 'HelveticaNeue',
  //                               fontWeight: FontWeight.w500,
  //                               fontSize: 16.0,
  //                               color: Color(0xFF000000)))
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //       trailing: Icon(
  //         isExpanded ? Icons.keyboard_arrow_up 
  //         : Icons.keyboard_arrow_down,
  //         color: Color(0xFFE60012),
  //         size: 30.0,
  //       ),
  //       onExpansionChanged: (bool expanding) {
  //         setState(() {
  //           isExpanded = expanding;
  //         });
  //       },
  //       children: <Widget>[
  //         Row(
  //           children: <Widget>[
  //             Container(
  //                 padding: EdgeInsets.only(left: 43, right: 80),
  //                 height: 150,
  //                 child: VerticalDivider(
  //                     //color: Colors.pinkAccent
  //                     )),
  //             Flexible(
  //               child: Column(
  //                 children: <Widget>[
  //                   Container(
  //                     padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: <Widget>[
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: <Widget>[
  //                             Text('Concesionario',
  //                                 style: TextStyle(
  //                                     fontFamily: 'HelveticaNeue',
  //                                     fontWeight: FontWeight.w500,
  //                                     fontSize: 14.0,
  //                                     color: Color(0xFF94949A))),
  //                             SizedBox(
  //                               height: 3.5,
  //                             ),
  //                             Text(widget.textConcesionario,
  //                                 style: TextStyle(
  //                                     fontFamily: 'HelveticaNeue',
  //                                     fontWeight: FontWeight.w500,
  //                                     fontSize: 16.0,
  //                                     color: Color(0xFF000000)))
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     padding: EdgeInsets.only(
  //                         //top: 12.0,
  //                         bottom: 12.0),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: <Widget>[
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: <Widget>[
  //                             Text('Fecha',
  //                                 style: TextStyle(
  //                                     fontFamily: 'HelveticaNeue',
  //                                     fontStyle: FontStyle.normal,
  //                                     fontWeight: FontWeight.w500,
  //                                     fontSize: 14.0,
  //                                     color: Color(0xFF94949A))),
  //                             SizedBox(
  //                               height: 3.5,
  //                             ),
  //                             Text(widget.textFecha,
  //                                 style: TextStyle(
  //                                     fontFamily: 'HelveticaNeue',
  //                                     fontStyle: FontStyle.normal,
  //                                     fontWeight: FontWeight.w500,
  //                                     fontSize: 16.0,
  //                                     color: Color(0xFF000000)))
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     padding: EdgeInsets.only(
  //                         //top: 12.0,
  //                         bottom: 12.0),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: <Widget>[
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: <Widget>[
  //                             Text('Cantidad',
  //                                 style: TextStyle(
  //                                     fontFamily: 'HelveticaNeue',
  //                                     fontStyle: FontStyle.normal,
  //                                     fontWeight: FontWeight.w500,
  //                                     fontSize: 14.0,
  //                                     color: Color(0xFF94949A))),
  //                             SizedBox(
  //                               height: 3.5,
  //                             ),
  //                             Text(widget.textCantidad,
  //                                 style: TextStyle(
  //                                     fontFamily: 'HelveticaNeue',
  //                                     fontStyle: FontStyle.normal,
  //                                     fontWeight: FontWeight.w500,
  //                                     fontSize: 16.0,
  //                                     color: Color(0xFF000000)))
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(5),
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey,
  //           offset: Offset(0.0, 1.0), //(x,y)
  //           blurRadius: 6.0,
  //         )
  //       ],
  //     ),
  //   );
  // }
}
