import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toyota_scp_mobile_apphino/src/models/concesionario_model.dart';

import '../preferencias_usuario/preferencias_usuario.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';

class MapsPermission extends StatefulWidget {
  final ConcesionarioModel concesionario;

  const MapsPermission({Key key, 
  this.concesionario}) : super(key: key);
  @override
  _MapsPermissionState createState() => _MapsPermissionState();
}

class _MapsPermissionState extends State<MapsPermission> with WidgetsBindingObserver{
   PermissionHandler _permissionHandler = PermissionHandler();
  final prefs = new PreferenciasUsuario();
  var _isChecking = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _check();
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
  
    //comprobar si tenemos acceso a la ubicacion del dispositivo
   _check() async{
   final status = await _permissionHandler
   .checkPermissionStatus(PermissionGroup.locationWhenInUse);
    if(status == PermissionStatus.granted){
      Navigator.pushReplacementNamed(context, 'mapsPage' , arguments: widget.concesionario); //elimino del historial la pantalla del Splash
    }else {
      setState(() {
        _isChecking = false;
      });
    }
  }

  _request()async{
    final result = await _permissionHandler.requestPermissions([PermissionGroup.locationWhenInUse]);
    if(result.containsKey(PermissionGroup.locationWhenInUse)){
      final status = result[PermissionGroup.locationWhenInUse];
      if(status == PermissionStatus.granted){
        Navigator.pushReplacementNamed(context, 'mapsPage');
      } else if(status == PermissionStatus.denied || status == PermissionStatus.restricted){
        final result = await _permissionHandler.openAppSettings();
        print('result $result');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: _isChecking ? Center(
            child: CircularProgressIndicator()
          ):Stack(children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)), //this right here
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 140,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 5.0),
                          Text(
                            'Upss...',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Flexible(
                              child: Text(
                            'El GPS no esta habilitado, necesitas habilitar el GPS',
                            textAlign: TextAlign.center,
                          )),
                        ],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFFcf7501))),
                            color: Color(0xFFcf7501),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(8.0),
                            onPressed: _request,
                            child: Text(
                              "Ok, Entendido",
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.white),
                            ),
                          )
                        ]),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 220),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: new AssetImage(
                              'assets/recuperarContrasena/circuloNaranja.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: new AssetImage(
                              'assets/recuperarContrasena/aletaBlanco.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ])
    );
  }
}