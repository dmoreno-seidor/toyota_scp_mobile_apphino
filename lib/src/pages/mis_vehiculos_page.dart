import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/formatters.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/expansion_tile_mis_vehiculos.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/usuario_bloc.dart';

import '../comportamiento_usuario/comportamiento_usuario.dart';

class MisVehiculosPage extends StatefulWidget {
  MisVehiculosPage({Key key}) : super(key: key);
  static final String routeName = "misVehiculos";
  @override
  _MisVehiculosPageState createState() => _MisVehiculosPageState();
}

class _MisVehiculosPageState extends State<MisVehiculosPage>
    with WidgetsBindingObserver {
  final prefs = new PreferenciasUsuario();
  UsuarioBloc usuarioBloc = UsuarioBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
    // final usuarioDataStorage = prefs.usuarioInfo;
    final usuarioDataStorage = prefs.usuarioInfo;
    Map<String, dynamic> usuarioData = jsonDecode(usuarioDataStorage);
    // final prueba= usuarioBloc.consultarDataUnidad(usuarioData['iId']);
    List aUnidades = jsonDecode(usuarioData['aUnidades']);
    final _size = MediaQuery.of(context).size;
    final _responsive = Responsive(context);

    return Scaffold(
      
           
         body:     Container(
                              child: Stack(
        children: <Widget>[

 new Positioned(
              //  left: 30.0,
              //  top: 30.0,
              child: new Container(
            width: _responsive.wp(100),
            height: _responsive.hp(36),
            decoration: new BoxDecoration(color: Color(0xFFE60012)),
            child: Stack(
              children: <Widget>[
                
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                // Positioned(
                //   top: 15.0,
                //   left: 0.0,
                //   right: 0.0,
                //   child:
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: _responsive.wp(6),
                        right: _responsive.wp(6),
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                                                    child: Container(
                              // margin: EdgeInsets.only(bottom: 10),
                                          height: _responsive.ip(1.53), //10.24,
                                          width: _responsive.ip(2.4), 
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
                        Text(
                          "Mis Vehículos",
                          style: TextStyle(
      
                            fontFamily: "HelveticaNeue",
                            fontSize: _responsive.ip(3.3),//22,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            color: Colors.white),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              height: _responsive.ip(15.5), //96,
                              margin: EdgeInsets.only(
                                top: _responsive.hp(1),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 25,
                                          right: 11.0,
                                          top: 16,
                                          bottom: 16),
                                      width: _responsive.ip(5.9), //63.52,
                                      height: _responsive.ip(9.6), //
                                      //  child: Image(image: AssetImage('assets/home/gift.png'))
                                      decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                          image: ExactAssetImage(
                                              'assets/home/camion.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      )),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 17.0),
                                      child: VerticalDivider()),
                                  Container(
                                    //  margin: EdgeInsets.only(right: 16.0),
                                    padding: EdgeInsets.only(
                                      left: 7.5,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Al día de hoy tienes',
                                            // textScaleFactor: 2,
                                            style: TextStyle(
                                                color: Color(0xFFE60012),
                                                // fontFamily: 'HelveticaNeue',
                                                fontFamily: "HelveticaNeue",
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.normal,
                                                fontSize: _responsive.ip(1.75))
                                            // AppConfig.styleTituloCajaPrincipal,
                                            ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 4.0, bottom: 4.0),
                                          child: RichText(
                                              text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    jsonDecode(prefs.usuarioInfo)[
                                                        "iCantidadVehiculos"],
                                                style: TextStyle(
                                                    fontSize: _responsive.ip(3.7),
                                                    fontFamily: 'HelveticaNeue',
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.normal,
                                                    color: Color(0xFF1C1C1C))),
                                            TextSpan(
                                                text: '  Vehículos',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily: 'HelveticaNeue',
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.normal,
                                                    color: Color(0xFF1C1C1C))),
                                          ])),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                                jsonDecode(usuarioData[
                                                                'aUnidades'])
                                                            .length >
                                                        0
                                                    ? "Último registro el "
                                                    : "No existe registros.",
                                                style: TextStyle(
                                                    color: Color(0xFF94949A),
                                                    // fontFamily: 'HelveticaNeue',
                                                    fontFamily: "HelveticaNeue",
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize:
                                                        _responsive.ip(1.75))),
                                            Text(
                                                jsonDecode(usuarioData[
                                                                'aUnidades'])
                                                            .length >
                                                        0
                                                    ? formatFechaDD_MM_YYYY(
                                                        "${jsonDecode(usuarioData['aUnidades'])[0]['dFechaCreacion']}")
                                                    : "No existe registros.",
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
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                boxShadow: [AppConfig.boxShadow],
                              ),
                            ),
                            // Container(
                            //     margin: EdgeInsets.only(top: 8.0),
                            //     child: _expansionTileMisVehiculos1(aUnidades)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // ),
                // Container(
                //   child: Stack(
                //     children: <Widget>[
            ],

            // ),
          )
              ],
            ),
          )),

        Container(
                          // padding: EdgeInsets.only(top: 15),
                          margin: EdgeInsets.only(top: _responsive.hp(32)
                          ,left: _responsive.wp(6),right: _responsive.wp(6),),
                          child: _expansionTileMisVehiculos1(aUnidades),
                          // ]),
                        )


         
        ],
      ),
              )
          //   ],
          // ),
          //   ],
          // ),
          
    );
  }

  Widget _expansionTileMisVehiculos1(aUnidades) {
    return SingleChildScrollView(
          child: Column(
        children: <Widget>[
          ExpansionTileMisVehiculos(
            aUnidades: aUnidades,
          ),
          

        ],
      ),
    );
  }
}
