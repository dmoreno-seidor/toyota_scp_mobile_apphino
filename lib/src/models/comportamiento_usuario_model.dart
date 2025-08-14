// import 'dart:convert';

/// @author Daniel Carpio
class ComportamientoUsuarioModel {
  final int iId;
  final String sStatusAPP;
  final DateTime dFechaApertura;
  final DateTime dHoraApertura;
  final double nCoordenadaX;
  final double nCoordenadaY;
  final String sCiudad;
  final String sRegion;
  final int iIdUsuario;
  final String sStatusLoggeado;
  final String sCuentaActivada;
  final String sStatusIngresoModuloCatalogo;
  final String sStatusWhatsapp;
  final String sStatusRedConcesionario;
  final String sStatusIngresoModuloCitas;
  final int iIdTipoServicio;
  final int iIdSubTipoServicio;
  final String sTipoServicio;
  final String sSubTipoServicio;
  final DateTime dFechaServicio;
  final DateTime dFechaCierre;
  final DateTime dHoraCierre;
  final String sUsuarioCreacion;
  final String sUSuarioModificador;

  const ComportamientoUsuarioModel({
    this.iId,
    this.sStatusAPP,
    this.dFechaApertura,
    this.dHoraApertura,
    this.nCoordenadaX,
    this.nCoordenadaY,
    this.sCiudad,
    this.sRegion,
    this.iIdUsuario,
    this.sStatusLoggeado,
    this.sCuentaActivada,
    this.sStatusIngresoModuloCatalogo,
    this.sStatusWhatsapp,
    this.sStatusRedConcesionario,
    this.sStatusIngresoModuloCitas,
    this.iIdTipoServicio,
    this.iIdSubTipoServicio,
    this.sTipoServicio,
    this.sSubTipoServicio,
    this.dFechaServicio,
    this.dFechaCierre,
    this.dHoraCierre,
    this.sUsuarioCreacion,
    this.sUSuarioModificador,
  });

  static ComportamientoUsuarioModel fromJson(dynamic json) =>
      ComportamientoUsuarioModel(
        iId: json['Id'],
        sStatusAPP: json['StatusAPP'],
        dFechaApertura: json['FechaApertura'] != null ? DateTime.parse(json['FechaApertura']) : null,
        dHoraApertura: json['HoraApertura'] != null ? DateTime.parse(json['HoraApertura']) : null,
        nCoordenadaX: json['CoordenadaX'],
        nCoordenadaY: json['CoordenadaY'],
        sCiudad: json['Ciudad'],
        sRegion: json['Region'],
        iIdUsuario: json['IdUsuario'],
        sStatusLoggeado: json['StatusLoggeado'],
        sCuentaActivada: json['CuentaActivada'],
        sStatusIngresoModuloCatalogo: json['StatusIngresoModuloCatalogo'],
        sStatusWhatsapp: json['StatusWhatsapp'],
        sStatusRedConcesionario: json['StatusRedConcesionario'],
        sStatusIngresoModuloCitas: json['StatusIngresoModuloCitas'],
        iIdTipoServicio: json['IdTipoServicio'],
        iIdSubTipoServicio: json['IdSubTipoServicio'],
        sTipoServicio: json['TipoServicio'],
        sSubTipoServicio: json['SubTipoServicio'],
        dFechaServicio: json['FechaServicio'] != null ? DateTime.parse(json['FechaServicio']) : null,
        dFechaCierre: json['FechaCierre'] != null ? DateTime.parse(json['FechaCierre']) : null,
        dHoraCierre: json['HoraCierre'] != null ? DateTime.parse(json['HoraCierre']) : null,
        sUsuarioCreacion: json['UsuarioCreacion'],
        sUSuarioModificador: json['USuarioModificador'],
      );

  Map<String, dynamic> toJson() => {
      "iId": iId,
      "sStatusAPP": sStatusAPP,
      "dFechaApertura": dFechaApertura?.toIso8601String(),
      "dHoraApertura": dHoraApertura?.toIso8601String(),
      "nCoordenadaX": nCoordenadaX,
      "nCoordenadaY": nCoordenadaY,
      "sCiudad": sCiudad,
      "sRegion": sRegion,
      "iIdUsuario": iIdUsuario,
      "sStatusLoggeado": sStatusLoggeado,
      "sCuentaActivada": sCuentaActivada,
      "sStatusIngresoModuloCatalogo": sStatusIngresoModuloCatalogo,
      "sStatusWhatsapp": sStatusWhatsapp,
      "sStatusRedConcesionario": sStatusRedConcesionario,
      "sStatusIngresoModuloCitas": sStatusIngresoModuloCitas,
      "iIdTipoServicio": iIdTipoServicio,
      "iIdSubTipoServicio": iIdSubTipoServicio,
      "sTipoServicio": sTipoServicio,
      "sSubTipoServicio": sSubTipoServicio,
      "dFechaServicio": dFechaServicio?.toIso8601String(),
      "dFechaCierre": dFechaCierre?.toIso8601String(),
      "dHoraCierre": dHoraCierre?.toIso8601String(),
      "sUsuarioCreacion": sUsuarioCreacion,
      "sUSuarioModificador": sUSuarioModificador,
    };

  @override
  String toString() => 'ComportamientoUsuarioModel { iId: $iId }';
}
