import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/models/servicio_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/mis_servicios_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_mis_servicios.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';

import '../comportamiento_usuario/comportamiento_usuario.dart';

class MisServiciosPage extends StatefulWidget {
  MisServiciosPage({Key key}) : super(key: key);
  static final String routeName = "misServicios";
  @override
  _MisServiciosPageState createState() => _MisServiciosPageState();
}

class _MisServiciosPageState extends State<MisServiciosPage> with WidgetsBindingObserver {
  final prefs = new PreferenciasUsuario();
  
  MisServiciosBloc misServiciosBloc = new MisServiciosBloc();
  
  String _placaSeleccionada= '';
  ServicioModel placaServicioSeleccionada = ServicioModel();

  // String _tipoSeleccionado = 'Todos';
  // List<String> _tipoDocumentos = ['Todos'];

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    misServiciosBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    String correo =
       jsonDecode(prefs.usuarioInfo)["sCorreo"];
    misServiciosBloc.cargarMisServicios(correo);
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
    final _size = MediaQuery.of(context).size;
    final _responsive = Responsive(context);
    // misServiciosBloc.cargarMisServicios(usuarioMap['sCorreo']);

    // final usuarioDataStorage = prefs.usuarioInfo;
    // Map<String,dynamic> usuarioData = jsonDecode(usuarioDataStorage);

