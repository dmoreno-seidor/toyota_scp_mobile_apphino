import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/models/unidad_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/usuario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/usuario_provider.dart';
import 'package:sortedmap/sortedmap.dart';
import '../../preferencias_usuario/preferencias_usuario.dart';

class UsuarioBloc with Validators{
  //----
  final _usuarioProvider = new UsuarioProvider();
  final _oUsuarioController = new BehaviorSubject<UsuarioModel>();
  final _sNumeroDocumentoController = BehaviorSubject<String>();
    final _sNombresController = BehaviorSubject<String>();
    final _sApellidoPaternoController = BehaviorSubject<String>();
    final _sApellidoMaternoController = BehaviorSubject<String>();
    // final _dFechaNacimientoController = BehaviorSubject<String>();
    final _sCorreoController = BehaviorSubject<String>();
    final _sPasswordController = BehaviorSubject<String>();
    final _sCelularController = BehaviorSubject<String>();
    final _idTipoDocumentoController = BehaviorSubject<String>();
    // final _codTipoDocumentoController = BehaviorSubject<String>();
    // final _sTipoDocumentoController = BehaviorSubject<String>();
    // final _idUnidadController = BehaviorSubject<String>();
    // final _idUnidadPropietarioController = BehaviorSubject<String>();
    // final _sUnidadNumeroPlacaController = BehaviorSubject<String>();
    // final _idTipoUsuarioController = BehaviorSubject<String>();
    // final _codTipoUsuarioController = BehaviorSubject<String>();
    final _idCargoUsuarioController = BehaviorSubject<String>();
    // final _codCargoUsuarioController = BehaviorSubject<String>();
    // final _sCargoUsuarioController = BehaviorSubject<String>();
    // final _idTipoConductorController = BehaviorSubject<String>();
    // final _codTipoConductorController = BehaviorSubject<String>();
    // final _sTipoConductorController = BehaviorSubject<String>();
    // final _idPropietarioController = BehaviorSubject<String>();
    // final _sPropietarioNombresController = BehaviorSubject<String>();
    // final _sPropietarioApPaternoController = BehaviorSubject<String>();
    // final _sPropietarioApMaternoController = BehaviorSubject<String>();
    // final _idConcesionarioController = BehaviorSubject<String>();
    // final _sConcesionarioCodigoController = BehaviorSubject<String>();
    // final _sConcesionarioDescripcionController = BehaviorSubject<String>();
    // final _idEstadoController = BehaviorSubject<String>();
    // final _sEstadoController = BehaviorSubject<String>();
    // final _idEstadoActivacionController = BehaviorSubject<String>();
    final _bTerminoCondicionesController = BehaviorSubject<bool>();
    final _bAutorizacionDatosPersonalesController = BehaviorSubject<bool>();
    // final _bEstadoActivacionController = BehaviorSubject<bool>();
    // final _dFechaCreacionController = BehaviorSubject<String>();
    // final _iPuntosAcumuladosController = BehaviorSubject<String>();
    // final _iCantidadPremiosController = BehaviorSubject<String>();
    // final _aUnidadesController = BehaviorSubject<String>();
    // final _aServiciosController = BehaviorSubject<String>();
    // final _aPuntosAcumuladosConcesionarioControllerController = BehaviorSubject<List<dynamic>>();
    final _aUnidadVehiculosController = BehaviorSubject<List<UnidadModel>>();


  
  //Recuperar los datos del Stream
  // Stream<UsuarioModel> get oUsuarioStream => _usuarioController.stream;
  
