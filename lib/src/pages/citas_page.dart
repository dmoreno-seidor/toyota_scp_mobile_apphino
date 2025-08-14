import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/Provider.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/usuario_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_concesionario_citas_loading.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import '../app_config.dart';
import '../preferencias_usuario/preferencias_usuario.dart';
import '../utils/responsive.dart';
import '../models/ciudad_model.dart';
import './bloc/ciudad_bloc.dart';
import './bloc/tipo_servicio_bloc.dart';
import './bloc/citas_bloc.dart';
import '../widgets/container_citas_categorias.dart';
import '../widgets/container_concesionario_citas.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';

class CitasPage extends StatefulWidget {
  CitasPage({Key key}) : super(key: key);

  static final String routeName = "citas";

  @override
  _CitasPageState createState() => _CitasPageState();
}

class _CitasPageState extends State<CitasPage> with WidgetsBindingObserver {
  String _ciudadSeleccionada = '';
  String _serviciosElegidos = '';
  final prefs = new PreferenciasUsuario();
Location location = new Location();
bool _serviceEnabled;
  CiudadBloc ciudadBloc = new CiudadBloc();
  TipoServicioBloc tipoServicioBloc = new TipoServicioBloc();
  CitasBloc citasBloc = new CitasBloc();
  PermissionHandler _permissionHandler = PermissionHandler();
  StreamSubscription<Position> _positionStream;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Cargar listas
    ciudadBloc.cargarCiudades();
    tipoServicioBloc.cargarTipoServicio();
 
    
    // DJCC: Registrar el Comportamiento Usuario
    ComportamientoUsuario.registrarEvento(prefs, ingresoModuloCitas: true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    // ciudadBloc?.dispose();
    // tipoServicioBloc?.dispose();
    // citasBloc?.dispose();
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

  // consultarConcesionarios() async {
  //   Position position = await Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  //   _ciudadSeleccionada = '';
  //   _serviciosElegidos = '';
  //   citasBloc.consultarConcesionarioxCiudadxServicios(_ciudadSeleccionada,
  //       _serviciosElegidos, position?.latitude, position?.longitude);
  // }


    _test(citasBloc)async{
String correo = jsonDecode(prefs.usuarioInfo)["sCorreo"];
if(Platform.isIOS){
    //  Position position = await geolocator.Geolocator().getCurrentPosition(desiredAccuracy: geolocator.LocationAccuracy.high);
  
 
    // _ciudadSeleccionada = '';
    // _serviciosElegidos = '';
     
    citasBloc.consultarConcesionarioxCiudadxServicios(_ciudadSeleccionada,_serviciosElegidos, prefs.latitude, prefs.longitud);
  
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
    //     _ciudadSeleccionada = '';
    // _serviciosElegidos = '';
    citasBloc.consultarConcesionarioxCiudadxServicios(_ciudadSeleccionada,
        _serviciosElegidos, prefs.latitude, prefs.longitud);
        }else{
          final result = await _permissionHandler.openAppSettings();
             print('result $result');
        }
      }

}

           
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _responsive = Responsive(context);
    // final citasBloc = Provider.citasBloc(context);
 
    _test(citasBloc);

