// To parse this JSON data, do
//
//     final puntosAcumulado = puntosAcumuladoFromJson(jsonString);



import 'dart:convert';


class PuntosAcumuladosModel {
  List<PuntosAcumuladoModel> items = new List();

  PuntosAcumuladosModel();
  PuntosAcumuladosModel.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final unidad = new PuntosAcumuladoModel.fromJson(item);
      items.add(unidad);
    }
  }
}
// To parse this JSON data, do
//
//     final puntosAcumuladoModel = puntosAcumuladoModelFromJson(jsonString);


PuntosAcumuladoModel puntosAcumuladoModelFromJson(String str) => PuntosAcumuladoModel.fromJson(json.decode(str));

String puntosAcumuladoModelToJson(PuntosAcumuladoModel data) => json.encode(data.toJson());

class PuntosAcumuladoModel {
    int iId;
    int idUsuarioCliente;
    String sConcesionario;
    String sCodConcesionario;
    String sIdeDlr;
    String sCodLocal;
    String sNomLocal;
    String sFecApertura;
    String sNumPlaca;
    int iPuntosAcumulados;

    PuntosAcumuladoModel({
        this.iId,
        this.idUsuarioCliente,
        this.sConcesionario,
        this.sCodConcesionario,
        this.sIdeDlr,
        this.sCodLocal,
        this.sNomLocal,
        this.sFecApertura,
        this.sNumPlaca,
        this.iPuntosAcumulados,
    });

    factory PuntosAcumuladoModel.fromJson(Map<String, dynamic> json) => PuntosAcumuladoModel(
        iId: json["iId"],
        idUsuarioCliente: json["idUsuarioCliente"],
        sConcesionario: json["sConcesionario"],
        sCodConcesionario: json["sCodConcesionario"],
        sIdeDlr: json["sIdeDlr"],
        sCodLocal: json["sCodLocal"],
        sNomLocal: json["sNomLocal"],
        sFecApertura: json["sFecApertura"],
        sNumPlaca: json["sNumPlaca"],
        iPuntosAcumulados : json["iPuntosAcumulados"],
    );

    Map<String, dynamic> toJson() => {
        "iId": iId,
        "idUsuarioCliente": idUsuarioCliente,
        "sConcesionario": sConcesionario,
        "sCodConcesionario": sCodConcesionario,
        "sIdeDlr": sIdeDlr,
        "sCodLocal": sCodLocal,
        "sNomLocal": sNomLocal,
        "sFecApertura": sFecApertura,
        "sNumPlaca": sNumPlaca,
        "iPuntosAcumulados" : iPuntosAcumulados
    };
}
