import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/models/usuario_location.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/catalogo_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/mis_puntos_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/usuario_bloc.dart';
// import 'package:toyota_scp_mobile_apphino/src/providers/location_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_catalogo.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_catalogo_categorias.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/formatters.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_catalogo_loading.dart';

import 'bloc/Provider.dart';
import 'bloc/grupo_familia_bloc.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';

class CatalogoPage extends StatefulWidget {
  CatalogoPage({Key key}) : super(key: key);
  static final String routeName = "catalogo";
  @override
  _CatalogoPageState createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> with WidgetsBindingObserver {
  final prefs = new PreferenciasUsuario();
  MisPuntosBloc misPuntosBloc = new MisPuntosBloc();
  UsuarioBloc usuarioBloc = new UsuarioBloc();
  CatalogoBloc catalogoBloc = new CatalogoBloc();
  GrupoFamiliaBloc grupoFamiliaBloc = new GrupoFamiliaBloc();
  StreamSubscription<Position> _positionStream;
Location location = new Location();
PermissionHandler _permissionHandler = PermissionHandler();
  bool _serviceEnabled;
  // PermissionHandler _permissionHandler = PermissionHandler();
// PermissionStatus _permissionGranted;
bool cargando=true;

  // @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if(_positionStream !=null){
      _positionStream.cancel();
      _positionStream = null;
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    grupoFamiliaBloc.cargarGrupoFamilias();
    // catalogoBloc = 
    Future.delayed(Duration.zero, () {
    //   setState(() {
        catalogoBloc = Provider.catalogoBloc(context);
    //       _test();
          });
    // });
    
  
    // DJCC: Registrar el Comportamiento Usuario
    ComportamientoUsuario.registrarEvento(prefs, ingresoModuloCatalogo: true);
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

  _test(catalogoBloc) async{
String correo = jsonDecode(prefs.usuarioInfo)["sCorreo"];
if(Platform.isIOS){
    // Position position = await geolocator.Geolocator().getCurrentPosition(desiredAccuracy: geolocator.LocationAccuracy.high);
   
  //  setState(() {
      catalogoBloc.cargarCatalogo(correo, "", prefs.latitude, prefs.longitud, 0);
  //  });
  
      //  await _cargarCatalogoLocation(correo,position.latitude,position.longitude);
   
}else{

_serviceEnabled = await location.serviceEnabled();
if (!_serviceEnabled) {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled) {
    return;
  }
}

  final result = await _permissionHandler.requestPermissions([PermissionGroup.location]);
    if(result.containsKey(PermissionGroup.location)){
      final status = result[PermissionGroup.location];
        if(status.value==1){
          // LocationData _locationData = await location.getLocation();
        _cargarCatalogoLocation(correo,prefs.latitude, prefs.longitud);
        }else{
          final result = await _permissionHandler.openAppSettings();
             print('result $result');
        }
      }

}

           
  }


_cargarCatalogoLocation(correo,latitude,longitude){
    catalogoBloc.cargarCatalogo(correo, "", latitude, longitude, 0);
                  // setState(() {
                cargando =false;
                  // });
}

  





