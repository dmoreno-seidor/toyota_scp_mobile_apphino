import 'dart:convert';

class UnidadesModel {
  List<UnidadModel> items = new List();

  UnidadesModel();
  UnidadesModel.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final unidad = new UnidadModel.fromJson(item);
      items.add(unidad);
    }
  }
}

// To parse this JSON data, do
//
//     final unidadModel = unidadModelFromJson(jsonString);



UnidadModel unidadModelFromJson(String str) => UnidadModel.fromJson(json.decode(str));

String unidadModelToJson(UnidadModel data) => json.encode(data.toJson());

class UnidadModel {
    int iId;
    String sNumPlaca;
    String sModelo;
    String sVin;
    String sMotor;
    int sAnio;
    String sTipoCarroceria;
    int idTipoCarroceria;
    String sMaterialCarroceria;
    int idMaterialCarroceria;
    String sRuc;
    String sEmpresaCarroceria;
    // DateTime dFechaCreacion;
    String sUsuarioCreacion;
    int iPuntosAcumulados;
    String sEstado;
    int idEstado;

    UnidadModel({
        this.iId,
        this.sNumPlaca,
        this.sModelo,
        this.sVin,
        this.sMotor,
        this.sAnio,
        this.sTipoCarroceria,
        this.idTipoCarroceria,
        this.sMaterialCarroceria,
        this.idMaterialCarroceria,
        this.sRuc,
        this.sEmpresaCarroceria,
        // this.dFechaCreacion,
        this.sUsuarioCreacion,
        this.iPuntosAcumulados,
        this.sEstado,
        this.idEstado,
    });

    factory UnidadModel.fromJson(Map<String, dynamic> json) => UnidadModel(
        iId: json["iId"],
        sNumPlaca: json["sNumPlaca"],
        sModelo: json["sModelo"],
        sVin: json["sVin"],
        sMotor: json["sMotor"],
        sAnio: json["sAnio"],
        sTipoCarroceria: json["sTipoCarroceria"],
        idTipoCarroceria: json["idTipoCarroceria"],
        sMaterialCarroceria: json["sMaterialCarroceria"],
        idMaterialCarroceria: json["idMaterialCarroceria"],
        sRuc: json["sRuc"],
        sEmpresaCarroceria: json["sEmpresaCarroceria"],
        // dFechaCreacion: DateTime.parse(json["dFechaCreacion"]),
        sUsuarioCreacion: json["sUsuarioCreacion"],
        iPuntosAcumulados: json["iPuntosAcumulados"],
        sEstado: json["sEstado"],
        idEstado: json["idEstado"],
    );

    Map<String, dynamic> toJson() => {
        "iId": iId,
        "sNumPlaca": sNumPlaca,
        "sModelo": sModelo,
        "sVin": sVin,
        "sMotor": sMotor,
        "sAnio": sAnio,
        "sTipoCarroceria": sTipoCarroceria,
        "idTipoCarroceria": idTipoCarroceria,
        "sMaterialCarroceria": sMaterialCarroceria,
        "idMaterialCarroceria": idMaterialCarroceria,
        "sRuc": sRuc,
        "sEmpresaCarroceria": sEmpresaCarroceria,
        // "dFechaCreacion": dFechaCreacion.toIso8601String(),
        "sUsuarioCreacion": sUsuarioCreacion,
        "iPuntosAcumulados": iPuntosAcumulados,
        "sEstado": sEstado,
        "idEstado": idEstado,
    };
}
