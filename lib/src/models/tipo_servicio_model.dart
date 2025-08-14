import 'dart:convert';

TipoServicioModel tipoServicioFromJson(String str) =>
    TipoServicioModel.fromJson(json.decode(str));

String tipoServicioToJson(TipoServicioModel data) => json.encode(data.toJson());

class TipoServicioModel {
  int id;
  String codigo;
  String descripcion;
  String iconoActivo;
  String iconoDesactivado;
  String estado;
  bool seleccionado;

  TipoServicioModel(
      {this.id,
      this.codigo,
      this.descripcion,
      this.iconoActivo,
      this.iconoDesactivado,
      this.estado,
      this.seleccionado});

  factory TipoServicioModel.fromJson(Map<String, dynamic> json) =>
      TipoServicioModel(
        id: json["ID"],
        codigo: json["CODIGO"],
        descripcion: json["DESCRIPCION"],
        iconoActivo: json["ICONO_ACTIVO"],
        iconoDesactivado: json["ICONO_DESACTIVADO"],
        estado: json["ESTADO"],
        seleccionado: json["bSeleccionado"] == 0 ? false : true,
      );

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "codigo": this.codigo,
        "descripion": this.descripcion,
        "iconActivo": this.iconoActivo,
        "iconoDesactivado": this.iconoDesactivado,
        "estado": this.estado,
        "seleccionado": this.seleccionado
      };
}
