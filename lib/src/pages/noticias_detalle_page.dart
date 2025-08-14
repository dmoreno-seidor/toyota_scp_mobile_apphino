import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/models/noticia_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/noticias_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

import '../comportamiento_usuario/comportamiento_usuario.dart';

class NoticiasDetallePage extends StatefulWidget {
  NoticiasDetallePage({Key key}) : super(key: key);
  static final String routeName = "noticiasDetalle";
  @override
  _NoticiasDetallePageState createState() => _NoticiasDetallePageState();
}

class _NoticiasDetallePageState extends State<NoticiasDetallePage> with WidgetsBindingObserver {
  final prefs = new PreferenciasUsuario();

  NoticiaModel noticiaModel;
  NoticiasBloc noticiassBloc = NoticiasBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
     String usuario =
       jsonDecode(prefs.usuarioInfo)["sCorreo"]; 
      noticiassBloc.cargarNoticias(usuario);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
    noticiaModel =
        (ModalRoute.of(context).settings.arguments);

    // final size = MediaQuery.of(context).size;
    // final responsive = Responsive(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              _crearCabecera(noticiaModel),
              _crearCajaContenido(noticiaModel),
              // SizedBox(height: 40.0),
            ],
          )
        ],
      ),
    ));
  }

  Widget _crearCabecera(noticiaModel) {
    final _responsive = Responsive(context);
    return Container(
        child: Column(children: <Widget>[
      // campaniaModel != null?
      Hero(
        tag: '${noticiaModel.id}-noticia',
        child: Stack(
          children: <Widget>[
            Container(
              // height: 400,
              height: _responsive.ip(60),
              child: 
              // Image(
              //     image: NetworkImage(noticiaModel.imagen
              //           .replaceAll('/bridge/',
              //                "${AppConfig.api_host_docService}")),
              //     // fit: BoxFit.fill,
              //     fit: BoxFit.cover,
              // ),

              AspectRatio(
                  aspectRatio: 16/9,
                                  child: 
                                  ClipRect(
                                                                      child: PhotoView(
                    minScale: PhotoViewComputedScale.covered,
            maxScale: PhotoViewComputedScale.covered,
                    // enableRotation: true,
      imageProvider: NetworkImage(noticiaModel.imagen
                        .replaceAll('/bridge/',
                             "${AppConfig.api_host_docService}")),
                             loadingBuilder: (context, event) {
                             return Container(
           
          margin: EdgeInsets.all(8),
    
          decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              'assets/campania/iconoCarga.gif'),
          fit: BoxFit.cover,
        ),
          
        ),
      );    
                               }
    ),
                                  ),
                )
            ),
            Positioned(
                 top: 10.0,
              left: 0.0,
              right: 0.0,
              child: SafeArea(
                child: Container(
                  margin: EdgeInsets.only(
                      left:17, right:287),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                           margin: EdgeInsets.only(bottom: 10),
                                      height: _responsive.ip(1.53), //10.24,
                                      width: _responsive.ip(2.4),
                          // margin: EdgeInsets.only(bottom: 10),
                          // height: 10,
                          // width: 16,
                          decoration: new BoxDecoration(
                            image: DecorationImage(
                              image: new AssetImage(
                                  'assets/general/arrow_white.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //  _crearCajaContenido()
          ],
        ),
      )
    ]));
  }

  Widget _crearCajaContenido(noticiaModel) {
    final _responsive = Responsive(context);
    return Container(
      // width: double.infinity,
      margin: EdgeInsets.only(
          left: 16,
          right: 16,
          top: _responsive.ip(57.6),//384,
          bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 20.0, left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    noticiaModel.nombre,
                    style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontSize: _responsive.ip(2.1),//14.0,
                        color: Color(0xFF000000)),
                  ),
                  SizedBox(height: 7.0),
                  Text(
                    'Publicada el ${noticiaModel.publicadoDesde}',
                    style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: _responsive.ip(1.8),//12.0,
                        color: Color(0xFF94949A)),
                  ),
                ],
              )),
          _contenidoNoticia(noticiaModel),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: [AppConfig.boxShadow],
      ),
      // height: 500,
    );
  }

  Widget _contenidoNoticia(noticiaModel) {
    final _responsive = Responsive(context);

    return Container(
      padding:
          EdgeInsets.only(top: 16.0, bottom: 16.0, ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
            // padding: EdgeInsets.only( right: 8,left: 8),
             padding: EdgeInsets.only( right: 13,left: 13),
            child: Html(
                            data: noticiaModel.texto,
                             style: {
                              "div": Style(
                                textAlign: TextAlign.justify,
                                fontFamily: "HelveticaNeue",
                                fontSize: FontSize.percent(85)
                  //             
                              ),
                              "b": Style(
                                textAlign: TextAlign.justify,
                                fontFamily: "HelveticaNeue",
                                fontSize: FontSize.percent(85)
                  //             
                              )
                              
                              }),
          )
          
          // Container(
          //     margin: EdgeInsets.only(
          //         left: _responsive.wp(5),
          //         right: _responsive.wp(5),
          //         top: _responsive.hp(2.5),
          //         bottom: _responsive.hp(2.5)),
          //     child: Divider(height: 4.0, thickness: 2.5)),
          // SizedBox(height: 10.0),
          // Text(
          //     'Fuente: Asociación Automotriz del Perú (AAP) : Según el reporte estadístico de venta acumulada a diciembre 2016 (ventas acumuladas de camiones y remolcadores, P2, P3, P4 y P5) y reporte estadístico de inmatriculación de Vehículos Nuevos del 2014, 2015 y 2016.',
          //     textAlign: TextAlign.justify,
          //     style: TextStyle(
          //       fontFamily: 'HelveticaNeue',
          //       fontStyle: FontStyle.normal,
          //       fontWeight: FontWeight.normal,
          //       fontSize: 12.0,
          //       // height: 1.5,
          //       color: Color(0xFF000000),
          //       // letterSpacing: 2.5
          //     )),
        ],
      ),
    );
  }
}
