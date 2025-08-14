import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/propietario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/unidad_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/usuario_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/utils.dart' as utils;

import '../constantes.dart';

class NotificacionProvider {
  // final String _firebaseToken = 'AIzaSyBCRQuT-TpLdswdvpGEq3FyhPoS5gzeXis';
  // final _prefs = new PreferenciasUsuario();


  void registrarNotificacion(  iIdNotificacion,  iIdModuloRecibido,  sModulo, iIdUsuario) async{
        print(iIdNotificacion);
               print(sModulo);
                 print(iIdUsuario);
        try{

    final oRequest = {
          "oAuditRequest": {
              "dFecha": "2020-04-10T17:06:17.856Z",
              "sUsuario": "PORTAL_ADMIN"
          },
          "oData":  {
              "iIdNotificacion": iIdNotificacion,
              "iIdModuloRecibido" : iIdModuloRecibido,
              "sModulo": sModulo,
              "iIdUsuario": iIdUsuario
          }
      };
      print(oRequest);
  final url = "${AppConfig.api_host}/rest/ConfirmacionNotificacion";
        
        
    final resp = await http.post(
        url, headers: {'Content-Type': 'application/json',
        'SAPUI5Aplicacion' : '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'     
        },
        body: json.encode(oRequest));
  
  
      if (resp.statusCode != 200) {
      throw PlatformException(
          code: resp.statusCode.toString(), message: resp.toString());
    }

    Map<String, dynamic> decoded = json.decode(resp.body);
    // final iCode = decoded["iCode"];
    if (decoded["iCode"] != 1) {
      throw PlatformException(
          code: decoded["iCode"].toString(), message: decoded["sMessage"].toString());
    }
     
    }on PlatformException catch(e){
     Map<String,dynamic> error;
      print("Error ${e.code}:${e.message}  "); 
    }
  }

}
