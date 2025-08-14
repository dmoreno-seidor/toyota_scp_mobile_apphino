import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/models/unidad_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/usuario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/notificacion_provider.dart';


class NotificacionBloc with Validators{
  //----
  final _notificacionProvider = new NotificacionProvider();

  void registrarNotificacion(  iIdNotificacion,  iIdModuloRecibido,  sModulo, iIdUsuario) async{
    // _cargandoController.sink.add(true);
  _notificacionProvider.registrarNotificacion(  iIdNotificacion, iIdModuloRecibido, sModulo, iIdUsuario);
  
  }

  dispose(){
   
  }
}
