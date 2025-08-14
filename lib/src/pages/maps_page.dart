import 'dart:async';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toyota_scp_mobile_apphino/src/models/concesionario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

import '../preferencias_usuario/preferencias_usuario.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> with WidgetsBindingObserver {
  //  CampaniaBloc catalogoBloc = new CampaniaBloc();
  final prefs = new PreferenciasUsuario();
  
  static LatLng _initialPosition;
  // final Set<Marker> _markers = {};
  // static  LatLng _lastMapPosition = _initialPosition;

  GoogleMapController _mapController;
  LatLng posiConcesionario;
  ConcesionarioModel concesionarioModel;
  List<Marker> allMarkers = [];

  //  CameraPosition _kGooglePlex ;

  StreamSubscription<Position> _positionStream;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Future.delayed(Duration.zero, () {
    //   concesionarioModel = ModalRoute.of(context).settings.arguments;
    //   if (concesionarioModel != null) {
       
    //     setState(() {

    //     _initialPosition = LatLng( double.parse(concesionarioModel.latitud), double.parse(concesionarioModel.longitud));
          
    //       allMarkers.add(Marker(
    //           markerId: MarkerId("myMarker-${concesionarioModel.id}"),
    //           draggable: false,
    //           infoWindow: InfoWindow(
                
    //               title: concesionarioModel.nombre,
    //               snippet: concesionarioModel.direccion,
    //               onTap: (){
    //               }
    //           ),
              
    //           onTap: () {
    //             print("Marker tapped");
    //           },
    //           position: LatLng(double.parse(concesionarioModel.latitud), double.parse(concesionarioModel.longitud))));

    //           _move2();
    //     });
    //   }
    // });
  }

  // Future<void> _getCurrentPosition() async {
  //   Position position = await Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   // _onlocationUpdate(position);
  // }

  // _startTracking() {
  //   final geolocator = Geolocator();
  //   final locationOptions = LocationOptions(
  //       accuracy: LocationAccuracy.high,
  //       distanceFilter: 5); // precision lo mas alto posible
  //   _positionStream =
  //       geolocator.getPositionStream(locationOptions).listen(_onlocationUpdate);
  // }

  // _onlocationUpdate(Position position) {
  //   if (position != null) {
  //     print('position ${position.latitude}, ${position.longitude}');
  //   //  _move(position);
  //   //  setState(() {
  //   //       // catalogoBloc.cargarCatalogo("USUARIO","",12.00,-17.00,0);
  //   //       campaniaBloc.cargarCampania("USUARIO", "", position.latitude, position.longitude, 0);
  //   //   });
  //   }
  // }

  // _move(Position position) {
  //   // if (posiConcesionario != null) {
  //     final cameraUpdate =
  //         CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude));
  //     _mapController.animateCamera(cameraUpdate);
  //   // }
  // }

  _move2() {
    if (posiConcesionario != null) {
      // setState(() {
          final cameraUpdate =
          CameraUpdate.newLatLng(LatLng(double.parse(concesionarioModel.latitud), double.parse(concesionarioModel.longitud)));
      _mapController.animateCamera(cameraUpdate);
      // });
      
    }
  }

  //libero los recursos del dispositivo
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    if (_positionStream != null) {
      _positionStream.cancel();
      _positionStream = null;
    }
  }


  openMapsSheet(context) async {
    try {
      print(concesionarioModel);
      final title = concesionarioModel.direccion;
      final description = concesionarioModel.nombre;
      final coords = Coords(double.parse(concesionarioModel.latitud),double.parse(concesionarioModel.longitud));
      final availableMaps = await MapLauncher.installedMaps;

       

      print(availableMaps);

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => 
                        
                        
                        map.showMarker(
                          coords: coords,
                          title: title,
                          description: description,
                        ),
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
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


test(concesionarioModel){
  if (concesionarioModel != null) {
       
        // setState(() {

        _initialPosition = LatLng( double.parse(concesionarioModel.latitud), double.parse(concesionarioModel.longitud));
          
          allMarkers.add(Marker(
              markerId: MarkerId("myMarker-${concesionarioModel.id}"),
              draggable: false,
              infoWindow: InfoWindow(
                
                  title: concesionarioModel.nombre,
                  snippet: concesionarioModel.direccion,
                  onTap: (){
                  }
              ),
              
              onTap: () {
                print("Marker tapped");
              },
              position: LatLng(double.parse(concesionarioModel.latitud), double.parse(concesionarioModel.longitud))));

              _move2();
        // }
        // );
      }
}
  @override
  Widget build(BuildContext context) {

concesionarioModel = ModalRoute.of(context).settings.arguments;

test(concesionarioModel);
    
    Responsive _responsive = new Responsive(context);
    return Scaffold(
      body: _initialPosition == null ? Container(child: Center(child:Text('Cargando Mapa..', style: TextStyle(fontFamily: 'Avenir-Medium', color: Colors.grey[400]),),),):
      Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              
              padding: EdgeInsets.only(
                top: 40.0,
              ),
              // initialCameraPosition: _kGooglePlex,
              initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 17.5,
            ),
              // compassEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              markers: Set.from(allMarkers),
              // markers: Set.of(_markers.values),
              // onTap: _onTap,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                // _mapController.setMapStyle(jsonEncode(mapStyle));
              },
              
            ),
            
            

            Positioned(
                // top: 10.0,
                left: 0.0,
                right: 0.0,
                child: SafeArea(
                 child: GestureDetector(
                   behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.only(top:10,left: 16,right: 18),
                                      child: Container(
                      // margin: EdgeInsets.only(
                      //     left: _responsive.wp(6), right: _responsive.wp(6)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 14,
                              width: 22,
                              child: Icon(
                                    FontAwesomeIcons.arrowLeft,
                                    color: Colors.black,
                                  ),
                            ),
                            
                        ],
                      ),
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                        ),
                ),
              ),

              


          ],
          
        ),
        
      ),
      floatingActionButton: Container(
        width: 100.0,
      // height: 200.0,
        child: FloatingActionButton.extended(
          
          onPressed:(){
            openMapsSheet(context);
          },
          label: Text('Ir'),
          icon: Icon(FontAwesomeIcons.car),
        ),
      ),
      
    );
  }

  

  
}
