// To parse this JSON data, do
//
//     final eventoModel = eventoModelFromJson(jsonString);

import 'dart:convert';

EventoModel eventoModelFromJson(String str) => EventoModel.fromJson(json.decode(str));

String eventoModelToJson(EventoModel data) => json.encode(data.toJson());

class EventoModel {
    String id;
    String imagen;
    String nombre;
    String publicadoDesde;
    String publicadoHasta;
    String dia;
    String diaEvento;
    String horaEvento;
    String fechaEvento;
    String lugarNombre;
    String lugarDireccion;
    String unique;

    EventoModel({
        this.id,
        this.imagen,
        this.nombre,
        this.publicadoDesde,
        this.publicadoHasta,
        this.dia,
        this.diaEvento,
        this.horaEvento,
        this.fechaEvento,
        this.lugarNombre,
        this.lugarDireccion,
        this.unique,
    });

    factory EventoModel.fromJson(Map<String, dynamic> json) => EventoModel(
        id: json["id"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        publicadoDesde: json["publicadoDesde"],
        publicadoHasta: json["publicadoHasta"],
        dia: json["dia"],
        diaEvento: json["diaEvento"],
        horaEvento: json["horaEvento"],
        fechaEvento: json["fechaEvento"],
        lugarNombre: json["lugarNombre"],
        lugarDireccion: json["lugarDireccion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "imagen": imagen,
        "nombre": nombre,
        "publicadoDesde": publicadoDesde,
        "publicadoHasta": publicadoHasta,
        "dia": dia,
        "diaEvento": diaEvento,
        "horaEvento": horaEvento,
        "fechaEvento": fechaEvento,
        "lugarNombre": lugarNombre,
        "lugarDireccion": lugarDireccion,
    };
}
