//
//     final usuarioModel = usuarioModelFromJson(jsonString);

import 'dart:convert';

import 'package:toyota_scp_mobile_apphino/src/models/unidad_model.dart';

UsuarioModel usuarioModelFromJson(String str) =>
    UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
  int iId;
  String sNumeroDocumento;
  String sNombres;
  String sApellidoPaterno;
  String sApellidoMaterno;
  String dFechaNacimiento;
  String sCorreo;
  String sPassword;
  String sCelular;
  int idTipoDocumento;
  String sTipoDocumento;
  int idTipoUsuario;
  int iPuntosAcumulados;
  // int iCantidadPremios;
  // int iCantidadServicios;
  // int iCantidadVehiculos;
  String iCantidadPremios;
  String iCantidadServicios;
  String iCantidadVehiculos;
  String sImagenCategoriaUsuario;
  String sLabelCategoriaUsuario;
  String sImagen;
  String sTipoUsuario;
  String dPuntosFechaVencimiento;
  String sAppleId;
  bool bTerminoCondiciones;
  bool bAutorizacionDatosPersonales;
  dynamic aUnidades = new List<UnidadModel>();
  int idEstadoActivacion;

  UsuarioModel(
      {this.iId,
      this.sNumeroDocumento = '',
      this.sNombres = '',
      this.sApellidoPaterno = '',
      this.sApellidoMaterno = '',
      this.dFechaNacimiento = '',
      this.sCorreo = '',
      this.sCelular = '',
      this.sPassword = '',
      this.idTipoDocumento = 103,
      this.sTipoDocumento = '',
      this.idTipoUsuario = 0,
      this.iPuntosAcumulados = 0,
      this.iCantidadPremios = '0',
      this.iCantidadServicios = '0',
      this.iCantidadVehiculos = '0',
      this.sImagenCategoriaUsuario,
      this.sLabelCategoriaUsuario,
      this.sImagen = '',
      this.sTipoUsuario = '',
      this.dPuntosFechaVencimiento,
      this.sAppleId = '',
      this.bTerminoCondiciones = false,
      this.bAutorizacionDatosPersonales = false,
      this.aUnidades,
      this.idEstadoActivacion = 0});

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        iId: json['datosUsuario']["iId"],
        sNumeroDocumento: json['datosUsuario']["sNumeroDocumento"] == null
            ? ''
            : json['datosUsuario']['sNumeroDocumento'],
        sNombres: json['datosUsuario']['sNombres'] == null
            ? ''
            : json['datosUsuario']['sNombres'],
        sApellidoPaterno: json['datosUsuario']['sApellidoPaterno'] == null
            ? ''
            : json['datosUsuario']['sApellidoPaterno'],
        sApellidoMaterno: json['datosUsuario']['sApellidoMaterno'] == null
            ? ''
            : json['datosUsuario']['sApellidoMaterno'],
        dFechaNacimiento: json['datosUsuario']["dFechaNacimiento"] == null
            ? ''
            : json['datosUsuario']["dFechaNacimiento"],
        sCorreo: json['datosUsuario']['sCorreo'] == null
            ? ''
            : json['datosUsuario']['sCorreo'],
        sCelular: json['datosUsuario']['sCelular'] == null
            ? ''
            : json['datosUsuario']['sCelular'],
        sTipoDocumento: json['datosUsuario']['sTipoDocumento'] == null
            ? ''
            : json['datosUsuario']['sTipoDocumento'],
        iPuntosAcumulados: json['datosCabecera']['iPuntosAcumulados'] == null
            ? 0
            : json['datosCabecera']['iPuntosAcumulados'],
        iCantidadPremios: json['datosCabecera']['iCantidadCanjePremios'] == null
            ? '0'
            : json['datosCabecera']['iCantidadCanjePremios'].toString(),
        iCantidadServicios: json['datosCabecera']['iCantidadServicios'] == null
            ? '0'
            : json['datosCabecera']['iCantidadServicios'].toString(),
        iCantidadVehiculos: json['datosCabecera']['iCantidadVehiculos'] == null
            ? '0'
            : json['datosCabecera']['iCantidadVehiculos'].toString(),
        sImagenCategoriaUsuario:
            json['datosUsuario']['sImagenCategoriaUsuario'] == null
                ? ''
                : json['datosUsuario']['sImagenCategoriaUsuario'],
        sLabelCategoriaUsuario:
            json['datosUsuario']['sLabelCategoriaUsuario'] == null
                ? ''
                : json['datosUsuario']['sLabelCategoriaUsuario'],
        sImagen: json['datosUsuario']['sImagen'] == null
            ? ''
            : json['datosUsuario']['sImagen'],
        sTipoUsuario: json['datosUsuario']['sTipoUsuario'] == null
            ? ''
            : json['datosUsuario']['sTipoUsuario'],
        dPuntosFechaVencimiento:
            json['datosCabecera']['dPuntosFechaVencimiento'] == null
                ? ''
                : json['datosCabecera']['dPuntosFechaVencimiento'],
        aUnidades: jsonEncode(json[
            "datosUnidad"]), //json["datosUnidad"]==null?[]:json["datosUnidad"],
        idEstadoActivacion: json['datosUsuario']['idEstadoActivacion'] == null
            ? 0
            : json['datosUsuario']['idEstadoActivacion'],
      );

  Map<String, dynamic> toJson() => {
        "iId": iId,
        "sNumeroDocumento": sNumeroDocumento,
        "sNombres": sNombres,
        "sApellidoPaterno": sApellidoPaterno,
        "sApellidoMaterno": sApellidoMaterno,
        "dFechaNacimiento": dFechaNacimiento,
        "sCorreo": sCorreo,
        "sPassword": sPassword,
        "sCelular": sCelular,
        "idTipoDocumento": idTipoDocumento,
        "sTipoDocumento": sTipoDocumento,
        "idTipoUsuario": idTipoUsuario,
        "iPuntosAcumulados": iPuntosAcumulados,
        "iCantidadPremios": iCantidadPremios,
        "iCantidadServicios": iCantidadServicios,
        "iCantidadVehiculos": iCantidadVehiculos,
        "sImagenCategoriaUsuario": sImagenCategoriaUsuario,
        "sLabelCategoriaUsuario": sLabelCategoriaUsuario,
        "sImagen": sImagen,
        "sTipoUsuario": sTipoUsuario,
        "dPuntosFechaVencimiento": dPuntosFechaVencimiento,
        "sAppleId": sAppleId,
        "bTerminoCondiciones": bTerminoCondiciones,
        "bAutorizacionDatosPersonales": bAutorizacionDatosPersonales,
        "aUnidades": aUnidades == null
            ? []
            : aUnidades, //List<UnidadModel>.from(aUnidades.map((x) => x)),
        "idEstadoActivacion": idEstadoActivacion
      };
}
