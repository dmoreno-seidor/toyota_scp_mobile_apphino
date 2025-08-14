import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/estilos.dart';
import 'package:toyota_scp_mobile_apphino/src/models/catalogo_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/concesionario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/Provider.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/catalogo_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/mis_puntos_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/usuario_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_campanias_loading.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_catalogo_loading.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_color.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_concesionario_detalle_premio.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_detalle_premio_loading.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_talla_tamanio.dart';

import '../comportamiento_usuario/comportamiento_usuario.dart';

class DetallePremioPage extends StatefulWidget {
  DetallePremioPage({Key key}) : super(key: key);
  static final String routeName = "detallePremio";
  @override
  _DetallePremioPageState createState() => _DetallePremioPageState();
}

class _DetallePremioPageState extends State<DetallePremioPage>
    with WidgetsBindingObserver {
  final prefs = new PreferenciasUsuario();
  MisPuntosBloc misPuntosBloc = new MisPuntosBloc();
  UsuarioBloc usuarioBloc = new UsuarioBloc();
  CatalogoBloc catalogoBloc = new CatalogoBloc();
  PermissionHandler _permissionHandler = PermissionHandler();
  CatalogoModel catalogoModel;
  // var _isChecking = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Future.delayed(Duration.zero, () {
      catalogoBloc = Provider.catalogoBloc(context);
      setState(() {
        //     final userLocation = Provider.locationService(context);
        //  print(userLocation);
        catalogoModel = ModalRoute.of(context).settings.arguments;
      });
    });
    _check();
    _request();
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
      _check();
    }
  }

  _check() async {
    final status = await _permissionHandler
        .checkPermissionStatus(PermissionGroup.locationWhenInUse);
    if (status == PermissionStatus.granted) {
      _startTracking();
      // Navigator.pushReplacementNamed(context, 'mapsPage' , arguments: widget.posiConcesionario); //elimino del historial la pantalla del Splash
    } else {
      String codigo = catalogoModel.codigo;
      //  catalogoBloc.consultarConcesionarioxPremio(codigo,12.00, -17.00);
      catalogoBloc.consultarConcesionarioxPremio(
          codigo, prefs.latitude, prefs.longitud);

      // campaniaBloc.cargarCampania("wguill@gmail.com", 12.00,-17.00, "105");
      // setState(() {
      //   _isChecking = false;
      // });
    }
  }

  _request() async {
    final result = await _permissionHandler
        .requestPermissions([PermissionGroup.locationWhenInUse]);
    if (result.containsKey(PermissionGroup.locationWhenInUse)) {
      final status = result[PermissionGroup.locationWhenInUse];
      if (status == PermissionStatus.granted) {
        // Navigator.pushReplacementNamed(context, 'mapsPage');
      } else if (status == PermissionStatus.denied ||
          status == PermissionStatus.restricted) {
        final result = await _permissionHandler.openAppSettings();
        print('result $result');
      }
    }
  }

  _startTracking() {
    // final geolocator = Geolocator();
    // final locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 5); // precision lo mas alto posible
    // Position position =  await _getLocation();//geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // print(position);
    _getLocation();
    // _positionStream = geolocator.getPositionStream(locationOptions).listen(_onlocationUpdate);
  }

  _getLocation() async {
    // Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(prefs.latitude, prefs.longitud);
    //   String correo =
    //  jsonDecode(prefs.usuarioInfo)["sCorreo"];
    String codigo = catalogoModel.codigo; //.split(".")[1];
    catalogoBloc.consultarConcesionarioxPremio(
        codigo, coordinates.latitude, coordinates.longitude);
  }

  @override
  Widget build(BuildContext context) {
    final _responsive = Responsive(context);
    final _size = MediaQuery.of(context).size;
    // final catalogoBloc = Provider.catalogoBloc(context);
    return Scaffold(
        // body: SingleChildScrollView(
        // physics: ScrollPhysics(),
        body: Container(
      child: Stack(
        children: <Widget>[
          new Positioned(
            // top: 10.0,

            child: new Container(
              width: _responsive.wp(100),
              height: _responsive.hp(36),
              decoration: new BoxDecoration(color: Color(0xFFE60012)),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SafeArea(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: _responsive.wp(6),
                                right: _responsive.wp(6)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10),
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
                                  ),
                                  onTap: () {
                                    catalogoBloc
                                        .changeDescripcionAdicionalColor("");
                                    catalogoBloc
                                        .changeDescripcionAdicionalTalla("");
                                    List<ConcesionarioModel> c =
                                        new List<ConcesionarioModel>();
                                    catalogoBloc.changeConcesionario(
                                       null);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Container(
                                  child: Text(
                                    "Detalle del Premio",
                                    // style: AppConfig.styleCabecerasPaginas,
                                    style: TextStyle(
                                        // fontFamily: 'HelveticaNeue',
                                        fontFamily: "HelveticaNeue",
                                        fontSize: _responsive.ip(3.3),
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            // margin: EdgeInsets.only(top: _responsive.ip(1.2)), //8),
margin: EdgeInsets.only(top: _responsive.hp(16)), 
            child: Container(
              child: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: _responsive.wp(6),
                              right: _responsive.wp(6),
                              // top: _responsive.hp(13)
                              ),
                          width: MediaQuery.of(context).size.width,
                          // padding: EdgeInsets.all(10),
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                          top: 25,
                                          // left: _responsive.wp(22),
                                          // right: _responsive.wp(22),
                                        ),
                                        height: _responsive.ip(24.6), //164.0,
                                        width: _responsive.ip(24.6), //164.0 ,
                                        // width: MediaQuery.of(context).size.width - 100.0,
                                        child: catalogoModel != null
                                            ? Hero(
                                                tag:
                                                    '${catalogoModel.codigo}-catalogo', //"id",
                                                child: Image.network(
                                                  catalogoModel.imagen.replaceAll(
                                                      '/bridge/',
                                                      "${AppConfig.api_host_docService}"),
                                                  fit: BoxFit.fill,
                                                ))
                                            : Container(),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          //  color: Colors.blue,
                                          // image: DecorationImage(
                                          //     image: new NetworkImage(
                                          //         "https://http2.mlstatic.com/polos-de-moda-D_NQ_NP_590315-MPE25203895704_122016-F.webp"),
                                          //     fit: BoxFit.fill))
                                        )),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 15, top: _responsive.ip(1.8) //12
                                        ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(bottom: 4.5),
                                          child: catalogoModel != null
                                              ? Text(
                                                  catalogoModel.codigo,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines:
                                                      1, //"Casaca Deportiva GHZ89",
                                                  // style:AppConfig.styleCodigoDetallePremio,
                                                  style: TextStyle(
                                                      color: Color(0xFF94949A),
                                                      // fontFamily: 'HelveticaNeue',
                                                      fontFamily:
                                                          "HelveticaNeue",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize:
                                                          _responsive.ip(1.8)),
                                                )
                                              : Container(),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 13),
                                          child: catalogoModel != null
                                              ? Text(catalogoModel.descrip,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      // fontFamily: 'HelveticaNeue',
                                                      fontFamily:
                                                          "HelveticaNeue",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize:
                                                          _responsive.ip(2.1)))
                                              : Container(),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 8),
                                          child: Text("Medida",
                                              // style: AppConfig.styleTituloDetallePremioCaracteristica
                                              style: TextStyle(
                                                  color: Color(0xFFE60012),
                                                  // fontFamily: 'HelveticaNeue',
                                                  fontFamily: "HelveticaNeue",
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize:
                                                      _responsive.ip(1.8))),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            catalogoModel != null
                                                ? Expanded(
                                                    child: ContainerTallaTamanio(
                                                        aTallaTamanio:
                                                            jsonDecode(
                                                                catalogoModel
                                                                    .aTallas),
                                                        catalogoBloc:
                                                            catalogoBloc),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 14, bottom: 8),
                                          child: Text(
                                            "Color",
                                            // style: AppConfig.styleTituloDetallePremioCaracteristica
                                            style: TextStyle(
                                                color: Color(0xFFE60012),
                                                // fontFamily: 'HelveticaNeue',
                                                fontFamily: "HelveticaNeue",
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.normal,
                                                fontSize: _responsive.ip(1.8)),
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            catalogoModel != null
                                                ? Expanded(
                                                    child: ContainerColor(
                                                      aColor: jsonDecode(
                                                          catalogoModel
                                                              .aColores),
                                                      catalogoBloc:
                                                          catalogoBloc,
                                                    ),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              new Positioned(
                                  top: 16.0,
                                  right: 0.0,
                                  child: Container(
                                    height: 32,
                                    padding:
                                        EdgeInsets.only(left: 13, right: 12.5),
                                    child: Center(
                                        child: catalogoModel != null
                                            ? Text(
                                                "${catalogoModel.puntos} Puntos", //"1000 Puntos",
                                                textAlign: TextAlign.center,
                                                style: EstilosConfig
                                                    .styleEtiquetaPuntos,
                                              )
                                            : Text(
                                                "",
                                                textAlign: TextAlign.center,
                                                style: EstilosConfig
                                                    .styleEtiquetaPuntos,
                                              )),
                                    decoration: BoxDecoration(
                                      color: Color(0xffFFC702),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          bottomLeft: Radius.circular(25)),
                                    ),
                                  )),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [AppConfig.boxShadow],
                          ),
                          height: _responsive.ip(55.2), //368
                        ),
                        Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                left: _responsive.wp(3),
                                right: _responsive.wp(3),
                                top: 2), // 8
                            child: Container(
                              margin: EdgeInsets.only(left: 12, right: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 12, bottom: 12),
                                      child: Text(
                                        "¿Dónde encuentro este Premio?",
                                        style: TextStyle(
                                            // fontFamily: 'HelveticaNeue',
                                            fontFamily: "HelveticaNeue",
                                            fontSize: _responsive.ip(2.4),
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black),
                                        // style: AppConfig
                                        //     .styleDondeEncuentroConsesionario,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  // catalogoModel != null?ContainerConcesionarioDetallePremio(
                                  //       aConcesionarioDetallePremio : []
                                  //     ):Container(),
                                  StreamBuilder(
                                    stream: catalogoBloc.concesionarioStream,
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      return AnimatedSwitcher(
                                          duration: const Duration(seconds: 2),
                                          child: snapshot.hasData
                                              ? ContainerConcesionarioDetallePremio(
                                                  aConcesionarioDetallePremio:
                                                      snapshot.data,
                                                  catalogoModel: catalogoModel,
                                                  catalogoBloc: catalogoBloc,
                                                  prefs: prefs,
                                                  //  context:context
                                                )
                                              : ContainerConcesionarioPremioLoading());

                                      // return snapshot.hasData?ContainerConcesionarioDetallePremio(
                                      //    aConcesionarioDetallePremio : snapshot.data,
                                      //    catalogoModel : catalogoModel ,
                                      //    catalogoBloc : catalogoBloc,
                                      //    prefs : prefs
                                      // ):Container();
                                    },
                                  ),
                                ],
                              ),
                            )

                            //  height: 10,
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        // ),
      ),
    )

        // bottomNavigationBar: _crearBootomNavigationbar()
        );
  }
}
