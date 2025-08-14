import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/preguntas_frecuentes_bloc.dart';
// import 'package:toyota_scp_mobile_apphino/src/widgets/expansion_tile_mis_vehiculos.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/expansion_tile_preguntas_frecuentes.dart';

import '../comportamiento_usuario/comportamiento_usuario.dart';
import '../preferencias_usuario/preferencias_usuario.dart';

class PreguntasFrecuentesPage extends StatefulWidget {
  PreguntasFrecuentesPage({Key key}) : super(key: key);
  static final String routeName = "preguntasFrecuentes";
  @override
  _PreguntasFrecuentesPageState createState() => _PreguntasFrecuentesPageState();
}

class _PreguntasFrecuentesPageState extends State<PreguntasFrecuentesPage> with WidgetsBindingObserver {
  PreguntasFrecuentesBloc preguntasFrecuentesBloc = PreguntasFrecuentesBloc();
  final prefs = new PreferenciasUsuario();
  
  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    preguntasFrecuentesBloc.cargarPreguntasFrecuentes();
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
    final _size = MediaQuery.of(context).size;
    final _responsive = Responsive(context);


  return Scaffold(
      body: 
              // Column(
              //   children: <Widget>[
              Container(
                child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
width: _responsive.wp(100),
            height: _responsive.hp(36),
            decoration: new BoxDecoration(color: Color(0xFFE60012)),
              child: Stack(
                children: <Widget>[
                   Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

                SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: _responsive.wp(6),
                        right: _responsive.wp(6),
                        top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
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
                          onTap: () => Navigator.of(context).pop(),
                        ),
                        Text(
                         "Preguntas Frecuentes",
                          style: TextStyle(
      
                            fontFamily: "HelveticaNeue",
                            fontSize: _responsive.ip(3.3),//22,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            color: Colors.white),
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
          ),
                ],
              ),
            ),
          ),

