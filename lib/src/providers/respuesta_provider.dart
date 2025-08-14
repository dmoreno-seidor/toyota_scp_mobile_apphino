
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:http/http.dart' as http;
// import 'package:toyota_scp_mobile_apphino/src/models/encuesta_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/grupo_familia_model.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';
class RespuestaProvider{
  final _prefs = new PreferenciasUsuario();
  //Crear meotod crear grupFamdad
  //Retornar -> Lista de Ciudades

  Future<bool> guardarEncuesta(String idEncuesta, List respuestas) async {     
    
  try{
    final oRequest = {
          "EncuestaRequest": {
            "idEncuesta" : idEncuesta,
            "usuario": jsonDecode(_prefs.usuarioInfo)["sCorreo"],
            "respuestas" : respuestas
          }
      };
     final url =
        "${AppConfig.api_host}/rest/encuesta";
    final resp = await http.put(
        url, headers: {'Content-Type': 'application/json',
        'SAPUI5Aplicacion' : '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'  ,
        'Authorization': AppConfig.autentificacion   
        },
        body: json.encode(oRequest));

   Map<String, dynamic> decodedResp = json.decode(resp.body);

    final responseString = resp.body;
      final parsed = jsonDecode(responseString);
      
       if(resp.statusCode==200){
        final iCode = decodedResp["oAuditResponse"]["iCode"];
        if(iCode ==1){
          
        
          if(decodedResp["EncuestaResponse"]["Detalle"]["Mensaje"]["codigoMensaje"]== "000"){
                return true; 
          }else{
               
      return false;
          }
         
         
          
        }else if(iCode !=1 ){
          
          throw PlatformException(code: "-1",message: decodedResp["oAuditResponse"]["sMessage"]);
          
        }

     }else if( resp.statusCode == 500){
        throw PlatformException(code: "500",message: parsed['message']);
      }else{
        throw PlatformException(code: "500",message: "Usuario no autorizado");
      }
      //Si es 1 Existe el usuario 
      //Si es != 1 no existe  -- Puede ser Error Tecnico(codigo<0) o Error funcional(!=1)
    }on PlatformException catch(e){
     return false;
    //  Map<String,dynamic> error;
    //   print("Error ${e.code}:${e.message}  ");
    //   Dialogs.alert(context,title: "Error",message: "Error al registrar la encuesta",onOk:(){

    //   });
 

      
    }
  
  }
}