  Stream<UsuarioModel> get oUsuarioStream => _oUsuarioController.stream;
  Stream<String> get sCorreoStream => _sCorreoController.stream;
  Stream<String> get idTipoDocumentoStream => _idTipoDocumentoController.stream;
  Stream<String> get sNumeroDocumentoStream => _sNumeroDocumentoController.stream;
  Stream<String> get sNombresStream => _sNombresController.stream;
  Stream<String> get sApellidoPaternoStream => _sApellidoPaternoController.stream;
  Stream<String> get sApellidoMaternoStream => _sApellidoMaternoController.stream;
  Stream<String> get idCargoUsuarioStream => _idCargoUsuarioController.stream;
  Stream<String> get sCelularStream => _sCelularController.stream; 
  Stream<String> get sPasswordStream => _sPasswordController.stream;
  Stream<bool> get bTerminoCondicionesStream => _bTerminoCondicionesController.stream;
  Stream<bool> get bAutorizacionDatosPersonalesStream => _bAutorizacionDatosPersonalesController.stream;
  Stream<List<UnidadModel>> get aUnidadStream => _aUnidadVehiculosController.stream;
  
    
  //Insertar valores als Stream
  // Function(String) get changeCorreo => _sCorreoController.sink.add;
  // Function(String) get changeTipoDocumento => _idTipoDocumentoController.sink.add;
  // Function(String) get changeNumeroDocumento => _sNumeroDocumentoController.sink.add;
  // Function(String) get changeNombre => _sNombresController.sink.add;
  // Function(String) get changeApellidoPaterno => _sApellidoPaternoController.sink.add;
  // Function(String) get changeApellidoMaterno => _sApellidoMaternoController.sink.add;
  // Function(String) get changeCargoUsuario => _idCargoUsuarioController.sink.add;
  // Function(String) get changeCelular => _sCelularController.sink.add;
  // Function(String) get changePassword => _sPasswordController.sink.add;
  // Function(bool) get changeTerminosCondiciones => _bTerminoCondicionesController.sink.add;
  // Function(bool) get changeAutorizacionDatosPersonales => _bAutorizacionDatosPersonalesController.sink.add;

  //Obtener ultimo valor ingresado
  UsuarioModel get oUsuario =>_oUsuarioController.value;
  String get sCorreo => _sCorreoController.value;
  String get idTipoDocumento => _idTipoDocumentoController.value;
  String get sNumeroDocumento => _sNumeroDocumentoController.value;
  String get sNombres => _sNombresController.value;
  String get sApellidoPaterno => _sApellidoPaternoController.value;
  String get sApellidoMaterno => _sApellidoMaternoController.value;
  String get idCargoUsuario => _idCargoUsuarioController.value;
   String get sCelular => _sCelularController.value;
  String get sPassword => _sPasswordController.value;
  bool get bTerminosCondiciones => _bTerminoCondicionesController.value;
  bool get bAutorizacionDatosPersonales =>_bAutorizacionDatosPersonalesController.value;
  

  Future<Map<String,dynamic>> login(BuildContext context, id) async{
    // _cargandoController.sink.add(true);
    Map respuesta = await _usuarioProvider.login(context,id);
    //respuesta['oResults']['datosUsuario']['sNombres']
    return respuesta; 
    // Map<String,dynamic> respuesta = await _usuarioProvider.login(context,id);
    // print("fin");
    
    
    // print("----");
    // _cargandoController.sink.add(false);
  }

  void consultarDataCliente(int id) async{
    // _cargandoController.sink.add(true);
    Map respuesta = await _usuarioProvider.consultarDataCliente(id);
    UsuarioModel usuarioModel = UsuarioModel.fromJson(respuesta);//= new UsuarioModel();
    
    
    // usuarioModel.sNombres = respuesta['datosUsuario']['sNombres']==null?'':respuesta['datosUsuario']['sNombres'];
    // usuarioModel.sNumeroDocumento =  respuesta['datosUsuario']['sNumeroDocumentoController']==null?'':respuesta['datosUsuario']['sNumeroDocumentoController'];
    // usuarioModel.sApellidoPaterno =  respuesta['datosUsuario']['sApellidoPaterno']==null?'':respuesta['datosUsuario']['sApellidoPaterno'];
    // usuarioModel.sApellidoMaterno =  respuesta['datosUsuario']['sApellidoMaterno']==null?'':respuesta['datosUsuario']['sApellidoMaterno'];
    // usuarioModel.sCorreo = respuesta['datosUsuario']['sCorreo'];
    // usuarioModel.sCelular = respuesta['datosUsuario']['sCelular']==null?'':respuesta['datosUsuario']['sCelular'];
    // usuarioModel.sTipoDocumento = respuesta['datosUsuario']['sTipoDocumento']==null?'':respuesta['datosUsuario']['sTipoDocumento'];
    // usuarioModel.sPuntosAcumulados = respuesta['datosCabecera']['iPuntosAcumulados']==null?0.toString():respuesta['datosCabecera']['iPuntosAcumulados'].toString();
    // usuarioModel.sCantidadPremios = respuesta['datosCabecera']['iCantidadCanjePremios']==null?0.toString():respuesta['datosCabecera']['iCantidadCanjePremios'].toString();
    // usuarioModel.aUnidades = respuesta['datosUnidad']==null?[]:respuesta['datosUnidad'];
    _oUsuarioController.sink.add(usuarioModel);
  

  
  }

