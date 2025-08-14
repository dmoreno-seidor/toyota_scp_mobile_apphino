import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/models/ciudad_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/Provider.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/campania_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/ciudad_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_campanias.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_campanias_loading.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_concesionario_citas_loading.dart';

import '../comportamiento_usuario/comportamiento_usuario.dart';

class CampaniasPage extends StatefulWidget {
  CampaniasPage({Key key}) : super(key: key);
  static final String routeName = 'campanias';
  @override
  _CampaniasPageState createState() => _CampaniasPageState();
}

class _CampaniasPageState extends State<CampaniasPage>
    with WidgetsBindingObserver {
  String _ciudadSeleccionada = '';

  CiudadBloc ciudadBloc = CiudadBloc();
  CampaniaBloc campaniaBloc = CampaniaBloc();
  StreamSubscription<Position> _positionStream;
  PermissionHandler _permissionHandler = PermissionHandler();
  PreferenciasUsuario prefs = PreferenciasUsuario();
  // var _isChecking = true;
  Location location = new Location();
  bool _serviceEnabled;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    ciudadBloc.cargarCiudades();
    //  Future.delayed(Duration.zero, () {

    //       campaniaBloc = Provider.campaniaBloc(context);

    //         });
  }

  // @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_positionStream != null) {
      _positionStream.cancel();
      _positionStream = null;
    }
    super.dispose();
    // campaniaBloc.dispose();
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
      // _check();
    }
  }

  //comprobar si tenemos acceso a la ubicacion del dispositivo
  //  _check() async{
  //  final status = await _permissionHandler
  //  .checkPermissionStatus(PermissionGroup.locationWhenInUse);
  //   if(status == PermissionStatus.granted){
  //     _getLocation();
  //     // Navigator.pushReplacementNamed(context, 'mapsPage' , arguments: widget.posiConcesionario); //elimino del historial la pantalla del Splash
  //   }else {
  //     String correo =
  //      jsonDecode(prefs.usuarioInfo)["sCorreo"];
  //       campaniaBloc.cargarCampania(correo, 12.00,-17.00, "");
  //     // campaniaBloc.cargarCampania("wguill@gmail.com", 12.00,-17.00, "105");
  //     // setState(() {
  //     //   _isChecking = false;
  //     // });
  //   }
  // }

  // _request()async{
  //   final result = await _permissionHandler.requestPermissions([PermissionGroup.locationWhenInUse]);
  //   if(result.containsKey(PermissionGroup.locationWhenInUse)){
  //     final status = result[PermissionGroup.locationWhenInUse];
  //     if(status == PermissionStatus.granted){
  //       // Navigator.pushReplacementNamed(context, 'mapsPage');
  //     } else if(status == PermissionStatus.denied || status == PermissionStatus.restricted){
  //       final result = await _permissionHandler.openAppSettings();
  //       print('result $result');
  //     }
  //   }
  // }

  // _getLocation() async
  //     {
  //       Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //       debugPrint('location: ${position.latitude}');
  //       final coordinates = new Coordinates(position.latitude, position.longitude);
  //       String correo =
  //      jsonDecode(prefs.usuarioInfo)["sCorreo"];
  //      campaniaBloc.cargarCampania(correo, coordinates.latitude, coordinates.longitude, "");
  //       // campaniaBloc.cargarCampania("wguill@gmail.com", coordinates.latitude, coordinates.longitude, "105");
  //     }

  _test(campaniaBloc) async {
    String correo = jsonDecode(prefs.usuarioInfo)["sCorreo"];
    if (Platform.isIOS) {
      // Position position = await geolocator.Geolocator().getCurrentPosition(desiredAccuracy: geolocator.LocationAccuracy.high);

      //  setState(() {

      campaniaBloc.cargarCampania(correo, prefs.latitude, prefs.longitud, "");

      //  });

      //  await _cargarCampaniaLocation(correo,position.latitude,position.longitude);

    } else {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      final result = await _permissionHandler
          .requestPermissions([PermissionGroup.location]);
      if (result.containsKey(PermissionGroup.location)) {
        final status = result[PermissionGroup.location];
        if (status.value == 1) {
          // LocationData _locationData = await location.getLocation();
          campaniaBloc.cargarCampania(
              correo, prefs.latitude, prefs.longitud, "");
        } else {
          final result = await _permissionHandler.openAppSettings();
          print('result $result');
        }
      }
    }
  }

  _cargarCampaniaLocation(correo, latitude, longitude) {
    campaniaBloc.cargarCampania(correo, latitude, longitude, "");
    // setState(() {

    // });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _responsive = Responsive(context);
    // final campaniaBloc = Provider.campaniaBloc(context);
    _test(campaniaBloc);
    // _check();
    // _request();
// catalogoBloc.cargarCatalogo("USUARIO","",12.00,-17.00,0);
    return Scaffold(
        body:
            // SingleChildScrollView(
            //     child:
            Container(
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
                Container(
                   margin: EdgeInsets.only(
                          left: _responsive.wp(6), //16,
                          // top: _responsive.ip(1),
                          right: _responsive.wp(6), //16,
                        ),
                                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SafeArea(
                        child: Container(
                          margin: EdgeInsets.only(
                            
                            top: _responsive.ip(1),
                             //16,
                          ),
                          child: Text(
                            "Campañas",
                            // style: AppConfig.styleCabecerasPaginas,
                            style: TextStyle(
                                fontFamily: "HelveticaNeue",
                                fontSize: _responsive.ip(3.3), //22,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                StreamBuilder<Object>(
                                    stream: ciudadBloc.ciudadesStream,
                                    builder: (context, snapshot) {
                                      return snapshot.hasData
                                          ? Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(
                                                  // left: _responsive.wp(6),
                                                  // right: _responsive.wp(6),
                                                  top: 8 //_responsive.ip(9.9)

                                                  ),
                                              child: Stack(children: <Widget>[
                                                Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.only(
                                                        left: 16.0,
                                                        bottom:
                                                            _responsive.ip(0.9),
                                                        top: _responsive.ip(1.5)),
                                                    child: Text(
                                                      'Ciudad',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'HelveticaNeue',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize:
                                                              _responsive.ip(1.8),
                                                          color:
                                                              Color(0xFFE60012)),
                                                    )),
                                                Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.only(
                                                        top: _responsive.ip(2.6)),
                                                    child:
                                                        _dropDownCiudad(snapshot))
                                              ]),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white,
                                                boxShadow: [AppConfig.boxShadow],
                                              ),
                                              height: _responsive.ip(8.1) //54,
                                              )
                                          : Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(
                                                  // left: _responsive.wp(6),
                                                  // right: _responsive.wp(6),
                                                  top: 8 //_responsive.ip(9.9)
                                                  ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: _responsive.wp(4),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                      //  margin: EdgeInsets.only(
                                                      //   top: 4),
                                                      height: _responsive.ip(1.5),
                                                      width: _responsive.ip(10.5),
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
                                                  //   height: 10,
                                                  // ),
                                                  Container(
                                                      height: _responsive.ip(1.5),
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
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius:
                                                        1.0, // soften the shadow
                                                    spreadRadius:
                                                        1.0, //extend the shadow
                                                    offset: Offset(
                                                      0.0, // Move to right 10  horizontally
                                                      0.0, // Move to bottom 10 Vertically
                                                    ),
                                                  )
                                                ],
                                              ),
                                              height: _responsive.ip(8.1) //54
                                              );
                                    }),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          // left: _responsive.wp(6),
                                          // right: _responsive.wp(6),
                                          top: 8),
                                      child: Text(
                                        'Más recientes',
                                        // style: AppConfig.styleSubCabecerasPaginas,
                                        style: TextStyle(
                                            // fontFamily: 'HelveticaNeue',
                                            fontFamily: "HelveticaNeue",
                                            fontSize: _responsive.ip(2.4), //16,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                             top: 8.0),
                                        child: Divider(
                                            color: Color(0xFFFFFFFF),
                                            endIndent: _responsive.wp(78.0),
                                            height: 5.0,
                                            thickness: 2.5)),
                                    // SizedBox(height: 8.0),
                                  ],
                                ),
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
          )
          ),

           Container(
                      // padding: EdgeInsets.only(top: 20),
                      margin: EdgeInsets.only(top:_responsive.hp(28)
                      , 
                          left: _responsive.wp(6), //16,
                          
                          right: _responsive.wp(6), //16,
                        ),
                      child: new SingleChildScrollView(
                        
                        //  child:   Column(
                        //    children: <Widget>[
                          child:   containerCampania(),
                          //  ],
                        //  ),
                          
                        
                      ),
                    ),
        
        ],

        // )
      ),
    )
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdownCiudad(
      BuildContext context, List<CiudadModel> ciudades) {
    Responsive _responsive = new Responsive(context);
    List<DropdownMenuItem<String>> lista = new List();
    if (ciudades != null) {
      lista.add(DropdownMenuItem(
        child: Text("Todos",
            style: TextStyle(
                fontFamily: 'HelveticaNeue',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: _responsive.ip(1.8), //12.0,
                color: Colors.black)),
        value: "",
      ));
      ciudades.forEach((elemento) {
        lista.add(DropdownMenuItem(
          child: Text(elemento.descripcion,
              style: TextStyle(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: _responsive.ip(1.8), //12.0,
                  color: Colors.black)),
          value: elemento.id.toString(),
        ));
        print(elemento);
      });
    }

    return lista;
  }

  Widget _dropDownCiudad(snapshot) {
    Responsive _responsive = new Responsive(context);
    return Container(
      child: Row(
        children: <Widget>[
          DropdownButtonHideUnderline(
            child: Expanded(
              child: Container(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                      iconEnabledColor: Color(0xFFE60012),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: _responsive.ip(3), //20.0,
                      ),
                      value: _ciudadSeleccionada,
                      items: snapshot.hasData == false
                          ? []
                          : getOpcionesDropdownCiudad(context, snapshot.data),
                      onChanged: (opt) {
                        setState(() {
                          _ciudadSeleccionada = opt;
                          campaniaBloc.changeCiudad(_ciudadSeleccionada);
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

  Widget containerCampania() {
    // return Text("test");
    return StreamBuilder<Object>(
      stream: campaniaBloc.filterCampanias,
      builder: (context, snapshot) {
        return AnimatedSwitcher(
            duration: const Duration(seconds: 2),
            child: snapshot.hasData && campaniaBloc != null
                ? Column(
                    children: <Widget>[
                      ContainerCampanias(
                        aCampanias: snapshot.data,
                      ),
                    ],
                  )
                : SingleChildScrollView(child: ContainerCampaniasLoading()));
      },
    );
  }
}