    return Scaffold(
      body:  Stack(
              children: <Widget>[
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

                            SafeArea(
                                          child: Container(
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
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                                            child: Container(
                                  // margin: EdgeInsets.only(bottom: 10.36),
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

                             Text(
                              "Mis Servicios",
                              style: TextStyle(
        
                              fontFamily: "HelveticaNeue",
                              fontSize: _responsive.ip(3.3),//22,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              color: Colors.white),
                            )
                            ,

                                        Container(
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        StreamBuilder<Object>(
                                            stream: misServiciosBloc.aMisServiciosStream,
                                            builder: (context, snapshot) {
                                              return snapshot.hasData
                                                  ? Container(
                                                      // key: widgetKey,
                                                      height:
                                                          _responsive.ip(15.5), //96,
                                                      margin: EdgeInsets.only(
                                                        top: _responsive.hp(1),
                                                      ),
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                              margin: EdgeInsets.only(
                                                                  left: 13,
                                                                  right: 2,
                                                                  top: 16,
                                                                  bottom: 16),
                                                              width: _responsive
                                                                  .ip(9.6), //63.52,
                                                              height: _responsive
                                                                  .ip(9.6), //64,
                                                              //  child: Image(image: AssetImage('assets/home/gift.png'))
                                                              decoration: new BoxDecoration(
                                        image: DecorationImage(
                                          image: new AssetImage(
                                              'assets/misServicios/misServicios.png',),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      ),
                                      Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical: 17.0),
                                                              child:
                                                                  VerticalDivider()),
                                                          Container(
                                                            margin: EdgeInsets.only(
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
                                             style: TextStyle(
                                              color: Color(0xFFE60012),
                                              // fontFamily: 'HelveticaNeue',
                                              fontFamily: "HelveticaNeue",
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: _responsive
                                                                                .ip(1.75))
                                              // textScaleFactor: 2,
                                              // style: AppConfig.styleTituloCajaPrincipal,
                                            ),
                                            Container(
                                              // padding: EdgeInsets.only(top:4.0, bottom: 4.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(text: misServiciosBloc.aMisServiciosLastValue.totServicios,                                         
                                                    style:TextStyle(
                                                      fontSize: _responsive.ip(3.7),
                                                      fontFamily: 'HelveticaNeue',
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle: FontStyle.normal,
                                                      color: Color(0xFF1C1C1C)
                                                    )
                                                    ),
                                                    TextSpan(text: ' Servicios',
                                                    style:TextStyle(
                                                      fontSize: 15.0,
                                                      fontFamily: 'HelveticaNeue',
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle: FontStyle.normal,
                                                      color: Color(0xFF1C1C1C)
                                                    )
                                                    ),
                                                  ]
                                                )
                                              ),
                                              
                                            ),
                                            
                                            misServiciosBloc.aMisServiciosLastValue.fechaUltimoServicio ==
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
                                                                    : Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                              'Último canje el ',
                                                                              // textScaleFactor: 2,
                                                                              // style: AppConfig.styleSubTituloCajaPrincipal,
                                                                              style: TextStyle(
                                                                                  color: Color(0xFF94949A),
                                                                                  // fontFamily: 'HelveticaNeue',
                                                                                  fontFamily: "HelveticaNeue",
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FontStyle.normal,
                                                                                  fontSize: _responsive.ip(1.75))),
                                                                          Text(
                                                                              '${misServiciosBloc.aMisServiciosLastValue.fechaUltimoServicio}',
                                                                              // textScaleFactor: 2,
                                                                              style: TextStyle(
                                                                                  color: Color(
                                                                                      0xFF94949A),
                                                                                  fontFamily:
                                                                                      "HelveticaNeue",
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                  fontStyle: FontStyle.normal,
                                                                                  fontSize: _responsive.ip(1.75)
                                                                                  //12
                                                                                  )
                                                                                  ),
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
                                ):Container(
                                          margin: EdgeInsets.only(
                                                        top: _responsive.hp(1),
                                                      ),
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                                  left: 13,
                                                                  right: 2,
                                                                  top: 16,
                                                                  bottom: 16),
                                                  width: _responsive
                                                                  .ip(9.6), //63.52,
                                                              height: _responsive
                                                                  .ip(9.6),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xffE5E5E5),
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: _responsive.ip(2.55),),
                                                  child: VerticalDivider()),
                                              Container(
                                                margin: EdgeInsets.only(left: 5),
                                                child: Column(
                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                  children: <Widget>[
                                                    Container(
                                                      height: _responsive.ip(3),
                                                      width: _responsive.ip(20.85),
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
                                                    ),
                                                    Container(
                                                     height: _responsive.ip(3),
                                                      width: _responsive.ip(20.85),
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
                                                    ),
                                                    Container(
                                                      height: _responsive.ip(3),
                                                      width: _responsive.ip(20.85),
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
                                           height:
                                                          _responsive.ip(15.5),
                                        );
                              }
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                                    // width: double.infinity,
                                     margin: EdgeInsets.only(top: 8),
                              child: StreamBuilder<Object>(
                                stream: misServiciosBloc.aMisServiciosStream,
                                builder: ( context,snapshot){
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
                                                    child: _dropDownPlaca( jsonDecode(usuarioMap['aUnidades']), snapshot),
                                              
                                            )
                                            ]
                                  )
                              //     Stack(
                              //   children: <Widget>[
                              //     Container(
                              //         width: double.infinity,
                              //         padding:
                              //             EdgeInsets.only(left: 15.0, top: 8.0,bottom: 8),
                              //         // margin: EdgeInsets.only(
                              //         //     left: 30, right: 24, top: _responsive.hp(29)),
                              //         child: Text(
                              //           'Placa',
                              //           style: TextStyle(
                              //               fontFamily: 'HelveticaNeue',
                              //               fontWeight: FontWeight.bold,
                              //               fontStyle: FontStyle.normal,
                              //               fontSize: 12.0,
                              //               color: Color(0xFFE60012)),
                              //         )),
                              //       Column(
                              //         // mainAxisAlignment: MainAxisAlignment.start,
                              //         // crossAxisAlignment: CrossAxisAlignment.start,
                              //         children: <Widget>[
                              //         SizedBox(height:6),
                              //         _dropDownPlaca( jsonDecode(usuarioMap['aUnidades']), snapshot),
                              //       ],)
                              //     // Text('Placa'),
                                  
                              //   ],
                              // )
                              : Container(
                                margin: EdgeInsets.only(
                                                left: _responsive.ip(1.8), right: _responsive.ip(1.8)),
                                            // margin: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                   margin: EdgeInsets.only(
                                                      top: 7, bottom: 3),
                                                    height: _responsive.ip(1.8),
                                                    width: _responsive.ip(9),
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
                                                    ),
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                                top: 3, bottom: 8),
                                                            height: _responsive.ip(1.8),
                                                            width: _responsive.ip(1.8),
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
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                              },
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 1.0, // soften the shadow
                                          spreadRadius: 1.0, //extend the shadow
                                          offset: Offset(
                                            0.0, // Move to right 10  horizontally
                                            0.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                ],
                              ),
                              //height: 54,
                              height: _responsive.ip(8.1),
                            ),

                                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    Container(
                    margin: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Servicios realizados',
                      // textScaleFactor: 1.5,
                      // style: AppConfig.styleSubCabeceraCajas
                      style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000),
                                fontSize: _responsive.ip(2.4)
                              )
                    ),
                  ),
                  GestureDetector(
                        onTap: () {
                          print("asdasd");
                          misServiciosBloc.aAnioLastValue;

                          Dialogs.dialogSortDateMisServicios(context,
                              title: "Filtrar Por",
                              message:
                                  "Año de Servicio", //jsonDecode(campaniaModel.aConcesionarios)
                              aAnio: misServiciosBloc.aAnioLastValue,
                              misServiciosBloc: misServiciosBloc
                              // aConcesionarios = jsonDecode(campaniaModel['aConcesionarios'])

                              );
                        },
                         child: Container(
                                      margin: EdgeInsets.only( top: 8),
                                      height: 10,
                                      width: 15,
                                      decoration: new BoxDecoration(
                                        image: DecorationImage(
                                          image: new AssetImage(
                                              'assets/misPremios/filtroIcon.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                      )
                  ],),
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




                       

                  


                                    ]

                                  )
                              )

                            ]

                          )

                                          )

                            )

                    ]
                    
                    
                    )
                    
                    ]
                    
                    ),

                         Expanded(
                            child: SingleChildScrollView(
                              child :
                        Container(
                     margin: EdgeInsets.only(left: _responsive.wp(6),right: _responsive.wp(6),),
                          
                          child: _containerMisServicios())
                        
                    
                    ),
                  // ),
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
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown(List aUnidades) {
    Responsive _responsive = new Responsive(context);
    List<DropdownMenuItem<String>> lista = new List();
    if (aUnidades != null) {
      lista.add(DropdownMenuItem(
          child: Text("Todos", style: TextStyle(
                                          fontFamily: 'HelveticaNeue',
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: _responsive.ip(1.8),//12.0,
                                          color: Colors.black)),
          value: "",
        ));
      aUnidades.forEach((elemento) {
        lista.add(DropdownMenuItem(
          child: Text(elemento['sPlaca'],
          style : TextStyle(
                                          fontFamily: 'HelveticaNeue',
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: _responsive.ip(1.8),//12.0,
                                          color: Colors.black)),
          value: elemento['sPlaca'].toString(),
        ));
        print(elemento);
      });
    }
    return lista;
  }

  Widget _dropDownPlaca(List aUnidades, AsyncSnapshot snapshot) {
    Responsive _responsivew = new Responsive(context);
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          DropdownButtonHideUnderline(
            child: Expanded(
              child: Container(
                // padding: EdgeInsets.only(left: 15, right: 8),
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                        isExpanded: true,
                        iconEnabledColor: Color(0xFFE60012),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: _responsivew.ip(3),//20.0,
                        ),
                        value: _placaSeleccionada,
                        items: snapshot.hasData==false?[]:
                        getOpcionesDropdown(aUnidades),
                        onChanged: (opt) {
                          setState(() {
                            _placaSeleccionada = opt;
                            misServiciosBloc.changePlaca(_placaSeleccionada);
                          });
                        })
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _containerMisServicios() {
    
    return StreamBuilder<Object>(
        stream: misServiciosBloc.filterAservicios,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Column(
                children: <Widget>[
                  ContainerMisServicios(
                      aMisServicios: snapshot.data,
                    ),
                ],
              )
              : Column(
                children: <Widget>[
                  _estructuraLoaderMisServicios(),
                  _estructuraLoaderMisServicios(),
                  _estructuraLoaderMisServicios(),
                  
                ],
              );
        });
  }

  Widget _estructuraLoaderMisServicios(){
    final _responsive = Responsive(context);
    return Container(
      margin: EdgeInsets.only(
           bottom: 8.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10,right: 2),
              width: _responsive.ip(5.7),
              height: _responsive.ip(6.6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffE5E5E5),
              )),
          Padding(
              padding: EdgeInsets.symmetric(vertical: _responsive.ip(1.2),),
              child: VerticalDivider()),
          Container(
            margin: EdgeInsets.only(left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: _responsive.ip(1.35),
                  width:  _responsive.ip(20.85),
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
                  width:  _responsive.ip(20.85),
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
                  width:  _responsive.ip(20.85),
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
      height:_responsive.ip(9),
    );
  }

}
