import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/models/puntos_acumulado_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/usuario_provider.dart';

import '../../models/unidad_model.dart';
import '../../providers/usuario_provider.dart';

class MisPuntosBloc with Validators {
  //----

  final _aUnidadesController = BehaviorSubject<List<UnidadModel>>();
  final _aPuntosAcumuladosController =
      BehaviorSubject<List<PuntosAcumuladoModel>>();
  final _aPuntosAcumuladosFiltradaController = BehaviorSubject<List<PuntosAcumuladoModel>>();
  final _usuarioProvider = new UsuarioProvider();
  final _sFilterController = BehaviorSubject<String>.seeded('');

  Stream<List<UnidadModel>> get aUnidadesStream => _aUnidadesController.stream;
  Stream<List<PuntosAcumuladoModel>> get aPuntosAcumuladosStream =>
      _aPuntosAcumuladosController.stream;
  Stream<List<PuntosAcumuladoModel>> get aPuntosAcumuladosFiltradaStream =>
      _aPuntosAcumuladosFiltradaController.stream;
  Stream<String> get sFilterStream => _sFilterController.stream;

  Function(String) get changePlaca => _sFilterController.sink.add;

  Stream<List<PuntosAcumuladoModel>> get filterApuntosAcumulados =>
      Rx.combineLatest2(aPuntosAcumuladosStream, sFilterStream, (list, filter) {
        List<PuntosAcumuladoModel> aDatosPuntosAcumuladosFiltrado =
            new List<PuntosAcumuladoModel>();
        if (filter.isNotEmpty) {
          list.forEach((item) {
            if (item.sNumPlaca == filter) {
              aDatosPuntosAcumuladosFiltrado.add(item);
            }
          });

          return aDatosPuntosAcumuladosFiltrado;
        } else {
          return list;
        }
      });

  void obtenerRegistroPuntosxCliente(BuildContext context, int id) async {
    // _cargandoController.sink.add(true);
    Map<String, dynamic> respuesta =
        await _usuarioProvider.obtenerRegistroPuntosxCliente(context, id);
    // UnidadModel unidadModel = UnidadModel();
    List<UnidadModel> aUnidades = new List<UnidadModel>();
    List<PuntosAcumuladoModel> aDatosPuntosAcumulados =
        new List<PuntosAcumuladoModel>();
    if (respuesta["datosPlaca"].length > 0) {
      //  final Map<String, dynamic> otros = {
      //    "sNumPlaca" : "OTROS",
      //       };
      // respuesta["datosPlaca"].add(otros);
      aUnidades = UnidadesModel.fromJsonList(respuesta["datosPlaca"]).items;
    }
    if (respuesta["datosPuntosAcumulados"].length > 0) {
      aDatosPuntosAcumulados =
          PuntosAcumuladosModel.fromJsonList(respuesta["datosPuntosAcumulados"])
              .items;
    }

    _aPuntosAcumuladosController.sink.add(aDatosPuntosAcumulados);
    _aUnidadesController.sink.add(aUnidades);
    print(respuesta);
  }

  void filtrarPorPlaca(String query) {}

  dispose() {
    _aUnidadesController?.close();
    _aPuntosAcumuladosController?.close();
    _aPuntosAcumuladosFiltradaController?.close();
  }
}
