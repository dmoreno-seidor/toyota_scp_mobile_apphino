import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/puntos_acumulado_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/mis_puntos_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_mis_puntos.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/formatters.dart';

import '../comportamiento_usuario/comportamiento_usuario.dart';

class MisPuntosPage extends StatefulWidget {
  MisPuntosPage({Key key}) : super(key: key);
  static final String routeName = "misPuntos";
  @override
  _MisPuntosPageState createState() => _MisPuntosPageState();
}

class _MisPuntosPageState extends State<MisPuntosPage>
    with WidgetsBindingObserver {
  final prefs = new PreferenciasUsuario();
  MisPuntosBloc misPuntosBloc = new MisPuntosBloc();

  String _sNumPlacaSeleccionada = '';
  // List<UnidadModel> _tipoDocumentos = ['Todos'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    // misPuntosBloc.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // went to Background
      ComportamientoUsuario.registrarEvento(prefs, cierreApp: true);
    }
    if (state == AppLifecycleState.resumed) {
      // came back to Foreground
      print('On resume...');
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> usuarioMap =
        jsonDecode(ModalRoute.of(context).settings.arguments);
    // List<PuntosAcumuladoModel> filteredPuntosAcumulados = List();
    misPuntosBloc.obtenerRegistroPuntosxCliente(context, usuarioMap['iId']);
    // final usuarioDataStorage = prefs.usuarioInfo;
    // Map<String,dynamic> usuarioData = jsonDecode(usuarioDataStorage);

    final _size = MediaQuery.of(context).size;
    final _responsive = Responsive(context);

    return Scaffold(
      body:  Stack(children: <Widget>[
        Container(
                      color: Color(0xFFE60012),
                      width: _size.width,
                      height: _responsive.hp(36.0),
                    ),
          SafeArea(
                      child: Container(
                child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    
                    Column(
                      children: <Widget>[
                        // SafeArea(
                        //   child: 
                          Container(
                            margin: EdgeInsets.only(
                              left: _responsive.wp(6),
                              right: _responsive.wp(6),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        child: Container(
                                          // color: Colors.greenAccent,
                                          padding: EdgeInsets.only(top: 10,bottom: 10),
                                                                                child: Container(
                                            // margin: EdgeInsets.only(bottom: 10),
                                            height: _responsive.ip(1.53),//10.24,
                                            width: _responsive.ip(2.4),//16,
                                            decoration: new BoxDecoration(
                                              image: DecorationImage(
                                                image: new AssetImage(
                                                    'assets/general/arrow_white.png'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () => Navigator.of(context).pop(),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Mis Puntos",
                                  // style: AppConfig.styleCabecerasPaginas,
                                  style: TextStyle(
        
                              fontFamily: "HelveticaNeue",
                              fontSize: _responsive.ip(3.3),//22,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              color: Colors.white),
                                ),
                                Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          StreamBuilder<Object>(
                                              stream: misPuntosBloc.aUnidadesStream,
                                              builder: (context, snapshot) {
                                                return snapshot.hasData
                                                    ? Container(
                                                        // key: widgetKey,
                                                        height: _responsive
                                                            .ip(15.5), //96,
                                                        margin: EdgeInsets.only(
                                                          top: _responsive.hp(1),
                                                        ),
                                                        width:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .width,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              margin:
                                                                  EdgeInsets.only(
                                                                      left: 16,
                                                                      top: 10,
                                                                      bottom: 10,
                                                                      right: 2.5),
                                                              width: _responsive
                                                                  .ip(9.6),
                                                              height: _responsive
                                                                  .ip(9.6),
                                                              decoration:
                                                                  new BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: new AssetImage(
                                                                      'assets/home/estrella.png'),
                                                                  fit: BoxFit.fill,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            17.0),
                                                                child:
                                                                    VerticalDivider()),
                                                            Container(
                                                              margin:
                                                                  EdgeInsets.only(
                                                                      left: 5),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <Widget>[
                                                                  Text(
                                                                      'Al día de hoy tienes',
                                                                      // textScaleFactor: 2,
                                                                      style: TextStyle(
                                                                          color: Color(0xFFE60012),
                                                                          // fontFamily: 'HelveticaNeue',
                                                                          fontFamily: "HelveticaNeue",
                                                                          fontWeight: FontWeight.bold,
                                                                          fontStyle: FontStyle.normal,
                                                                          fontSize: _responsive.ip(1.75) //12
                                                                          )
                                                                      // AppConfig
                                                                      //     .styleTituloCajaPrincipal,
                                                                      ),
                                                                  Container(
                                                                    // padding: EdgeInsets.only(
                                                                    //     top: 2.0, bottom: 2.0),
                                                                    child: RichText(
                                                                        text: TextSpan(
                                                                            children: <
                                                                                TextSpan>[
                                                                          TextSpan(
                                                                              text:
                                                                                  '${formatPuntos(usuarioMap['iPuntosAcumulados'])}',
                                                                              style: TextStyle(
                                                                                  fontSize: _responsive.ip(3.7), //28.0,
                                                                                  fontFamily: 'HelveticaNeue',
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontStyle: FontStyle.normal,
                                                                                  color: Color(0xFF1C1C1C))),
                                                                          TextSpan(
                                                                              text:
                                                                                  '  Puntos',
                                                                              style: TextStyle(
                                                                                  fontSize: 15.0,
                                                                                  fontFamily: 'HelveticaNeue',
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontStyle: FontStyle.normal,
                                                                                  color: Color(0xFF1C1C1C))),
                                                                        ])),
                                                                    // child: Text(
                                                                    //   '3,500 Pts',
                                                                    //   textScaleFactor: 2,
                                                                    //   style: TextStyle(
                                                                    //       color: Color(0xFF1C1C1C),
                                                                    //       fontFamily: 'HelveticaNeue',
                                                                    //       fontWeight: FontWeight.bold,
                                                                    //       fontStyle: FontStyle.normal,
                                                                    //       fontSize: 12),
                                                                    // ),
                                                                  ),
                                                                  usuarioMap['dPuntosFechaVencimiento'] ==
                                                                          ""
                                                                      ? Text(
                                                                          "No Existe Vigencia",
                                                                          style: TextStyle(
                                                                                  color: Color(0xFF94949A),
                                                                                  // fontFamily: 'HelveticaNeue',
                                                                                  fontFamily: "HelveticaNeue",
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FontStyle.normal,
                                                                                  fontSize: _responsive.ip(1.75)))
                                                                      : Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .start,
                                                                          children: <
                                                                              Widget>[
                                                                            Text(
                                                                              'Algunos puntos vencen en',
                                                                              style: TextStyle(
                                                                                  color: Color(0xFF94949A),
                                                                                  // fontFamily: 'HelveticaNeue',
                                                                                  fontFamily: "HelveticaNeue",
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FontStyle.normal,
                                                                                  fontSize: _responsive.ip(1.75)),
                                                                            ),
                                                                            Text(
                                                                                '${formatObtenerNombreMesAnioV2(usuarioMap['dPuntosFechaVencimiento'])}',
                                                                                // textScaleFactor: 2,
                                                                                style: TextStyle(
                                                                                    color: Color(0xFF94949A),
                                                                                    fontFamily: "HelveticaNeue",
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FontStyle.normal,
                                                                                    fontSize: _responsive.ip(1.75)
                                                                                    //12
                                                                                    )),
                                                                          ],
                                                                        )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  5),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            AppConfig.boxShadow
                                                          ],
                                                        ),
                                                      )
                                                    : Container(
                                                        height: _responsive
                                                            .ip(15.5), //96,
                                                        margin: EdgeInsets.only(
                                                          top: _responsive.hp(1),
                                                        ),
                                                        width:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .width,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                                margin:
                                                                    EdgeInsets.only(
                                                                        left: 16,
                                                                        top: 22,
                                                                        bottom: 22,
                                                                        right: 12),
                                                                 width: _responsive.ip(
                                                                    9.6), //63.52,
                                                                height: _responsive
                                                                    .ip(9.6),
                                                                // width: 72.0,
                                                                // height: 70.5,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Color(
                                                                      0xffE5E5E5),
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            _responsive.ip(2.55)),
                                                                child:
                                                                    VerticalDivider()),
                                                            Container(
                                                              margin:
                                                                  EdgeInsets.only(
                                                                      left: 5),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <Widget>[
                                                                  Container(
                                                                    height:
                                                                        _responsive
                                                                            .ip(3),
                                                                    width: _responsive
                                                                        .ip(20.85),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius: BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(
                                                                                  8),
                                                                          topLeft: Radius
                                                                              .circular(
                                                                                  8),
                                                                          bottomRight:
                                                                              Radius.circular(
                                                                                  8),
                                                                          topRight:
                                                                              Radius.circular(
                                                                                  8)),
                                                                      color: Color(
                                                                          0xffE5E5E5),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height:
                                                                        _responsive
                                                                            .ip(3),
                                                                    width: _responsive
                                                                        .ip(20.85),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius: BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(
                                                                                  8),
                                                                          topLeft: Radius
                                                                              .circular(
                                                                                  8),
                                                                          bottomRight:
                                                                              Radius.circular(
                                                                                  8),
                                                                          topRight:
                                                                              Radius.circular(
                                                                                  8)),
                                                                      color: Color(
                                                                          0xffE5E5E5),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height:
                                                                        _responsive
                                                                            .ip(3),
                                                                    width: _responsive
                                                                        .ip(20.85),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius: BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(
                                                                                  8),
                                                                          topLeft: Radius
                                                                              .circular(
                                                                                  8),
                                                                          bottomRight:
                                                                              Radius.circular(
                                                                                  8),
                                                                          topRight:
                                                                              Radius.circular(
                                                                                  8)),
                                                                      color: Color(
                                                                          0xffE5E5E5),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  5),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            AppConfig.boxShadow
                                                          ],
                                                        ),
                                                      );
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 8),
                                  child: StreamBuilder<Object>(
                                      stream: misPuntosBloc.aUnidadesStream,
                                      builder: (context, snapshot) {
                                        return snapshot.hasData
                                            ? 
                                            Stack(
                                              children: <Widget>[
                                                Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.only(
                                                        left: 16.0, bottom: _responsive.ip(0.9),top: _responsive.ip(1.5)),
                                                    child: Text(
                                                      'Placa',
                                                      style: TextStyle(
                                                          fontFamily: 'HelveticaNeue',
                                                          fontWeight: FontWeight.bold,
                                                          fontStyle: FontStyle.normal,
                                                          fontSize: _responsive.ip(1.8),
                                                          color: Color(0xFFE60012)),
                                                    )),
                                               

                                                 Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.only(
                                                     top: _responsive.ip(2.6)),
                                                    child: _dropDownPlaca(snapshot)),
                                              ],
                                            )
                                            // Stack(
                                            //     children: <Widget>[
                                            //       Container(
                                            //           width: double.infinity,
                                            //           padding: EdgeInsets.only(
                                            //               left: 16.0, top: 8),
                                            //           child: Text(
                                            //             'Placa',
                                            //             style: TextStyle(
                                            //                 fontFamily:
                                            //                     'HelveticaNeue',
                                            //                 fontWeight:
                                            //                     FontWeight.bold,
                                            //                 fontStyle:
                                            //                     FontStyle.normal,
                                            //                 fontSize: 12.0,
                                            //                 color:
                                            //                     Color(0xFFE60012)),
                                            //           )),
                                            //       Column(
                                            //         mainAxisAlignment:
                                            //             MainAxisAlignment.start,
                                            //         crossAxisAlignment:
                                            //             CrossAxisAlignment.start,
                                            //         children: <Widget>[
                                            //           SizedBox(
                                            //             height: 6.0,
                                            //           ),
                                            //           // Text('Placa'),
                                            //           _dropDownPlaca(snapshot),
                                            //         ],
                                            //       )
                                            //     ],
                                            //   )
                                            : Container(
                                                margin: EdgeInsets.only(
                                                    left: _responsive.ip(1.8),
                                                    right: _responsive.ip(1.8)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                          top: _responsive.ip(0.6),
                                                        ),
                                                        height:
                                                            _responsive.ip(1.95),
                                                        width: _responsive.ip(9),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    bottomLeft: Radius
                                                                        .circular(
                                                                            8),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            8),
                                                                    bottomRight:
                                                                        Radius
                                                                            .circular(
                                                                                8),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            8)),
                                                            color:
                                                                Color(0xffE5E5E5),
                                                          ),
                                                        )),
                                                    // SizedBox(
                                                    //   height: 5,
                                                    // ),
                                                    Container(
                                                        height:
                                                            _responsive.ip(2),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    bottomLeft: Radius
                                                                        .circular(
                                                                            8),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            8),
                                                                    bottomRight:
                                                                        Radius
                                                                            .circular(
                                                                                8),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            8)),
                                                            color:
                                                                Color(0xffE5E5E5),
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              );
                                      }),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [AppConfig.boxShadow],
                                  ),
                                  //height: 54,
                                height: _responsive.ip(8.3),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 8.0),
                                      child: Text('Puntos acumulados',
                                          // style: AppConfig.styleSubCabeceraCajas
                                          style: TextStyle(
                                              fontFamily: 'HelveticaNeue',
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF000000),
                                              fontSize: _responsive.ip(2.4),
                                              
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        // left: _responsive.wp(6),
                                        top: 7.0,
                                        bottom: 16.0),
                                    child: Divider(
                                        color: Color(0xFFE60012),
                                        endIndent: _responsive.wp(80.0),
                                        height: 5.0,
                                        thickness: 1)),
                                
                              ],
                            ),
                          ),
                        // ),
                      ],
                    ),

                    
                  ],
                ),

                Expanded(
                            child: SingleChildScrollView(

                              child:


                   Container(
                     margin: EdgeInsets.only(left: _responsive.wp(6),right: _responsive.wp(6),),
                     child: StreamBuilder<Object>(
                                        stream: misPuntosBloc.aPuntosAcumuladosStream,
                                        builder: (context, snapshot){
                                          return snapshot.hasData
                                          ? Container(
                                            child: _containerMisPuntos(),
                                          )
                                          : Column(
                                            children: <Widget>[
                                              _estructuraLoaderMisPuntos(),
                                              _estructuraLoaderMisPuntos(),
                                              _estructuraLoaderMisPuntos()
                                            ],);
                                        }
                                      )
                   )
                            )
                             )
                                        // ),
                              
            ],
        )
        
        ),
          ),
      ]
      
      ),

      // bottomNavigationBar: _crearBootomNavigationbar()
    );
    ////


    // return Scaffold(
    //   body: StreamBuilder<Object>(
    //       stream: misPuntosBloc.aUnidadesStream,
    //       builder: (context, snapshot) {
    //         return Container(
    //             child: Column(
    //           children: <Widget>[
    //             Stack(
    //               children: <Widget>[
    //                 Container(
    //                   color: Color(0xFFE60012),
    //                   width: _size.width,
    //                   height: _responsive.hp(36.0),
    //                 ),
    //                 Positioned(
    //                   top: 10.0,
    //                   left: 0.0,
    //                   right: 0.0,
    //                   child: SafeArea(
    //                     child: Container(
    //                       margin: EdgeInsets.only(
    //                           left: _responsive.wp(6),
    //                           right: _responsive.wp(6)),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: <Widget>[
    //                           GestureDetector(
    //                             child: Container(
    //                               margin: EdgeInsets.only(bottom: 10),
    //                               height: 10.24,
    //                               width: 16,
    //                               decoration: new BoxDecoration(
    //                                 image: DecorationImage(
    //                                   image: new AssetImage(
    //                                       'assets/general/arrow_white.png'),
    //                                   fit: BoxFit.fill,
    //                                 ),
    //                               ),
    //                             ),
    //                             onTap: () => Navigator.of(context).pop(),
    //                           ),
    //                           Text(
    //                             "Mis Puntos",
    //                             style: AppConfig.styleCabecerasPaginas,
    //   //                           style: TextStyle(
    //   // // fontFamily: 'HelveticaNeue',
    //   // fontFamily: "HelveticaNeue",
    //   // fontSize:22,
    //   // fontWeight: FontWeight.bold,
    //   // fontStyle: FontStyle.normal,
    //   // color: Colors.white),
    //                           ),
    //                           Container(
    //                             margin: EdgeInsets.only(

    //                                 top: 8),
    //                             width: MediaQuery.of(context).size.width,
    //                             child: Row(
    //                               children: <Widget>[
    //                                 Container(
    //                                   margin: EdgeInsets.only(
    //                                       left: 16,
    //                                       top: 10,
    //                                       bottom: 10,
    //                                       right: 2.5),
    //                                   width: 61.33,
    //                                   height: 64.0,
    //                                   decoration: new BoxDecoration(
    //                                     image: DecorationImage(
    //                                       image: new AssetImage(
    //                                           'assets/home/estrella.png'),
    //                                       fit: BoxFit.fill,
    //                                     ),
    //                                   ),
    //                                 ),

    //                                 Container(
    //                                   height: 64,
    //                                   child: VerticalDivider(
    //                                     thickness: 1,

    //                                 )),
    //                                 Container(
    //                                   margin: EdgeInsets.only(left: 7.5),
    //                                   child: Column(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.center,
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: <Widget>[
    //                                       Text(
    //                                         'Al día de hoy tienes',
    //                                         // textScaleFactor: 2,
    //                                         style: TextStyle(
    //                                             color: Color(0xFFE60012),
    //                                             // fontFamily: 'HelveticaNeue',
    //                                             fontFamily: "HelveticaNeue",
    //                                             fontWeight: FontWeight.bold,
    //                                             fontStyle: FontStyle.normal,
    //                                             fontSize: 12)
    //                                         // AppConfig
    //                                         //     .styleTituloCajaPrincipal,
    //                                       ),
    //                                       Container(
    //                                         // padding: EdgeInsets.only(
    //                                         //     top: 2.0, bottom: 2.0),
    //                                         child: RichText(
    //                                             text: TextSpan(children: <
    //                                                 TextSpan>[
    //                                           TextSpan(
    //                                               text:
    //                                                   '${formatPuntos(usuarioMap['iPuntosAcumulados'])}',
    //                                               style: TextStyle(
    //                                                   fontSize: 28.0,
    //                                                   fontFamily:
    //                                                       'HelveticaNeue',
    //                                                   fontWeight:
    //                                                       FontWeight.bold,
    //                                                   fontStyle:
    //                                                       FontStyle.normal,
    //                                                   color:
    //                                                       Color(0xFF1C1C1C))),
    //                                           TextSpan(
    //                                               text: '  Puntos',
    //                                               style: TextStyle(
    //                                                   fontSize: 15.0,
    //                                                   fontFamily:
    //                                                       'HelveticaNeue',
    //                                                   fontWeight:
    //                                                       FontWeight.bold,
    //                                                   fontStyle:
    //                                                       FontStyle.normal,
    //                                                   color:
    //                                                       Color(0xFF1C1C1C))),
    //                                         ])),
    //                                         // child: Text(
    //                                         //   '3,500 Pts',
    //                                         //   textScaleFactor: 2,
    //                                         //   style: TextStyle(
    //                                         //       color: Color(0xFF1C1C1C),
    //                                         //       fontFamily: 'HelveticaNeue',
    //                                         //       fontWeight: FontWeight.bold,
    //                                         //       fontStyle: FontStyle.normal,
    //                                         //       fontSize: 12),
    //                                         // ),
    //                                       ),

    //                                       usuarioMap['dPuntosFechaVencimiento']==""?Text("No Existe Vigencia"):
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: <Widget>[
    //                               Text(
    //                           'Algunos puntos vencen en',
    //                           // textScaleFactor: 2,
    //                           style: AppConfig.styleSubTituloCajaPrincipal,
    //                         ),
    //                         Text(
    //                           '${formatObtenerNombreMesAnioV2(usuarioMap['dPuntosFechaVencimiento'])}',
    //                           // textScaleFactor: 2,
    //                           style: TextStyle(
    //                           color: Color(0xFF94949A),
    //                           fontFamily: "HelveticaNeue",
    //                           fontWeight: FontWeight.bold,
    //                           fontStyle: FontStyle.normal,
    //                           fontSize: 12)
    //                         ),
    //                           ],
    //                         )

    //                                     ],
    //                                   ),
    //                                 )
    //                               ],
    //                             ),
    //                             decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(5),
    //                               color: Colors.white,
    //                               boxShadow: [AppConfig.boxShadow],
    //                             ),
    //                             height: 96,
    //                           ),

    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Container(
    //                   child: Stack(
    //                     children: <Widget>[
    //                       Column(
    //                         children: <Widget>[

    //                           Container(
    //                             width: double.infinity,

    //                             margin: EdgeInsets.only(
    //                                 left: _responsive.wp(6),
    //                                 right: _responsive.wp(6),
    //                                 top: _responsive.hp(33)),
    //                             child: snapshot.hasData
    //                                 ?
    //                                   Stack(
    //                                     children: <Widget>[
    //                                       Container(
    //                                           width: double.infinity,
    //                                           padding: EdgeInsets.only(
    //                                               left: 16.0, top: 8),

    //                                           child: Text(
    //                                             'Placa',
    //                                             style: TextStyle(
    //                                                 fontFamily: 'HelveticaNeue',
    //                                                 fontWeight: FontWeight.bold,
    //                                                 fontStyle: FontStyle.normal,
    //                                                 fontSize: 12.0,
    //                                                 color: Color(0xFFE60012)),
    //                                           )),

    //                                           Column(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.start,
    //                                     crossAxisAlignment: CrossAxisAlignment.start,
    //                                     children: <Widget>[
    //                                       SizedBox(height: 6.0,),
    //                                       // Text('Placa'),
    //                                       _dropDownPlaca(snapshot),
    //                                     ],
    //                                   )
    //                                     ],
    //                                   )

    //                                 : Container(
    //                                     margin: EdgeInsets.only(
    //                                         left: 12, right: 12),
    //                                     child: Column(
    //                                       crossAxisAlignment:
    //                                           CrossAxisAlignment.start,
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceEvenly,
    //                                       children: <Widget>[
    //                                         Container(
    //                                             margin: EdgeInsets.only(
    //                                               top: 4),
    //                                           height: 12,
    //                                           width: 70,
    //                                             child: Container(
    //                                               decoration: BoxDecoration(
    //                                                 borderRadius:
    //                                                     BorderRadius.only(
    //                                                         bottomLeft:
    //                                                             Radius.circular(
    //                                                                 8),
    //                                                         topLeft:
    //                                                             Radius.circular(
    //                                                                 8),
    //                                                         bottomRight:
    //                                                             Radius.circular(
    //                                                                 8),
    //                                                         topRight:
    //                                                             Radius.circular(
    //                                                                 8)),
    //                                                 color: Color(0xffE5E5E5),
    //                                               ),
    //                                             )),
    //                                         // SizedBox(
    //                                         //   height: 5,
    //                                         // ),
    //                                         Container(
    //                                             height: 10,
    //                                             child: Container(
    //                                               decoration: BoxDecoration(
    //                                                 borderRadius:
    //                                                     BorderRadius.only(
    //                                                         bottomLeft:
    //                                                             Radius.circular(
    //                                                                 8),
    //                                                         topLeft:
    //                                                             Radius.circular(
    //                                                                 8),
    //                                                         bottomRight:
    //                                                             Radius.circular(
    //                                                                 8),
    //                                                         topRight:
    //                                                             Radius.circular(
    //                                                                 8)),
    //                                                 color: Color(0xffE5E5E5),
    //                                               ),
    //                                             ))
    //                                       ],
    //                                     ),
    //                                   ),
    //                             decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(5),
    //                               color: Colors.white,
    //                               boxShadow: [
    //                                 BoxShadow(
    //                                   color: Colors.grey,
    //                                   blurRadius: 1.0, // soften the shadow
    //                                   spreadRadius: 1.0, //extend the shadow
    //                                   offset: Offset(
    //                                     0.0, // Move to right 10  horizontally
    //                                     0.0, // Move to bottom 10 Vertically
    //                                   ),
    //                                 )
    //                               ],
    //                             ),
    //                             height: 54,
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Container(
    //                   margin: EdgeInsets.only(
    //                       left: _responsive.wp(6),
    //                       right: _responsive.wp(6),
    //                       top: 8.0),
    //                   child: Text(
    //                     'Puntos acumulados',
    //                     // textScaleFactor: 1.5,
    //                     style: TextStyle(
    //                         fontFamily: 'HelveticaNeue',
    //                         fontWeight: FontWeight.bold,
    //                         color: Color(0xFF000000),
    //                         fontSize: 16,

    //                       )
    //                   ),
    //                 ),
    //                 Container(
    //                     margin:
    //                         EdgeInsets.only(left: _responsive.wp(6), top: 7.0, bottom: 16.0),
    //                     child: Divider(
    //                         color: Color(0xFFE60012),
    //                         endIndent: _responsive.wp(84.0),
    //                         height: 5.0,
    //                         thickness: 1)),
    //               ],
    //             ),

    //             Expanded(
    //               child: SingleChildScrollView(
    //                 child: Column(
    //                   children: <Widget>[
    //                     _containerMisPuntos(),
    //                     SizedBox(
    //                     height: 10,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ));
    //       }),

    //   // bottomNavigationBar: _crearBootomNavigationbar()
    // );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown(AsyncSnapshot snapshot) {
    Responsive _responsive = new Responsive(context);
    List<DropdownMenuItem<String>> lista = new List();
    lista.add(DropdownMenuItem(
      child: Text('Todos', style: TextStyle(
                                          fontFamily: 'HelveticaNeue',
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: _responsive.ip(1.8),//12.0,
                                          color: Colors.black)),
      value: '',
    ));

    snapshot.data.forEach((tipo) {
      lista.add(DropdownMenuItem(
        child: Text(tipo.sNumPlaca,
        style:TextStyle(
                                          fontFamily: 'HelveticaNeue',
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: _responsive.ip(1.8),//12.0,
                                          color: Colors.black,)),
        value: tipo.sNumPlaca,
      ));
    });
    return lista;
  }

  Widget _dropDownPlaca(AsyncSnapshot snapshot) {
    return Container(
      // height: 48,
      // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          DropdownButtonHideUnderline(
            child: Expanded(
              child: Container(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                      isExpanded: true,
                      iconEnabledColor: Color(0xFFE60012),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.0,
                      ),
                      value: _sNumPlacaSeleccionada,
                      items: getOpcionesDropdown(snapshot),
                      onChanged: (opt) {
                        setState(() {
                          _sNumPlacaSeleccionada = opt;
                          // filterSearchResults(_sNumPlacaSeleccionada);
                          misPuntosBloc.changePlaca(_sNumPlacaSeleccionada);
                        });
                      }),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    misPuntosBloc.filtrarPorPlaca(query);
  }

  Widget _containerMisPuntos() {
    return StreamBuilder<Object>(
        stream: misPuntosBloc.filterApuntosAcumulados,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ContainerMisPuntos(
                  aPuntosAcumualados: snapshot.data,
                )
              : Container();
        });
  }

  Widget _estructuraLoaderMisPuntos(){
     final _responsive = Responsive(context);
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10, right: 2),
              width: _responsive.ip(5.7),
              height: _responsive.ip(6.6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffE5E5E5),
              )),
          Padding(
              padding: EdgeInsets.symmetric(
                vertical: _responsive.ip(1.2),
              ),
              child: VerticalDivider()),
          Container(
            margin: EdgeInsets.only(left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: _responsive.ip(1.35),
                  width: _responsive.ip(20.85),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: Color(0xffE5E5E5),
                  ),
                ),
                Container(
                  height: _responsive.ip(1.35),
                  width: _responsive.ip(20.85),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: Color(0xffE5E5E5),
                  ),
                ),
                Container(
                  height: _responsive.ip(1.35),
                  width: _responsive.ip(20.85),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: Color(0xffE5E5E5),
                  ),
                )
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
      height: _responsive.ip(9),
    );
  }
}