  @override
  Widget build(BuildContext context) {
    usuarioBloc.consultarDataCliente2(prefs.iId);
    final catalogoBloc = Provider.catalogoBloc(context);
    _test(catalogoBloc);
    // catalogoBloc.cargarCatalogo(usuario, grupoFamilia, latitud, longitud, more)
    
    final _responsive = Responsive(context);
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      
      body: Container(
                child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      color: Color(0xFFE60012),
                      width: _size.width,
                      height: _responsive.hp(36.0),
                    ),
                    Positioned(
                      top: 10.0,
                      left: 0.0,
                      right: 0.0,
                      child: SafeArea(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: _responsive.wp(6),
                              right: _responsive.wp(6),
                              // top: _responsive.hp(2)
                              ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Catálogo",
                                style: TextStyle(
      
                          fontFamily: "HelveticaNeue",
                          fontSize: _responsive.ip(3.3),//22,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),
                              ),

                              Container(
                                // height: _responsive
                                //                         .ip(15.5), //96,
                                                    margin: EdgeInsets.only(
                                                      top: _responsive.hp(1),
                                                    ),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                      child: 
                          StreamBuilder<Object>(
                            stream: usuarioBloc.oUsuarioStream,
                            builder: (context, snapshot) {
                              return Column(
                                children: <Widget>[
                                  snapshot.hasData
                                      ? 
                                      Container(
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
                                    Container(
                                      height: 64,
                                      child: VerticalDivider(
                                        thickness: 1,
                                          
                                    )),
                                    Container(
                                      margin: EdgeInsets.only(left: 7.5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                fontSize: _responsive.ip(1.75) ),
                                            // AppConfig
                                            //     .styleTituloCajaPrincipal,
                                          ),
                                          Container(
                                            // padding: EdgeInsets.only(
                                            //     top: 2.0, bottom: 2.0),
                                            child: RichText(
                                                text: TextSpan(children: <
                                                    TextSpan>[
                                              TextSpan(
                                                  text:
                                                      '${formatPuntos(usuarioBloc.oUsuario.iPuntosAcumulados)}',
                                                  style: TextStyle(
                                                      fontSize: _responsive.ip(3.7),
                                                      fontFamily:
                                                          'HelveticaNeue',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color:
                                                          Color(0xFF1C1C1C))),
                                              TextSpan(
                                                  text: '  Puntos',
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontFamily:
                                                          'HelveticaNeue',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color:
                                                          Color(0xFF1C1C1C))),
                                            ])),
                                           
                                          ),

                                          // usuarioBloc.oUsuario.dPuntosFechaVencimiento==""?
                                          usuarioBloc.oUsuario.iPuntosAcumulados==0?
                                          Text("No Existe Vigencia",
                                          style: TextStyle(
                                                                                color: Color(0xFF94949A),
                                                                                // fontFamily: 'HelveticaNeue',
                                                                                fontFamily: "HelveticaNeue",
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: _responsive.ip(1.75))
                                          ):
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                  Text(
                              'Algunos puntos vencen en',
                              // textScaleFactor: 2,
                              style: TextStyle(
                                                                              color: Color(0xFF94949A),
                                                                              // fontFamily: 'HelveticaNeue',
                                                                              fontFamily: "HelveticaNeue",
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: _responsive.ip(1.75))
                            ),
                            Text(
                              // '${formatObtenerNombreMesAnio(usuarioBloc.oUsuario.dPuntosFechaVencimiento)}',
                              '${formatObtenerNombreMesAnioV2(usuarioBloc.oUsuario.dPuntosFechaVencimiento)}',
                              // textScaleFactor: 2,
                              style: TextStyle(
                              color: Color(0xFF94949A),
                              fontFamily: "HelveticaNeue",
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                             fontSize: _responsive.ip(1.75))
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
                               
                              )
                                      : Container(
                                        margin: EdgeInsets.only( top: 8),
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 13,
                                                    top: 10,
                                                    bottom: 10,
                                                     right: 5
                                                    ),
                                                  width: 72.0,
                                                  height: 70.5,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xffE5E5E5),
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 17.0),
                                                  child: VerticalDivider()),
                                              Container(
                                                margin: EdgeInsets.only(left: 12),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      height: 20,
                                                      width: _responsive.wp(40),
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
                                                      height: 20,
                                                      width: _responsive.wp(42),
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
                                                      height: 20,
                                                      width: _responsive.wp(42),
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
                                          // height: _responsive.ip(14.4)//96,
                                          height: _responsive
                                                        .ip(15.5)
                                        ),
                                  
Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.only(
                                                   top: _responsive.ip(1.0)//11
                                                   ),
                                              
                                                  child: Text(
                                                    "Categorías",
                                                   
                                                    style: TextStyle(
                                                      // fontFamily: 'HelveticaNeue',
                                                      fontFamily: "HelveticaNeue",
                                                      fontSize: _responsive.ip(2.4),//16,
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle: FontStyle.normal,
                                                      color: Colors.white),
                                                  ),
                                                ),

                                  
                                ],
                              );
                            }
                          ),
                        
                      
                    )
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Container(
                    //   child: Stack(
                    //     children: <Widget>[
                    //       Column(
                    //         children: <Widget>[

                    //           Container(
                    //             width: double.infinity,
                                
                    //             margin: EdgeInsets.only(
                    //                 left: _responsive.wp(6),
                    //                 right: _responsive.wp(6),
                    //                 top: _responsive.hp(29)),
                    //                 child: 
                    //                 Stack(
                    //                     children: <Widget>[
                    //                       Container(
                    //                           width: double.infinity,
                    //                           padding: EdgeInsets.only(
                    //                                top: _responsive.ip(1.5)//11
                    //                                ),
                                              
                    //                               child: Text(
                    //                                 "Categorías",
                                                   
                    //                                 style: TextStyle(
                    //                                   // fontFamily: 'HelveticaNeue',
                    //                                   fontFamily: "HelveticaNeue",
                    //                                   fontSize: _responsive.ip(2.4),//16,
                    //                                   fontWeight: FontWeight.bold,
                    //                                   fontStyle: FontStyle.normal,
                    //                                   color: Colors.white),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                                          
                    //                 //  height: 10,
                    //               ),
                    //         ])]))

                    
                    
                  ],
                ),
                
                    Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        StreamBuilder<Object>(
                          stream: grupoFamiliaBloc.grupoFamiliasStream,
                          builder: (context, snapshot) {

                            return snapshot.hasData?Container(
                                // margin: EdgeInsets.only(top: 8.5, left: 16),
                                margin: EdgeInsets.only(top: 8.5),
                                height: _responsive.ip(15.5),//84.0,
                                child: ContainerCatalogoCategorias(
                                  aCategorias: snapshot.data,
                                  catalogoBloc: catalogoBloc
                                )): _estructuraLoaderCategorias();
                          }
                        ),
                      ],
                    )
                    ,
                Column(
                  children: <Widget>[
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // SizedBox(height: 15.0),
                        Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Text(
                            'Premios disponibles',
                            // style: AppConfig.styleSubCabeceraCajas
                            style: TextStyle(
                              // fontFamily: 'HelveticaNeue',
                              fontFamily: "HelveticaNeue",
                              fontSize: _responsive.ip(2.4),//16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              color: Colors.black),
                                                  ),
                        ),
                        Container(
                        margin:
                            EdgeInsets.only(left: _responsive.wp(6), top: 7.0, bottom: 5.0),
                        child: Divider(
                            color: Color(0xFFE60012),
                            endIndent: _responsive.wp(84.0),
                            height: 5.0,
                            thickness: 1)),
                                // SizedBox(height: 8,)
                      ],
                    ),
                  ],
                ),
                estructuraPremiosDisponibles(_responsive,catalogoBloc)
              ],
            ))
          

      // bottomNavigationBar: _crearBootomNavigationbar()
    );
  }

  void filterSearchResults(String query) {
    misPuntosBloc.filtrarPorPlaca(query);
  }

  Widget _estructuraLoaderCategorias() {
    Responsive _responsive = new Responsive(context);
    return Container(
        margin: EdgeInsets.only(top: 3, left: 18),
        height: _responsive.ip(13.6),//84.0,
        child: new ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            loaderCircularCategoria(),
            loaderCircularCategoria(),
            loaderCircularCategoria(),
            loaderCircularCategoria(),
            loaderCircularCategoria(),
            loaderCircularCategoria(),
          ],
        ));
  }

  Widget loaderCircularCategoria() {
    Responsive _responsive = new Responsive(context);
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: _responsive.ip(9.6),//60.0,
              height: _responsive.ip(9.6),//60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffE5E5E5),
              )),
          Container(
            margin: EdgeInsets.only(top: 4),
            height: 12,
            width: 70,
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
    );
  }

  Widget estructuraPremiosDisponibles(Responsive _responsive,CatalogoBloc catalogoBloc) {
    return 
    
    
    Expanded(
      child: SingleChildScrollView(
        child: 
      //  cargando?ContainerCatalogoLoading():
             
             StreamBuilder<Object>(
               stream: catalogoBloc.filterCatalogos, 
               builder: (context, snapshot) {


                  return AnimatedSwitcher(
                    duration: const Duration(seconds: 2),
                    child: snapshot.hasData && catalogoBloc!=null
                      ? 
                      ContainerCatalogo(
                                        aCatalogo: snapshot.data,
                                        catalogoBloc: catalogoBloc
                                      )
                      :  ContainerCatalogoLoading()
                  );


               }
             )
 
      ),
    );
  }
}


