import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/models/evento_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/eventos_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/formatters.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

import '../comportamiento_usuario/comportamiento_usuario.dart';

class EventosDetallePage extends StatefulWidget {
  EventosDetallePage({Key key}) : super(key: key);
   static final String routeName = "eventosDetalle";
  @override
  _EventosDetallePageState createState() => _EventosDetallePageState();
}

class _EventosDetallePageState extends State<EventosDetallePage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  final prefs = new PreferenciasUsuario();
  
  EventoModel eventoModel;
  EventosBloc eventosBloc = EventosBloc();

   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    String usuario =
       jsonDecode(prefs.usuarioInfo)["sCorreo"]; 
      eventosBloc.cargarEventos(usuario);
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
    eventoModel =
        (ModalRoute.of(context).settings.arguments);
    
    // final size = MediaQuery.of(context).size;
    // final responsive = Responsive(context);

    return Scaffold(
      // key: scaffoldState,
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            _crearCabecera(eventoModel),
            _crearCajaContenido(eventoModel),
            _button(eventoModel),
           
          ],)
          
        ],
      ),
    ));
  }

  
  Widget _crearCabecera(eventoModel) {
    final _responsive = Responsive(context);
    return Container(
        child: Column(
      children: <Widget>[
        // campaniaModel != null?
        Hero(
          tag:'${eventoModel.unique}-evento',
                  child: Stack(
            children: <Widget>[
              Container(
                // height: 400,
                height: _responsive.ip(60),//400,
                // margin: EdgeInsets.all(15),
                child: 
                // Image(
                //      image: NetworkImage(eventoModel.imagen
                //         .replaceAll('/bridge/',
                //              "${AppConfig.api_host_docService}")),
                //   // image: AssetImage('assets/campania/cabecera_img.png'),
                //   fit: BoxFit.cover,
                //  ),

                 AspectRatio(
                  aspectRatio: 16/9,
                                  child: 
                                  ClipRect(
                                                                      child: PhotoView(
                    minScale: PhotoViewComputedScale.covered,
            maxScale: PhotoViewComputedScale.covered,
                    // enableRotation: true,
      imageProvider: NetworkImage(eventoModel.imagen
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
                // top: 10.0,
                left: 0.0,
                right: 0.0,
                child: SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 17, right: 287),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            // color: Colors.green,
                            padding: EdgeInsets.only(top:10,bottom: 10,right: 16),
                                                      child: Container(
                              // margin: EdgeInsets.only(bottom: 10),
                              // height: 10,
                              // width: 16,
                              //  margin: EdgeInsets.only(bottom: 10),
                                        height: _responsive.ip(1.53), //10.24,
                                        width: _responsive.ip(2.4), //
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
                ),
              ),
            //  _button(),
            ],
          ),
        )
      ]
    ));
  }

  Widget _button(eventoModel){
    final _responsive = Responsive(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Container(
        //     margin: EdgeInsets.only(
        //         top: 365, left: 39, right: 41),
        //     height: 40.0,
        //     child: 
          Container(
            margin: EdgeInsets.only(
                top: _responsive.ip(54.5)//380
                // top : 330
            ),
            height:_responsive.ip(6),
            child :  
            RaisedButton(
              child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 30.0),
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Agregar al calendario",
                    // style: AppConfig.styleTextBoton,
                    style: TextStyle(
    fontFamily: "HelveticaNeue",
    fontStyle: FontStyle.normal,  
    fontWeight: FontWeight.bold,
    fontSize: _responsive.ip(2.4),
  ),
                  )),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
              elevation: 0.0,
              color: Color(0xffE60012),
              textColor: Colors.white,
              onPressed: () {
                print('h');
                List fechasI = eventoModel.publicadoDesde.split('/');
                List fechasF = eventoModel.publicadoHasta.split('/');


                Event event = Event(
                    title: eventoModel.nombre, //'MANTENIMIENTO PREVENTIVO DE MI UNIDAD',
                    description: eventoModel.lugarNombre,//'Mitsui Automotriz',
                    location: eventoModel.lugarDireccion,//'Carr. Central 1283, Santa Anita 15011',
                    startDate: DateTime(int.parse(fechasI[2], radix:10),int.parse(fechasI[1], radix:10),int.parse(fechasI[0], radix:10),DateFormat.jm().parse(eventoModel.horaEvento.toUpperCase()).hour,DateFormat.jm().parse(eventoModel.horaEvento.toUpperCase()).minute ),
                    endDate: DateTime(int.parse(fechasF[2], radix:10),int.parse(fechasF[1], radix:10),int.parse(fechasF[0], radix:10),DateFormat.jm().parse(eventoModel.horaEvento.toUpperCase()).hour,DateFormat.jm().parse(eventoModel.horaEvento.toUpperCase()).minute),
                    allDay: false,
                  );
                print('hola');
                // event = eventoModel;
                 Add2Calendar.addEvent2Cal(event).then((success) {
                scaffoldState.currentState.showSnackBar(
                    SnackBar(content: Text(success ? 'Agregando evento' : 'Error al agregar evento')));
              });
                
              },
            )
            // :RaisedButton(
            //   child: Container(
            //       padding: EdgeInsets.symmetric(horizontal: 30.0),
            //       child: Text(
            //         "Solicitar campaña",
            //         style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
            //       )),
            //   shape:
            //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
            //   elevation: 0.0,
            //   color: Color(0xffE60012).withOpacity(0.8),
            //   textColor: Colors.white,
            //   onPressed: (){
            //     print("Button Deshabilitado");
            //   },
            // )
            
            ,
          ),
      ],
    );
  }

  Widget _crearCajaContenido(eventoModel) {
    final _responsive = Responsive(context);
    return Container(
      height: _responsive.ip(34.8),//232,
      margin: EdgeInsets.only(
          left: 16,
          right: 16,
          top: _responsive.ip(57.6),//384,
          bottom: 16,
      ),
      child: Container(
                  padding: EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0, bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    eventoModel.diaEvento == '' ? ''
                                      :formatObtenerDia(eventoModel.diaEvento),
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: _responsive.ip(2.4),//16.0,
                                    color: Color(0xFF000000))
                                  ),
                                  Text(
                                    eventoModel.diaEvento == '' ? ''
                                      :formatObtenerNombreMes(eventoModel.diaEvento),
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                    fontWeight: FontWeight.w500,
                                    fontSize: _responsive.ip(2.1),//14.0,
                                    color: Color(0xFFE60012))
                                  ),
                                ],
                              ),
                          ),
                             Container( 
                              padding: EdgeInsets.only(left: 8, right: 8),
                              height: _responsive.hp(28),
                              child: VerticalDivider(
                                thickness: 0.5,
                                // endIndent: 4.0,
                                // indent: 1.0,
                                color: Color(0xFF94949A)
                                )),
                          Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // padding: EdgeInsets.only(left:8.0),
                                    child: Text(
                                           eventoModel.nombre,
                                            overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                            style: TextStyle(
                                                fontFamily: 'HelveticaNeue',
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.normal,
                                                fontSize: _responsive.ip(2.1),
                                                color: Color(0xFF000000)),
                                          ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Dia',
                                          style: TextStyle(
                                              fontFamily: 'HelveticaNeue',
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: _responsive.ip(1.65),//11
                                              color: Color(0xFFE60012)),
                                        ),
                                        Text(
                                          eventoModel.dia == '' ? ''
                                          :formatObtenerNombreDia(eventoModel.dia),
                                          style: TextStyle(
                                              fontFamily: 'HelveticaNeue',
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: _responsive.ip(2.1),//14.0,
                                              color: Color(0xFF1C1C1C)),
                                        ),
                                    ]),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Hora',
                                          style: TextStyle(
                                              fontFamily: 'HelveticaNeue',
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: _responsive.ip(1.65),//11,
                                              color: Color(0xFFE60012)),
                                        ),
                                        Text(
                                          eventoModel.horaEvento,
                                          style: TextStyle(
                                              fontFamily: 'HelveticaNeue',
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: _responsive.ip(2.1),//14.0,
                                              color: Color(0xFF1C1C1C)),
                                        ),
                                    ]),
                                  ),
                                  Container(
                                    // padding: EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Lugar',
                                          style: TextStyle(
                                              fontFamily: 'HelveticaNeue',
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: _responsive.ip(1.65),//11.0,
                                              color: Color(0xFFE60012)),
                                        ),
                                        Text(
                                          eventoModel.lugarNombre,
                                          style: TextStyle(
                                              fontFamily: 'HelveticaNeue',
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: _responsive.ip(2.1),//14.0,
                                              color: Color(0xFF1C1C1C)),
                                        ),
                                        Text(
                                          eventoModel.lugarDireccion,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontFamily: 'HelveticaNeue',
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: _responsive.ip(1.8),//12.0,
                                              color: Color(0xFF94949A)),
                                        ),
                                    ]),
                                  ),
                                ])
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: [AppConfig.boxShadow],
      ),
      // height: 500,
    );
  }

  
}