    return Scaffold(
        body:  Stack(
      children: <Widget>[
        Column(
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
                      // margin: EdgeInsets.only(
                      //     left: _responsive.wp(6), right: _responsive.wp(6)),
                      margin: EdgeInsets.only(
                          left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Citas",
                            // style: AppConfig.styleCabecerasPaginas,
                            style: TextStyle(
                                // fontFamily: 'HelveticaNeue',
                                fontFamily: "HelveticaNeue",
                                fontSize: _responsive.ip(3.3),//22,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                color: Colors.white),
                          ),
                          _buildDropdownCiudades(context),
                          _buildTituloServiciosDisponibles(context),
                          // _buildTituloTalleresCercanos(context),
                        ],
                      ),
                    ),
                  ),
                ),
               
              ],
            ),
            _buildTituloTalleresCercanos(context),
            Expanded(
                          child: SingleChildScrollView(
                child: _buildListaConcesionarios(context)),
            ),
          ],
        ),
        Positioned(
          top: _responsive.hp(28.5),
          left: 0.0,
          right: 0.0,
          child: _buildFiltroBusqueda(context),
        ),
      ],
    ));
  }

  Widget _buildDropdownCiudades(BuildContext context) {
    final _responsive = Responsive(context);

    return Container(
      margin: EdgeInsets.only(top: _responsive.hp(1.5)),
      child: StreamBuilder<Object>(
          stream: ciudadBloc.ciudadesStream,
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
                                                  'Ciudad',
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
                                                child: _dropDownCiudad(snapshot)),
                                          ],
                                        )


                : Container(
                            margin: EdgeInsets.only(
                                            left: 12, right: 12),
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
                                                height: 12,
                                                width: 60,
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
                                                        height: 12,
                                                        width: 12,
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
          }
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
                          // height: 54,
                          height: _responsive.ip(8.3),
                        
    );
  }

  Widget _dropDownCiudad(dynamic snapshot) {
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
                        size: 30.0,
                      ),
                      value: _ciudadSeleccionada,
                      items: getOpcionesDropdownCiudad(context, snapshot),
                      onChanged: (opt) async {
                        // Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                        setState(() {
                          _ciudadSeleccionada = opt;
                          citasBloc.changeCiudad(_ciudadSeleccionada);
                          // citasBloc.consultarConcesionarioxCiudadxServicios(
                          //   citasBloc.sFiltroCiudad, citasBloc.sFiltroServicios, position?.latitude, position?.longitude);
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

  List<DropdownMenuItem<String>> getOpcionesDropdownCiudad(
      BuildContext context, dynamic snapshot) {
        Responsive _responsive = new Responsive(context);
    if (!snapshot.hasData) {
      return [];
    }
    List<CiudadModel> ciudades = snapshot.data;
    List<DropdownMenuItem<String>> lista = new List();
    if (ciudades != null) {
      lista.add(DropdownMenuItem(
        child: Text("Todos", 
        // style: AppConfig.styleTextDropDown,
        style : TextStyle(
                                          fontFamily: 'HelveticaNeue',
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: _responsive.ip(1.8),//12.0,
                                          color: Colors.black)
        ),
        value: "",
      ));
      ciudades.forEach((elemento) {
        lista.add(DropdownMenuItem(
          child: Text(elemento.descripcion,
          style : TextStyle(
                                          fontFamily: 'HelveticaNeue',
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: _responsive.ip(1.8),//12.0,
                                          color: Colors.black)),
          value: elemento.id.toString(),
        ));
      });
    }
    return lista;

    
  }

  Widget _buildTituloServiciosDisponibles(BuildContext context) {
    final _responsive = Responsive(context);

    return Container(
      // margin: EdgeInsets.only(top: 8),
      margin: EdgeInsets.only(top: _responsive.hp(2.5)),
        
        child: Container(
          // margin: EdgeInsets.only(left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment:
            //     MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
               
                child: Text(
                  "Servicios disponibles",
                  // style: AppConfig.styleSubCabecerasPaginas,
                  style: TextStyle(
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontSize: _responsive.ip(2.45),
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildFiltroBusqueda(BuildContext context) {
    Responsive _responsive = new Responsive(context);
    return StreamBuilder<Object>(
        stream: tipoServicioBloc.tipoServiciosStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? 
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(
                                // top : _responsive.hp(2),
                                // left: 22,
                               ),
                            height: _responsive.ip(16.5),//110.0,
                            child: ContainerCitasCategorias(
                                aCategorias: snapshot.data, citasBloc: citasBloc)),
                      ],
                    )
                  // ],
                // )
              : _estructuraLoaderCategorias();
        });
  }

  Widget _estructuraLoaderCategorias() {
    Responsive _responsive = new Responsive(context);
    return Container(
        // margin: EdgeInsets.only(top: 0, left: 16, bottom: 3),
        margin: EdgeInsets.only(
                                // top : _responsive.hp(2),
                                left: 22,
                                right: 12),
        height: _responsive.ip(16.5),//120.0,
        child: new ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            loaderCircularCategoria(),
            loaderCircularCategoria(),
            loaderCircularCategoria(),
            loaderCircularCategoria(),
            // loaderCircularCategoria(),
            // loaderCircularCategoria(),
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
             width: _responsive.ip(9.6),
              height: _responsive.ip(9.6),
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

  Widget _buildTituloTalleresCercanos(BuildContext context) {
    final _responsive = Responsive(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              left: _responsive.wp(6), right: _responsive.wp(6), top: _responsive.hp(11)),
          child: Text(
            'Cercanos a ti',
            //  style: AppConfig.styleSubCabeceraCajas
            style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000),
                            fontSize: _responsive.ip(2.4),
                            
                          ),
          ),
        ),
        Container(
                              margin: EdgeInsets.only(
                                  left: _responsive.wp(6),
                                  top: 7.0,
                                  bottom: 15.0),
                              child: Divider(
                                  color: Color(0xFFE60012),
                                  endIndent: _responsive.wp(85.0),
                                  height: 5.0,
                                  thickness: 1)),
        // SizedBox(height: 10.0),
        // containerCampania(),
      ],
    );
  }

  Widget _buildListaConcesionarios(BuildContext context) {
    return 
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child:
       StreamBuilder(
        stream: citasBloc.filterConcesionarios,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // return snapshot.hasData
          //     ? ContainerConcesionarioCitas(
          //         aConcesionarioList: snapshot.data,
          //         citasBloc: citasBloc,
          //         prefs: prefs)
          //     : Container();

          return AnimatedSwitcher(
                    duration: const Duration(seconds: 2),
                    child: snapshot.hasData
              ? ContainerConcesionarioCitas(
                  aConcesionarioList: snapshot.data,
                  citasBloc: citasBloc,
                  prefs: prefs)
                      :  ContainerConcesionarioCitasLoading()
                  );
        },
      ),
    );
  }
}