          Container(
                                margin: EdgeInsets.only(top: _responsive.hp(15)
                                ,left: _responsive.wp(6),right: _responsive.wp(6),),//8.0),
                                child: _expansionTilePreguntasFrecuentes1())
         
        ],
      ),
              )
          //   ],
          // ),
          //   ],
          // ),
          
    );


  ////

  // return Scaffold(
  //       body: SingleChildScrollView(
  //           child: Stack(
  //     children: <Widget>[
  //       Column(
  //         children: <Widget>[
  //           Stack(
  //             children: <Widget>[
  //               Container(
  //                 color: Color(0xFFE60012),
  //                 width: _size.width,
  //                 height: _responsive.hp(36.0),
  //               ),
  //               Positioned(
  //                 top: 10.0,
  //                 left: 0.0,
  //                 right: 0.0,
  //                 child: SafeArea(
  //                   child: Container(
  //                     margin: EdgeInsets.only(
  //                         left: _responsive.wp(6), right: _responsive.wp(6)),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         GestureDetector(
  //                           child: Container(
  //                             // margin: EdgeInsets.only(bottom: 5),
  //                             margin: EdgeInsets.only(bottom: 10.36),
  //                             height: _responsive.ip(1.53),//10.24,
  //                                     width: _responsive.ip(2.4),//16,
  //                             decoration: new BoxDecoration(
  //                               image: DecorationImage(
  //                                 image: new AssetImage(
  //                                     'assets/general/arrow_white.png'),
  //                                 fit: BoxFit.fill,
  //                               ),
  //                             ),
  //                           ),
  //                           onTap: () => Navigator.of(context).pop(),
  //                         ),
  //                         Text(
  //                             "Preguntas Frecuentes",
  //                             // style: AppConfig.styleCabecerasPaginas,
  //                             style: TextStyle(
      
  //                         fontFamily: "HelveticaNeue",
  //                         fontSize: _responsive.ip(3.3),//22,
  //                         fontWeight: FontWeight.bold,
  //                         fontStyle: FontStyle.normal,
  //                         color: Colors.white),
  //                           ),

                                                   
  //                               // ),
  //                         // _buildTituloTalleresCercanos(context),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //                      Container(
  //                        margin: EdgeInsets.only(top: _responsive.wp(31.2)),
  //                                               child: Column(
  //                                   children: <Widget>[
  //                                   _expansionTilePreguntasFrecuentes1(),
  //                                   ],
  //                                                           ),
  //                      )
               
  //             ],
  //           ),


  //         ],
  //       ),
        
  //     ],
  //   )));









    // return Scaffold(
    //   body: Container(
    //     height: _size.height,
    //     child: 
    //         Stack(
    //           children: <Widget>[
    //             Container(
    //               color: Color(0xFFE60012),
    //               width: _size.width,
    //               height: _responsive.hp(34),
    //             ),
    //             Positioned(
    //               top: 10.0,
    //               left: 0.0,
    //               right: 0.0,
    //               child: SafeArea(
    //                 child: Container(
    //                   margin: EdgeInsets.only(
    //                       left: _responsive.wp(6), right: _responsive.wp(6)),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: <Widget>[
    //                       GestureDetector(
    //                         child: Container(
    //                           margin: EdgeInsets.only(bottom: 5),
    //                           height: 10,
    //                           width: 16,
    //                           decoration: new BoxDecoration(
    //                             image: DecorationImage(
    //                               image: new AssetImage(
    //                                   'assets/general/arrow_white.png'),
    //                               fit: BoxFit.fill,
    //                             ),
    //                           ),
    //                         ),
    //                         onTap: () => Navigator.of(context).pop(),
    //                       ),
    //                       Text(
    //                           "Preguntas Frecuentes",
    //                           style: AppConfig.styleCabecerasPaginas,
    //                         ),
                          
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               child: Stack(
    //                 children: <Widget>[
    //                   Column(
    //                     children: <Widget>[
    //                       Expanded(
    //                         child: Container(
    //                           // height: MediaQuery.of(context).size.height,
    //                           margin: EdgeInsets.only(
    //                               // left: _responsive.wp(6),
    //                               // right: _responsive.wp(6),
    //                               top: 81),
    //                           width: MediaQuery.of(context).size.width,
    //                           // child: Expanded(
    //                           child:
    //                             SingleChildScrollView(
    //                             child: Column(
    //                               children: <Widget>[
    //                               _expansionTilePreguntasFrecuentes1(),
    //                               // _expansionTilePreguntasFrecuentes2(),
    //                               // // _expansionTilePreguntasFrecuentes3(),
    //                               // _expansionTilePreguntasFrecuentes4(),
    //                               // _expansionTilePreguntasFrecuentes5(),
    //                               ],
    //                             // ),
    //                           ),
    //                           )
    //                         ),
    //                       ),

    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),

    //   ),
    // );
  }

  Widget _expansionTilePreguntasFrecuentes1() {
    
    return SingleChildScrollView(
          child: StreamBuilder(
        stream:  preguntasFrecuentesBloc.preguntasFrecuentesStream,
        builder: (context,snapshot){
          return snapshot.hasData? 
          Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ExpansionTilePreguntasFrecuentes(
                    preguntasFrecuentes :snapshot.data,
                  ),
                ],
              ),
            ],
          ):Column(
            children: <Widget>[
              _loaderPreguntasFrecuentes(),
              _loaderPreguntasFrecuentes(),
              _loaderPreguntasFrecuentes(),
              _loaderPreguntasFrecuentes(),
              _loaderPreguntasFrecuentes(),
            ],
          );
        }
      ),
    );
    
  }

  Widget _loaderPreguntasFrecuentes(){
    final _responsive = Responsive(context);
    return Container(
                                        margin: EdgeInsets.only( bottom: 15.0),
              width: MediaQuery.of(context).size.width,
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  height: 30,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                      8),
                                                              topLeft:
                                                                  Radius.circular(
                                                                      8),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      8),
                                                              topRight:
                                                                  Radius.circular(
                                                                      8)),
                                                      color: Color(0xffE5E5E5),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [AppConfig.boxShadow],
                        ),
                       height: 50.0,
                                      );
  }

 
}
