import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/formatters.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class ContainerEventos extends StatefulWidget {
  final List aEventos;

  const ContainerEventos({Key key, this.aEventos}) : super(key: key);
  @override
  _ContainerEventosState createState() => _ContainerEventosState();
}

class _ContainerEventosState extends State<ContainerEventos> {
  //  int id;

  @override
  Widget build(BuildContext context) {
    return widget.aEventos.length==0?
    _noBuildEventoList(): ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: _buildEventoList, //iterar
      itemCount: widget.aEventos.length,
      shrinkWrap: true,
    );
  }

  Widget _noBuildEventoList(){
    Responsive _responsive = new Responsive(context);
    return Container(
      margin:EdgeInsets.only(left: 22,bottom: 16.0),
      child: Text(
        'Por el momento no tenemos Eventos disponibles para ti.',
                   // 'No hay Eventos Vigentes',
                    // style: AppConfig.styleSubCabecerasPaginas,
                    style: TextStyle(
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontSize: _responsive.ip(2.4),//16,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Colors.white),

                  ),
    );
  }

  Widget _buildEventoList(BuildContext context, int index) {
    print(widget.aEventos[index].id);
    Responsive _responsive = new Responsive(context);
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
// margin: EdgeInsets.only(bottom: 20.0),
          width: MediaQuery.of(context).size.width,
          child: Column(children: <Widget>[
            Column(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0)),
                    child: Hero(
                        tag: "${widget.aEventos[index].unique}-evento",
                        child: FadeInImage.assetNetwork(
                          image: widget.aEventos[index].imagen.replaceAll(
                              '/bridge/', "${AppConfig.api_host_docService}"),
                          placeholder: 'assets/campania/iconoCarga.gif',
                          fadeInDuration: Duration(milliseconds: 200),
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
// height: 192,
                        ))),
              ],
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'eventosDetalle',
                  arguments: widget.aEventos[index]),
              child: Container(
// height: 65,
                // margin: EdgeInsets.only(top: _responsive.ip(30.0) // 158
                //     ),
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
// crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
// padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: <Widget>[
                                Text(
                                    widget.aEventos[index].diaEvento == ''
                                        ? ''
                                        : formatObtenerDia(
                                            widget.aEventos[index].diaEvento),
                                    style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: _responsive.ip(2.4),//16.0,
                                        color: Color(0xFF000000))),
                                Text(
                                    widget.aEventos[index].diaEvento == ''
                                        ? ''
                                        : formatObtenerNombreMes(
                                            widget.aEventos[index].diaEvento),
// formatObtenerNombreMes(widget.aEventos[index].fechaEvento),
                                    style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        fontWeight: FontWeight.bold,
                                        fontSize: _responsive.ip(2.1),//14.0,
                                        color: Color(0xFFE60012))),
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              height: 40,
                              child: VerticalDivider(
                                  thickness: 1.0,
// endIndent: 4.0,
// indent: 1.0,
                                  color: Color(0xFF94949A))),
                          Expanded(
                            child: Text(
                              "${widget.aEventos[index].nombre}",
                              style: TextStyle(
                                  fontFamily: 'HelveticaNeue',
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  fontSize: _responsive.ip(2.1),//14.0,
                                  color: Color(0xFF000000)),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Color(0xFFE60012),
                            size: 30,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [AppConfig.boxShadow],
          ),
        ),
      ],
    );

    // return Container(
    //   margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
    //   // height: 232,
    //   // decoration: BoxDecoration(border: Border.all(color: Colors.pinkAccent)),
    //   child: Card(
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(5.0))),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: <Widget>[
    //         ClipRRect(
    //             borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(5.0),
    //                 topRight: Radius.circular(5.0)),
    //             child: Hero(
    //               tag: "${widget.aEventos[index].unique}-evento",
    //               child: FadeInImage.assetNetwork(
    //                   image: widget.aEventos[index].imagen.replaceAll('/bridge/',
    //                           "${AppConfig.api_host_docService}"),
    //                   placeholder: 'assets/campania/iconoCarga.gif',
    //                   fadeInDuration: Duration(milliseconds: 200),
    //                   fit: BoxFit.fitWidth,
    //                   width: double.infinity,
    //                   // height: 192,
    //                 )
    //             )),
    //         GestureDetector(
    //             onTap: () => Navigator.pushNamed(context, 'eventosDetalle', arguments: widget.aEventos[index]),
    //             child: Container(
    //               padding: EdgeInsets.all(16),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: <Widget>[
    //                   Row(
    //                     // crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: <Widget>[
    //                       Container(
    //                         // padding: EdgeInsets.symmetric(horizontal: 5),
    //                         child: Column(
    //                             children: <Widget>[
    //                               Text(
    //                                 widget.aEventos[index].diaEvento == '' ? ''
    //                                 :formatObtenerDia(widget.aEventos[index].diaEvento),

    //                                 style: TextStyle(
    //                                   fontFamily: 'HelveticaNeue',
    //                                   fontStyle: FontStyle.normal,
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 16.0,
    //                                   color: Color(0xFF000000))
    //                               ),
    //                               Text(
    //                                 widget.aEventos[index].diaEvento == '' ? ''
    //                                 :formatObtenerNombreMes(widget.aEventos[index].diaEvento),
    //                                 // formatObtenerNombreMes(widget.aEventos[index].fechaEvento),
    //                               style: TextStyle(
    //                                 fontFamily: 'HelveticaNeue',
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: 14.0,
    //                                 color: Color(0xFFE60012))
    //                               ),
    //                             ],
    //                           ),
    //                       ),
    //                          Container(
    //                           padding: EdgeInsets.symmetric(horizontal: 8),
    //                           height: 40,
    //                           child: VerticalDivider(
    //                             thickness: 1.0,
    //                             // endIndent: 4.0,
    //                             // indent: 1.0,
    //                             color: Color(0xFF94949A)
    //                             )),
    //                       Expanded(
    //                           child: Text(
    //                                       "${widget.aEventos[index].nombre}",
    //                                       style: TextStyle(
    //                                           fontFamily: 'HelveticaNeue',
    //                                           fontWeight: FontWeight.bold,
    //                                           fontStyle: FontStyle.normal,
    //                                           fontSize: 14.0,
    //                                           color: Color(0xFF000000)),
    //                                     ),
    //                       ),
    //                       Icon(
    //                                 Icons.keyboard_arrow_right,
    //                                 color: Color(0xFFE60012),
    //                                 size: 30,
    //                               )
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             )
    //             )
    //       ],
    //     ),
    //   ),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //     // color: Colors.white,
    //     // boxShadow: [AppConfig.boxShadow],
    //   ),
    // );
  }
}
