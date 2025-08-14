import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:toyota_scp_mobile_apphino/src/manager/notification_manager.dart';
import 'package:toyota_scp_mobile_apphino/src/models/campania_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/concesionario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/evento_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/noticia_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/Provider.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/bottom-navbar-bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/encuesta_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/notificacion_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/respuesta_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/location_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/respuesta_provider.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajeStreamController = StreamController<Map>.broadcast();
  final _mensajeCampaniaStreamController = StreamController<CampaniaModel>.broadcast();
  final _mensajeEventoStreamController = StreamController<EventoModel>.broadcast();
  final _mensajeNoticiaStreamController = StreamController<NoticiaModel>.broadcast();
  PreferenciasUsuario prefs = new PreferenciasUsuario();
  Stream<Map> get mensajes => _mensajeStreamController.stream;
   Stream<CampaniaModel> get mensajesCampania => _mensajeCampaniaStreamController.stream;
   Stream<EventoModel> get mensajesEvento => _mensajeEventoStreamController.stream;
   Stream<NoticiaModel> get mensajesNoticia => _mensajeNoticiaStreamController.stream;

  // static BuildContext _context;

  // static init({@required BuildContext context}) {
  //   _context = context;
  // }

  initNotifications(context) {
    //Debo solicitar permiso
    _firebaseMessaging.requestNotificationPermissions();
    // BottomNavBarBloc _bottomNavBarBloc = new BottomNavBarBloc();
    _firebaseMessaging.getToken().then((token) {
      print('======= FCM TOKEN =======');
      print(token);
      prefs.token = token;
    });

    _firebaseMessaging.configure(
        //Aplicacion abierta
        onMessage: (info) async{
      print("=========== on MenssPage ========");
      print(info);
      NotificacionBloc notificacionBloc = NotificacionBloc();
      PreferenciasUsuario prefs = PreferenciasUsuario();

LocationService respuestaProvider = new LocationService();
 final test = await respuestaProvider.getLocation();
 print(test);
      if (Platform.isAndroid) {
        // argumento = info['data'];P
        if (info['data'] != null) {
          if (info['data']['modulo'] == "Camp") {
            final Map<String, dynamic> data = {
              "imagen": info['data']['imagen'],
              "id": info['data']['id']
            };
            notificacionBloc.registrarNotificacion(
              int.tryParse(info['data']["iIdAsociacion"]),
            int.tryParse(info['data']["id"])
              ,info['data']['modulo'],
              prefs.iId);
             CampaniaModel campaniaModel = calcularDistanciaEnviarCampania(info['data'],test.latitude,test.longitude);
            // campaniaModel.aConcesionarios = aConcesionarioFinal;
            NotificationManger.handleNotificationMsg(data, campaniaModel);
          } else if (info['data']['modulo'] == "Noticia") {
            final Map<String, dynamic> data = {
              "imagen": info['data']['imagen'],
              "id": info['data']['id']
              };
            notificacionBloc.registrarNotificacion(
              int.tryParse(info['data']["iIdAsociacion"]),
             int.tryParse(info['data']["id"]),
             info['data']['modulo'],
             prefs.iId);
             NoticiaModel noticiaModel = enviarNoticia(info['data']);
             NotificationManger.handleNotificationNoticia(data, noticiaModel);
          } else if (info['data']['modulo'] == "Evento") {
            
             final Map<String, dynamic> data = {
              "imagen": info['data']['imagen'],
              "id": info['data']['id'],
              };
              notificacionBloc.registrarNotificacion(
                int.tryParse(info['data']["iIdAsociacion"]),
               int.tryParse(info['data']["iId"]),
               info['data']['modulo'],
               prefs.iId);
              EventoModel eventoModel = enviarEvento(info['data']);
             NotificationManger.handleNotificationEvento(data, eventoModel);
          } else if (info['data']['modulo'] == "Encuesta") {
            notificacionBloc.registrarNotificacion(
              null,
              int.tryParse(jsonDecode(info['data']['encuestas'])[0]["idEncuesta"]),
             info['data']['modulo'],
             prefs.iId);
            procesarEncuesta(info['data']);
          }
        }
      } else if (Platform.isIOS) {
        if (info != null) {
          if (info['modulo'] == "Camp") {
            final Map<String, dynamic> data = {
              "imagen": info['imagen'],
              "id": info['id']
            };
            
            notificacionBloc.registrarNotificacion(
              int.tryParse(info["iIdAsociacion"]),
             int.tryParse(info["id"]),
             info['modulo'],
             prefs.iId);
             CampaniaModel campaniaModel = calcularDistanciaEnviarCampania(info,test.latitude,test.longitude);
            // campaniaModel.aConcesionarios = aConcesionarioFinal;
            NotificationManger.handleNotificationMsg(data, campaniaModel);
          } else if (info['modulo'] == "Noticia") {
            final Map<String, dynamic> data = {
              "imagen": info['imagen'],
              "id": info['id']
              };
            notificacionBloc.registrarNotificacion(
              int.tryParse(info["iIdAsociacion"]),
            int.tryParse(info["id"]),
            info['modulo'],
            prefs.iId);
             NoticiaModel noticiaModel = enviarNoticia(info);
             NotificationManger.handleNotificationNoticia(data, noticiaModel);
          } else if (info['modulo'] == "Evento") {
             
             final Map<String, dynamic> data = {
              "imagen": info['imagen'],
              "id": info['id'],
              };
              notificacionBloc.registrarNotificacion(
                int.tryParse(info["iIdAsociacion"]),
              int.tryParse(info["id"]),
              info['modulo'],
              prefs.iId);
              EventoModel eventoModel = enviarEvento(info);
             NotificationManger.handleNotificationEvento(data, eventoModel);
          } else if (info['modulo'] == "Encuesta") {
            notificacionBloc.registrarNotificacion(
            null,
            int.tryParse(jsonDecode(info['encuestas'])[0]["idEncuesta"]),
            info['modulo'],
            prefs.iId);
            procesarEncuesta(info);
          }
        }
      }
    },
        //Recibir notificaciones - cuando el app esta en segundo plano
        onLaunch: (info) async{
      print("=========== on Launch ========");
      print(info);
      NotificacionBloc notificacionBloc = NotificacionBloc();
      PreferenciasUsuario prefs = PreferenciasUsuario();
      _firebaseMessaging.onTokenRefresh;
      LocationService respuestaProvider = new LocationService();
 final test = await respuestaProvider.getLocation();
 print(test);
      if (Platform.isAndroid) {
        // argumento = info['data'];P
        if (info['data'] != null) {
          if (info['data']['modulo'] == "Camp") {
            notificacionBloc.registrarNotificacion(
              int.tryParse(info['data']["iIdAsociacion"]),
           int.tryParse(info['data']["id"]),
            info['data']['modulo'],
            prefs.iId);
             CampaniaModel campaniaModel = calcularDistanciaEnviarCampania(info['data'],test.latitude,test.longitude);

           _mensajeCampaniaStreamController.sink.add(campaniaModel);
          } else if (info['data']['modulo'] == "Noticia") {
            final Map<String, dynamic> data = {
              "imagen": info['data']['imagen'],
              "id": info['data']['id']
              };
            notificacionBloc.registrarNotificacion(
              int.tryParse(info['data']["iIdAsociacion"]),
            int.tryParse(info['data']["id"]),
            info['data']['modulo'],
            prefs.iId);
             NoticiaModel noticiaModel = enviarNoticia(info['data']);
             _mensajeNoticiaStreamController.sink.add(noticiaModel);
          } else if (info['data']['modulo'] == "Evento") {
             final Map<String, dynamic> data = {
              "imagen": info['data']['imagen'],
              "id": info['data']['id'],
              };
              notificacionBloc.registrarNotificacion(
                int.tryParse(info['data']["iIdAsociacion"]),
              int.tryParse(info['data']["id"]),
              info['data']['modulo'],
              prefs.iId);
              EventoModel eventoModel = enviarEvento(info['data']);
             _mensajeEventoStreamController.sink.add(eventoModel);
          } else if (info['data']['modulo'] == "Encuesta") {
            notificacionBloc.registrarNotificacion(
              null,
              int.tryParse(jsonDecode(info['data']['encuestas'])[0]["idEncuesta"]),
            
            info['data']['modulo'],
            prefs.iId);
            Future.delayed(Duration.zero, () => procesarEncuesta(info['data']));
          }
        }
      } else if (Platform.isIOS) {
        if (info != null) {
          if (info['modulo'] == "Camp") {
            final Map<String, dynamic> data = {
              "imagen": info['imagen'],
              "id": info['id']
            };
            notificacionBloc.registrarNotificacion(int.tryParse(info["iIdAsociacion"]),
            int.tryParse(info["id"]),info['modulo'],prefs.iId);
            CampaniaModel campaniaModel = calcularDistanciaEnviarCampania(info,test.latitude,test.longitude);
            // campaniaModel.aConcesionarios = aConcesionarioFinal;
            // NotificationManger.handleNotificationMsg(data, campaniaModel);
            _mensajeCampaniaStreamController.sink.add(campaniaModel);
          }
        
           } else if (info['modulo'] == "Noticia") {
            final Map<String, dynamic> data = {
              "imagen": info['imagen'],
              "id": info['id']
              };
            notificacionBloc.registrarNotificacion(int.tryParse(info["iIdAsociacion"]),
            int.tryParse(info["id"]),info['modulo'],prefs.iId);
             NoticiaModel noticiaModel = enviarNoticia(info);
             _mensajeNoticiaStreamController.sink.add(noticiaModel);
          } else if (info['modulo'] == "Evento") {
             final Map<String, dynamic> data = {
              "imagen": info['imagen'],
              "id": info['id'],
              };
              notificacionBloc.registrarNotificacion(int.tryParse(info["iIdAsociacion"]),
              int.tryParse(info["id"]),info['modulo'],prefs.iId);
              EventoModel eventoModel = enviarEvento(info);
             _mensajeEventoStreamController.sink.add(eventoModel);
          } else if (info['modulo'] == "Encuesta") {
            notificacionBloc.registrarNotificacion(
              null,
              int.tryParse(jsonDecode(info['encuestas'])[0]["idEncuesta"]),
            info['modulo'],prefs.iId);
            Future.delayed(Duration.zero, () => procesarEncuesta(info));
          }
      }
    },
        //Pasa de primer plano a segundo plano
        //Esto es cuando la aplicacion esta en minimizada
        onResume: (info) async{
      print("=========== on Resume ========");
      print(info);
      NotificacionBloc notificacionBloc = NotificacionBloc();
      PreferenciasUsuario prefs = PreferenciasUsuario();
      _firebaseMessaging.onTokenRefresh;
LocationService respuestaProvider = new LocationService();
 final test = await respuestaProvider.getLocation();
 print(test);
      if (Platform.isAndroid) {
        // argumento = info['data'];P
        if (info['data'] != null) {
          if (info['data']['modulo'] == "Camp") {
            notificacionBloc.registrarNotificacion(int.tryParse(info['data']["iIdAsociacion"]),
            int.tryParse(info['data']["id"]),info['data']['modulo'],prefs.iId);
             CampaniaModel campaniaModel = calcularDistanciaEnviarCampania(info['data'],test.latitude,test.longitude);

            _mensajeCampaniaStreamController.sink.add(campaniaModel);

          } else if (info['data']['modulo'] == "Noticia") {
            final Map<String, dynamic> data = {
              "imagen": info['data']['imagen'],
              "id": info['data']['id']
              };
              notificacionBloc.registrarNotificacion(int.tryParse(info['data']["iIdAsociacion"]),
              int.tryParse(info['data']["id"]),info['data']['modulo'],prefs.iId);
             NoticiaModel noticiaModel = enviarNoticia(info['data']);
             _mensajeNoticiaStreamController.sink.add(noticiaModel);
          } else if (info['data']['modulo'] == "Evento") {
            final Map<String, dynamic> data = {
              "imagen": info['data']['imagen'],
              "id": info['data']['id'],
              };
              notificacionBloc.registrarNotificacion(int.tryParse(info['data']["iIdAsociacion"]),
              int.tryParse(info['data']["iId"]),info['data']['modulo'],prefs.iId);
              EventoModel eventoModel = enviarEvento(info['data']);
             _mensajeEventoStreamController.sink.add(eventoModel);
          } else if (info['data']['modulo'] == "Encuesta") {
            notificacionBloc.registrarNotificacion(
              null,
              int.tryParse(jsonDecode(info['data']['encuestas'])[0]["idEncuesta"]),
           info['data']['modulo'],prefs.iId);
            procesarEncuesta(info['data']);
          }
        }
      } else if (Platform.isIOS) {
        if (info != null) {
          if (info['modulo'] == "Camp") {
           
          final Map<String, dynamic> data = {
              "imagen": info['imagen'],
              "id": info['id']
            };
              notificacionBloc.registrarNotificacion(int.tryParse(info["iIdAsociacion"]),
              int.tryParse(info["id"]),info['modulo'],prefs.iId);
             CampaniaModel campaniaModel = calcularDistanciaEnviarCampania(info,test.latitude,test.longitude);
            // NotificationManger.handleNotificationMsg(data, campaniaModel);
            _mensajeCampaniaStreamController.sink.add(campaniaModel);
           } else if (info['modulo'] == "Noticia") {
            final Map<String, dynamic> data = {
              "imagen": info['imagen'],
              "id": info['id']
              };
            notificacionBloc.registrarNotificacion(int.tryParse(info["iIdAsociacion"]),
            int.tryParse(info["id"]),info['modulo'],prefs.iId);
             NoticiaModel noticiaModel = enviarNoticia(info);
             _mensajeNoticiaStreamController.sink.add(noticiaModel);
          } else if (info['modulo'] == "Evento") {
             final Map<String, dynamic> data = {
              "imagen": info['imagen'],
              "id": info['id'],
              };
              notificacionBloc.registrarNotificacion(int.tryParse(info["iIdAsociacion"]),
              int.tryParse(info["id"]),info['modulo'],prefs.iId);
              EventoModel eventoModel = enviarEvento(info);
             _mensajeEventoStreamController.sink.add(eventoModel);
          }  else if (info['modulo'] == "Encuesta") {
            notificacionBloc.registrarNotificacion(
              null,
              int.tryParse(jsonDecode(info['encuestas'])[0]["idEncuesta"]),
            info['modulo'],prefs.iId);
            procesarEncuesta(info);
          }
        }
      }
    });
  }

  procesarEncuesta(dynamic data) {
    EncuestaBloc encuestaBloc = new EncuestaBloc();
    RespuestaBloc respuestaBloc = new RespuestaBloc();
    RespuestaProvider respuestaProvider = new RespuestaProvider();
    encuestaBloc.cargarEncuestas(data);
    // NotificationManger.handleNotificationEncuesta(encuestaBloc.aEncuestasLastValue[0],encuestaBloc);
    NotificationManger.dialogIntroductorioEncuesta(
        title: 'Encuesta HINO',
        message:
            'Porque tu opinión es importante para nosotros, apoyanos con una par de preguntas y a cambio ganate 50 puntos para canjear el premio que tanto deseas...',
        encuestaBloc: encuestaBloc,
        respuestaBloc: respuestaBloc,
        respuestaProvider: respuestaProvider);
  }

    calcularDistanciaEnviarCampania(info, latitud, longitud){
     CampaniaModel campaniaModel = new CampaniaModel();
            campaniaModel.aConcesionarios =jsonDecode(info["concesionarios"]);
            campaniaModel.id = info["id"];
            campaniaModel.imagen = info['imagen'];
            campaniaModel.nombre = info['nombre'];
            campaniaModel.vigencia =info['vigencia'];
            campaniaModel.terminos = info['terminos'];
            print(campaniaModel);
    List<Map<String,dynamic>> aConcesionarioFinal = new List<Map<String,dynamic>>();
    campaniaModel.aConcesionarios.forEach((element)  {
       var latitudConcesionario = double.parse( element['latitud']);
        var longitudConcesionario = double.parse( element['longitud']);
        
        double distanceInKm = sqrt( ( pow(( latitudConcesionario  -  latitud ),2) - pow((  longitudConcesionario -longitud ),2)   ) );
        // print(distanceInMeters/1000);

        final Map<String, dynamic> concesionarioMap = {
              "whatsapp": element["whatsapp"],
              "distrito": element["distrito"],
              "codigo": element["codigo"],
              "latitud": element["latitud"],
              "direccion": element["direccion"],
              "imagen": element["imagen"],
              "nombre": element["nombre"],
              "longitud": element["longitud"],
              "ciudad": element["ciudad"],
              "correo": element["correo"], 
              "distancia": distanceInKm.toStringAsFixed(2).toString(),
              "id": element["id"],
              "telefono": element["telefono"],
            };
            print(concesionarioMap);
        
        aConcesionarioFinal.add(concesionarioMap);
    });
    campaniaModel.aConcesionarios = aConcesionarioFinal;

    return campaniaModel;
    
  }

  enviarNoticia(info){
     NoticiaModel noticiaModel = new NoticiaModel();
            noticiaModel.id = info["id"];
            noticiaModel.imagen = info['imagen'];
            noticiaModel.nombre = info['nombre'];
            noticiaModel.publicadoDesde =info['publicadoDesde'];
            noticiaModel.publicadoHasta = info['publicadoHasta'];
            noticiaModel.texto = info['texto'];
            print(noticiaModel);

     return noticiaModel; 
  }

  enviarEvento(info){
     EventoModel eventoModel = new EventoModel();
            eventoModel.id = info["id"];
            eventoModel.imagen = info['imagen'];
            eventoModel.nombre = info['nombre'];
            eventoModel.publicadoDesde =info['publicadoDesde'];
            eventoModel.publicadoHasta = info['publicadoHasta'];
            eventoModel.dia = info['dia'];
            eventoModel.diaEvento = info['diaEvento'];
            eventoModel.horaEvento = info['horaEvento'];
            eventoModel.fechaEvento = info['fechaEvento'];
            eventoModel.lugarNombre = info['lugarNombre'];
            eventoModel.lugarDireccion = info['lugarDireccion'];
            print(eventoModel);

     return eventoModel; 
  }

  dispose() {
    _mensajeStreamController?.close();
  }
}