  void consultarDataUnidad(int id) async{
    // _cargandoController.sink.add(true);
    final respuesta = await _usuarioProvider.consultarDataUnidad(id);
    //UnidadModel unidadModel = UnidadModel.fromJson(respuesta);//= new UsuarioModel();
    
    _aUnidadVehiculosController.sink.add(respuesta);
  }

  void consultarDataCliente2(int id) async{
    // _cargandoController.sink.add(true);
    final prefs = new PreferenciasUsuario();
    Map respuesta = await _usuarioProvider.consultarDataCliente(id);
    var map = new SortedMap(Ordering.byValue());
   
    map.addAll({
      "iCantidadCanjePremios": respuesta["datosCabecera"]["iCantidadCanjePremios"],
      "iCantidadServicios": respuesta["datosCabecera"]["iCantidadServicios"],
      "iCantidadVehiculos": respuesta["datosCabecera"]["iCantidadVehiculos"],
    });
    print(map.keys.last);
    String valorString = map[map.keys.last].toString();
    int cantidadCeros = valorString.length;
    int iCantidadCanjePremios = respuesta["datosCabecera"]["iCantidadCanjePremios"];
    int iCantidadServicios = respuesta["datosCabecera"]["iCantidadServicios"];
    int iCantidadVehiculos = respuesta["datosCabecera"]["iCantidadVehiculos"];
    if(iCantidadCanjePremios.toString().length<cantidadCeros){
      respuesta["datosCabecera"]["iCantidadCanjePremios"] = rellenarCerosIzquierda(iCantidadCanjePremios,cantidadCeros);
    }else if(iCantidadCanjePremios.toString().length==1){
      respuesta["datosCabecera"]["iCantidadCanjePremios"] = "0" + iCantidadCanjePremios.toString();
    }
    if(iCantidadServicios.toString().length<cantidadCeros){
      respuesta["datosCabecera"]["iCantidadServicios"] = rellenarCerosIzquierda(iCantidadServicios,cantidadCeros);
    }else if(iCantidadServicios.toString().length==1){
      respuesta["datosCabecera"]["iCantidadServicios"] = "0" + iCantidadServicios.toString();
    }
    if(iCantidadVehiculos.toString().length<cantidadCeros){
      respuesta["datosCabecera"]["iCantidadVehiculos"] = rellenarCerosIzquierda(iCantidadVehiculos,cantidadCeros);
    }else if(iCantidadVehiculos.toString().length==1){
      respuesta["datosCabecera"]["iCantidadVehiculos"] = "0" + iCantidadVehiculos.toString();
    }
    UsuarioModel usuarioModel = UsuarioModel.fromJson(respuesta);//= new UsuarioModel();
    // UsuarioModel usuarioModel = UsuarioModel.fromJson(info);
    final jsonEncoder = JsonEncoder();
        
    prefs.usuarioInfo =jsonEncoder.convert(usuarioModel);
    prefs.sNombresUsuario = "${usuarioModel.sNombres} ${usuarioModel.sApellidoPaterno}";
    prefs.sNumeroDocumento = "${usuarioModel.sNumeroDocumento}";
    prefs.sImagen = "${usuarioModel.sImagen}";
    prefs.iId = usuarioModel.iId; 
    prefs.sCelular = usuarioModel.sCelular; 
    
    _oUsuarioController.sink.add(usuarioModel);
  
  }

  String rellenarCerosIzquierda(valorCantidad,cantidadCeros){
        String sCantidadCanjePremios="";
      var n = valorCantidad.toString().length; 
      do { 
          sCantidadCanjePremios ="0" + sCantidadCanjePremios;
          n++;
      }
      while(n<cantidadCeros);
      print(sCantidadCanjePremios) ;
      sCantidadCanjePremios = sCantidadCanjePremios + valorCantidad.toString();
      return sCantidadCanjePremios;
  }

  Future<String> obtenerIdImagen(BuildContext context , String fileType,String fileName, String base64String, File image) async{
    // _cargandoController.sink.add(true);
    String respuesta = await _usuarioProvider.obtenerIdImagen(context, fileType, fileName, base64String, image);
    return respuesta;
  
  }

  Future<String> obtenerUrlImagen(BuildContext context , String idImagen,int iId) async{
    // _cargandoController.sink.add(true);
    String respuesta = await _usuarioProvider.obtenerUrlImagen(context, idImagen,iId);
    // _oUsuarioController.sink.add(respuesta);
    UsuarioModel usuarioModel = _oUsuarioController.value;
    usuarioModel.sImagen = respuesta;
    _oUsuarioController.sink.add(usuarioModel);
    return respuesta;
  
  }



  dispose(){
    _oUsuarioController?.close();
  }
}
