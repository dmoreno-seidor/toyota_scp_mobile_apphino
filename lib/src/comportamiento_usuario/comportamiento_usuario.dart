import 'dart:convert';

import 'package:geolocator/geolocator.dart';

import '../preferencias_usuario/preferencias_usuario.dart';
import '../models/comportamiento_usuario_model.dart';
import '../providers/comportamiento_usuario_provider.dart';
import '../constantes.dart';

/// @author Daniel Carpio
class ComportamientoUsuario {

  static registrarEvento(PreferenciasUsuario prefs, {
    bool ingresoModuloCatalogo,
    bool ingresoModuloCitas,
    bool ingresoWhatsapp,
    bool ingresoRedConcesionario,
    bool cierreApp
  }) async {
    DateTime _today = DateTime.now();
    Geolocator _geoLocator = Geolocator();
    // Get user location
    Position position = await _geoLocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final _latitude = position?.latitude;
    final _longitude = position?.longitude;
    // Get address from position
    List<Placemark> placemark = await _geoLocator.placemarkFromCoordinates(_latitude, _longitude);
    var _ciudad, _region;
    if (placemark.length > 0) {
      // print('toJson: ${placemark[0].toJson()}');
      _ciudad = placemark[0].administrativeArea;
      _region = placemark[0].subAdministrativeArea;
    }
    // Get User Info
    var _flagStatusLogueado = (prefs?.iId != null && prefs?.iId != "");
    var _flagCuentaActivada = false;
    Map<String, dynamic> userInfo;
    if (_flagStatusLogueado == true) {
      userInfo = jsonDecode(prefs?.usuarioInfo);
      _flagCuentaActivada = (userInfo['idEstadoActivacion'] == Constantes.idEstadoActivacionConfirmado);
    }
    // Call to service 'ComportamientoUsuario'
    ComportamientoUsuarioModel _model = ComportamientoUsuarioModel(
      sStatusAPP: cierreApp != true ? 'X' : '',
      dFechaApertura: cierreApp != true ? _today : null,
      dHoraApertura: cierreApp != true ? _today : null,
      nCoordenadaX: _latitude,
      nCoordenadaY: _longitude,
      sCiudad: _ciudad,
      sRegion: _region,
      sStatusLoggeado: _flagStatusLogueado == true ? 'X' : '',
      iIdUsuario: _flagStatusLogueado == true ? prefs?.iId : null,
      sCuentaActivada: _flagCuentaActivada == true ? 'X' : '',
      sStatusIngresoModuloCatalogo: ingresoModuloCatalogo == true ? 'X' : '',
      sStatusWhatsapp: ingresoWhatsapp == true ? 'X' : '',
      sStatusRedConcesionario: ingresoRedConcesionario == true ? 'X' : '',
      sStatusIngresoModuloCitas: ingresoModuloCitas == true ? 'X' : '',
      dFechaCierre: cierreApp == true ? _today : null,
      dHoraCierre: cierreApp == true ? _today : null,
      sUsuarioCreacion: _flagStatusLogueado == true ? userInfo['sCorreo'] : null
    );
    ComportamientoUsuarioProvider _provider = new ComportamientoUsuarioProvider();
    _provider.registrarComportamiento(_model)
      .then((value) {
        print(value);
        //do something else
      })
      .catchError((err) {
        print(err);
        //do something else
      });
  }
}
