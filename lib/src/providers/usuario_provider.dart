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

class UsuarioProvider {
  // final String _firebaseToken = 'AIzaSyBCRQuT-TpLdswdvpGEq3FyhPoS5gzeXis';
  // final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> usuarioAutenticacion(
      BuildContext context, String sCorreo, String sPassword) async {
    try {
      final oRequest = {
        "oAuditRequest": {
          "dFecha": "2020-04-10T17:06:17.856Z",
          "sUsuario": "PORTAL_ADMIN"
        },
        "oData": {
          "sCredenciales": utils.generateEncripto('$sCorreo:$sPassword')
        }
      };
      final url =
          "${AppConfig.api_host}/core/appSeguridadConcesionario/service/CnService/UsuarioAutenticacion/";

      final resp = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'SAPUI5Aplicacion':
                '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'
          },
          body: json.encode(oRequest));

      if (resp.statusCode == 200) {
        Map<String, dynamic> decodedResp = json.decode(resp.body);

        final responseString = resp.body;
        final parsed = jsonDecode(responseString);
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          return parsed;
        } else if (iCode != 1) {
          throw PlatformException(
              code: "-1", message: decodedResp["oAuditResponse"]["sMessage"]);
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: 'Servicio no disponible');
      } else if (resp.statusCode == 503) {
        throw PlatformException(code: "503", message: 'Servicio no disponible');
      } else {
        throw PlatformException(code: "500", message: "Usuario no autorizado");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      Map<String, dynamic> error;
      print("Error ${e.code}:${e.message}  ");
      Dialogs.alert(context, title: "Error", message: e.message, onOk: () {});
      return error;
    }
  }

  Future<Map<String, dynamic>> consultarDatosClientexCorreo(
      BuildContext context, String sCorreo) async {
    try {
      final oRequest = {
        "oAuditRequest": {
          "dFecha": "2020-04-10T17:06:17.856Z",
          "sUsuario": "PORTAL_ADMIN"
        },
        "oData": {"sCorreo": sCorreo}
      };
      final url =
          "${AppConfig.api_host}/core/appSeguridadClientes/service/CnService/ConsultarDatosClientexCorreo/";

      final resp = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'SAPUI5Aplicacion':
                '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'
          },
          body: json.encode(oRequest));

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          return parsed;
        } else if (iCode != 1) {
          throw PlatformException(
              code: "-1", message: decodedResp["oAuditResponse"]["sMessage"]);
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(code: "500", message: "Error ingresar");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      Dialogs.alert(context, title: "Error", message: e.message, onOk: () {});
    }
  }

  Future<Map<String, dynamic>> consultarDatosUsuarioAppleId(
      BuildContext context, String sAppleId) async {
    try {
      final oRequest = {
        "oAuditRequest": {
          "dFecha": "2020-04-10T17:06:17.856Z",
          "sUsuario": "PORTAL_ADMIN"
        },
        "oData": {"sAppleId": sAppleId}
      };
      final url =
          "${AppConfig.api_host}/core/appSeguridadClientes/service/CnService/ConsultarDatosClientexAppleId/";

      final resp = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'SAPUI5Aplicacion':
                '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'
          },
          body: json.encode(oRequest));

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          return parsed;
        } else if (iCode != 1) {
          throw PlatformException(
              code: "-1", message: decodedResp["oAuditResponse"]["sMessage"]);
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(code: "500", message: "Error ingresar");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      Dialogs.alert(context, title: "Error", message: e.message, onOk: () {});
    }
  }

  Future<Map<String, dynamic>> login(context, id) async {
    try {
      final oRequest = {
        "oAuditRequest": {
          "dFecha": "2020-04-10T17:06:17.856Z",
          "sUsuario": "PORTAL_ADMIN"
        },
        "oData": {"iId": 17}
      };
      final url =
          "${AppConfig.api_host}/core/appSeguridadClientes/service/CnService/ConsultarDataClientes/${id}";

      final resp = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'SAPUI5Aplicacion':
                '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'
          },
          body: json.encode(oRequest));

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          return parsed;
        } else if (iCode != 1) {
          throw PlatformException(code: "-1", message: "Error ingresar");
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(code: "500", message: "Error ingresar");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      Dialogs.alert(context, title: "Error", message: e.message, onOk: () {});
    }
  }

  Future<bool> validarCorreo(BuildContext context, String email) async {
    try {
      final oRequest = {
        "oAuditRequest": {"dFecha": "", "sUsuario": "PORTAL_ADMIN"},
        "oData": {"sCorreo": email}
      };
      final url =
          "${AppConfig.api_host}/core/appSeguridadClientes/service/CnService/ConsultarDatosClientexCorreo/";

      final resp = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(oRequest));

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          //existe el usuario
          if (decodedResp['oResults'].length == 0) {
            return true;
          } else if (decodedResp['oResults'].length > 0) {
            Dialogs.alert(context,
                title: "Error",
                message: "El correo ya se encuentra registrado",
                onOk: () {});
            return false;
          }
        } else if (iCode != 1) {
          throw PlatformException(
              code: "-1", message: "Error al crear la cuenta");
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(
            code: "500", message: "Error al crear la cuenta");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      Dialogs.alert(context, title: "Error", message: e.message, onOk: () {});

      return false;
    }
  }

  Future<bool> validarDocumento(BuildContext context, int idTipoDocumento,
      String sNumeroDocumento) async {
    try {
      final oRequest = {
        "oAuditRequest": {"dFecha": "", "sUsuario": "PORTAL_ADMIN"},
        "oData": {
          "idTipoDocumento": idTipoDocumento,
          "sNumeroDocumento": sNumeroDocumento
        }
      };
      final url =
          "${AppConfig.api_host}/core/appSeguridadClientes/service/CnService/ConsultarDatosClientexDocumento/";

      final resp = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(oRequest));

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          //existe el usuario
          if (decodedResp['oResults'].length == 0) {
            return true;
          } else if (decodedResp['oResults'].length > 0) {
            Dialogs.alert(context,
                title: "Error",
                message: "El número de documento ya se encuentra registrado",
                onOk: () {});
            return false;
          }
        } else if (iCode != 1) {
          throw PlatformException(
              code: "-1", message: "Error al crear la cuenta");
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(
            code: "500", message: "Error al crear la cuenta");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      Dialogs.alert(context, title: "Error", message: e.message, onOk: () {});

      return false;
    }
  }

  Future<bool> validarCelular(
      BuildContext context, String celular, String email) async {
    try {
      final oRequest = {
        "oAuditRequest": {"dFecha": "", "sUsuario": "PORTAL_ADMIN"},
        "oData": {"sNumTelefono": celular.replaceAll('-', ''), "sCorreo": email}
      };
      final url =
          "${AppConfig.api_host}/core/appSeguridadClientes/service/CnService/ConsultarDatosClientexCorreo/";

      final resp = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(oRequest));

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          //existe el usuario
          if (decodedResp['oResults'].length == 0) {
            Dialogs.alert(context,
                title: "Error",
                message: "Error el usuario no existe",
                onOk: () {});
            return false;
          } else if (decodedResp['oResults'].length > 0) {
            return true;
          }
        } else if (iCode != 1) {
          throw PlatformException(
              code: "-1", message: "Error al recuperar la contraseña");
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(
            code: "500", message: "Error al recuperar la contraseña");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      Dialogs.alert(context, title: "Error", message: e.message, onOk: () {});

      return false;
    }
  }

  Future<bool> actualizarUserPassword(
      BuildContext context, String email, String sNewPassword) async {
    try {
      final oRequest = {
        "oAuditRequest": {"dFecha": "", "sUsuario": "PORTAL_ADMIN"},
        "oData": {"sCorreo": email, "sNewPassword": sNewPassword}
      };
      final url =
          "${AppConfig.api_host}/Rest/appSeguridadConcesionario/actualizarUserPassword/";

      final resp = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'SAPUI5Aplicacion':
                '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'
          },
          body: json.encode(oRequest));

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          //existe el usuario
          if (decodedResp['oResults'].length == 0) {
            Dialogs.alert(context,
                title: "Error",
                message: "Error al restablecer la contraseña",
                onOk: () {});
            return false;
          } else if (decodedResp['oResults'].length > 0) {
            return true;
          }
        } else if (iCode != 1) {
          throw PlatformException(
              code: "-1", message: "Error al restablecer la contraseña");
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(
            code: "500", message: "Error al restablecer la contraseña");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      Dialogs.alert(context, title: "Error", message: e.message, onOk: () {});

      return false;
    }
  }

  Future<String> enviarCodigoValidacion(
      BuildContext context, String email, String celular) async {
    try {
      final oRequest = {
        "oAuditRequest": {"dFecha": "", "sUsuario": "PORTAL_ADMIN"},
        "oData": {"sNumTelefono": celular.replaceAll('-', ''), "sCorreo": email}
      };
      final url =
          "${AppConfig.api_host}/Rest/appSeguridadClientes/enviarCodigoValidacion/";

      final resp = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'SAPUI5Aplicacion':
                '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'
          },
          body: json.encode(oRequest));

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          return parsed['oResults']['iActivacion'].toString();
        } else if (iCode != 1) {
          throw PlatformException(
              code: "-1", message: "El código de SMS no pudo ser generado");
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(
            code: "500", message: "El código de SMS no pudo ser generado");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      Dialogs.alert(context, title: "Error", message: e.message, onOk: () {});

      return '';
    }
  }

  Future<bool> comprobarCodigoValidacionSms(BuildContext context, String email,
      String celular, String iActivationCode) async {
    try {
      final oRequest = {
        "oAuditRequest": {"dFecha": "", "sUsuario": "PORTAL_ADMIN"},
        "oData": {
          "sNumTelefono": celular.replaceAll('-', ''),
          "sCorreo": email,
          "iActivationCode": iActivationCode
        }
      };
      final url =
          "${AppConfig.api_host}/core/appSeguridadClientes/service/CnService/ComprobarCodigoValidacion/";

      final resp = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'SAPUI5Aplicacion':
                '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'
          },
          body: json.encode(oRequest));

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          return true;
        } else if (iCode != 1) {
          throw PlatformException(
              code: "-1", message: "El código no puede ser generado");
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(
            code: "500", message: "Error al generar el código");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      Dialogs.alert(context, title: "Error", message: e.message, onOk: () {});

      return false;
    }
  }

  Future<bool> registrarUsuarioMovil(
      BuildContext context, Map usuarioData) async {
    int idTipoDocumentoDni = Constantes.idTipoDocumentoDni;
    try {
      final oRequest = {
        "oAuditRequest": {
          "dFecha": "2020-04-08T21:48:19.997Z",
          "sUsuario": "PORTAL_ADMIN"
        },
        "oData": {
          "sCorreo": usuarioData["sCorreo"],
          "sPassword": usuarioData["sPassword"],
          "idTipoDocumento": usuarioData["idTipoDocumento"],
          "sNumeroDocumento": usuarioData["sNumeroDocumento"],
          "sNombres": usuarioData["sNombres"],
          "sApellidoPaterno": usuarioData["sApellidoPaterno"],
          "sApellidoMaterno": usuarioData["sApellidoMaterno"],
          "idCargoUsuario": 105,
          "codCargoUsuario": "USU_MOVIL",
          "sCargoUsuario": "HINO_USUARIO_MOVIL",
          "idTipoUsuario": usuarioData["idCargoUsuario"],
          "sCelular": usuarioData["sCelular"],
          "sAppleId": usuarioData["sAppleId"],
          "idEstadoActivacion": 1
        }
      };
      final url =
          "${AppConfig.api_host}/Rest/appSeguridadConcesionario/registrarUsuarioMovil/";

      final resp = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'SAPUI5Aplicacion':
                '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'
          },
          body: json.encode(oRequest));

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          return true;
        } else if (iCode != 2) {
          throw PlatformException(
              code: "-1", message: "Error al registrar el usuario");
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(
            code: "500",
            message: "Error al crear la cuenta intentelo más tarde.");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      Dialogs.alert(context, title: "Error", message: e.message, onOk: () {});

      return false;
    }
  }

  Future<Map<String, dynamic>> consultarDataCliente(int id) async {
    try {
      final oRequest = {
        "oAuditRequest": {
          "dFecha": "2020-04-10T17:06:17.856Z",
          "sUsuario": "PORTAL_ADMIN"
        },
        "oData": {"iId": id}
      };
      final url =
          "${AppConfig.api_host}/core/appSeguridadClientes/service/CnService/ConsultarDataClientes/${id}";

      final resp = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'SAPUI5Aplicacion':
                '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'
          },
          body: json.encode(oRequest));

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          return parsed["oResults"];
        } else if (iCode != 1) {
          throw PlatformException(
              code: "-1", message: "El código no puede ser generado");
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(
            code: "500",
            message: "Error al crear la cuenta intentelo más tarde.");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      // Dialogs.alert(context,title: "Error",message: e.message,onOk:(){

      // });

    }
  }

  Future<String> obtenerIdImagen(BuildContext context, String fileType,
      String fileName, String base64String, File image) async {
    try {
      var params = {
        "repositorio": "${AppConfig.repositoryName}",
        "accion": 'crear_file',
        "extencion": fileType,
        "file_name": fileName,
        "id_folder": "${AppConfig.repositoryFolderId}"
      };

      //var url = "/bridge/DocumentService?repositorio=${params['repositorio']}&accion= ${params['accion']}&extencion=image/${params['extencion']}&file_name=${params['file_name']}";

      // final oRequest = {
      //   "data": base64String
      // };

      final url =
          "${AppConfig.api_host_docService}/DocumentService?repositorio=${params['repositorio']}&accion=${params['accion']}&extencion=image/${params['extencion']}&file_name=${params['file_name']}&id_folder=${params['id_folder']}";

      final resp = await http.post(url,
          headers: {
            'Content-Type': 'text/plain',
            'SAPUI5Aplicacion':
                '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'
          },
          body: base64String);

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["estado"];
        if (iCode == 's') {
          return parsed['documento']['Id'];
        } else if (iCode != 's') {
          throw PlatformException(
              code: "-1", message: "No se pudo obtener la imagen");
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(
            code: "500", message: "El código de SMS no pudo ser generado");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      Dialogs.alert(context, title: "Error", message: e.message, onOk: () {});

      return '';
    }
  }

  Future<String> obtenerUrlImagen(
      BuildContext context, String idImagen, int iId) async {
    try {
      var params = {
        "repositorio": AppConfig.repositoryName,
        "accion": 'show_file_inline',
        "id_documento": idImagen,
      };

      //var url = "/DocumentService?repositorio=${params['repositorio']}&accion=${params['accion']}&id_documento=${params['id_documento']}";

      final sImagen =
          "/bridge/DocumentService?repositorio=${params['repositorio']}&accion=${params['accion']}&id_documento=${params['id_documento']}";
      final urlDocServcie =
          "/DocumentService?repositorio=${params['repositorio']}&accion=${params['accion']}&id_documento=${params['id_documento']}";

      final oRequest = {
        "oAuditRequest": {
          "dFecha": "2020-04-08T21:48:19.997Z",
          "sUsuario": "PORTAL_ADMIN"
        },
        "oData": {"iId": iId, "sImagen": sImagen}
      };

      final url =
          "${AppConfig.api_host}/Rest/appSeguridadClientes/actualizarImagenUsuarioClientes/";

      final resp = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'SAPUI5Aplicacion':
                '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'
          },
          body: json.encode(oRequest));

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          return urlDocServcie;
        } else if (iCode != 1) {
          throw PlatformException(
              code: "-1", message: "Erro al cargar la imagen");
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(
            code: "500", message: "Erro al cargar la imagen");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      Dialogs.alert(context, title: "Error", message: e.message, onOk: () {});

      return '';
    }
  }

  Future<Map<String, dynamic>> obtenerRegistroPuntosxCliente(
      BuildContext context, int id) async {
    try {
      final oRequest = {
        "oAuditRequest": {
          "dFecha": "2020-04-10T17:06:17.856Z",
          "sUsuario": "PORTAL_ADMIN"
        },
        "oData": {"idUsuarioCliente": id}
      };
      final url =
          "${AppConfig.api_host}/core/appRegistroPuntos/service/CnService/ObtenerRegistroPuntosxCliente/";

      final resp = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'SAPUI5Aplicacion':
                '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'
          },
          body: json.encode(oRequest));

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          return parsed["oResults"];
        } else if (iCode != 1) {
          throw PlatformException(
              code: "-1", message: "El código no puede ser generado");
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(
            code: "500",
            message: "Error al crear la cuenta intentelo más tarde.");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      // Dialogs.alert(context,title: "Error",message: e.message,onOk:(){

      // });

    }
  }

  Future<bool> actualizarTokenFirebase(
      BuildContext context, int id, String sToken) async {
    try {
      final oRequest = {
        "oAuditRequest": {
          "dFecha": "2020-04-10T17:06:17.856Z",
          "sUsuario": "PORTAL_ADMIN"
        },
        "oResults": {"iId": id, "sTokeDeviceFB": sToken}
      };
      final url =
          "${AppConfig.api_host}/rest/actualizarTokenFirebase"; //"${AppConfig.api_host}/rest/actualizarTokenFirebase/";

      final resp = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'SAPUI5Aplicacion':
                '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}',
            'Authorization': AppConfig.autentificacion
          },
          body: json.encode(oRequest));

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      final responseString = resp.body;
      final parsed = jsonDecode(responseString);

      if (resp.statusCode == 200) {
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if (iCode == 1) {
          return true;
        } else if (iCode != 1) {
          throw PlatformException(
              code: "-1", message: "El código no puede ser generado");
        }
      } else if (resp.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else {
        throw PlatformException(
            code: "500",
            message: "Error al crear la cuenta intentelo más tarde.");
      }
      //Si es 1 Existe el usuario
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}  ");
      return false;
      // Dialogs.alert(context,title: "Error",message: e.message,onOk:(){

      // });

    }
  }

  Future<List<UnidadModel>> consultarDataUnidad(int id) async {
    final url =
        //  "${AppConfig.api_host}/core/appMasters/service/ODataService.xsodata/VCiudad?\$format=json";
        "${AppConfig.api_host}/core/appMasters/service/ODataService.xsodata/VUnidad??\$filter=idEstado eq 101 and idUsuarioCliente eq $id";
    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': AppConfig.autentificacion
    });

    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes)); //json.decode(resp.body);
    print(decodedData);
    final List<UnidadModel> unidadVehiculos = new List();
    if (decodedData == null) {
      return [];
    } else if (decodedData["GrupoResponse"]["Detalle"]["Mensaje"]
            ["codigoMensaje"] !=
        "000") {
      return [];
    } else if (decodedData["GrupoResponse"]["Detalle"]["Mensaje"]
            ["codigoMensaje"] ==
        "000") {
      decodedData["GrupoResponse"]["Detalle"]["Datos"].forEach((vehiculos) {
        print(vehiculos);
        final vehiculosTemp = UnidadModel.fromJson(vehiculos);
        // grupFamdadTemp.id = grupFam["ID"];
        unidadVehiculos.add(vehiculosTemp);
      });
    }

    return unidadVehiculos;
  }
}
