// import 'dart:io';

import 'package:rxdart/subjects.dart';
import 'package:toyota_scp_mobile_apphino/src/models/cargo_usuario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/cargo_usuario_provider.dart';

class CargoUsuarioBloc {
  final _cargoUsuariosController =
      new BehaviorSubject<List<CargoUsuarioModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _cargoUsuarioProvider = new CargoUsuarioProvider();

  Stream<List<CargoUsuarioModel>> get cargoUsuariosStream =>
      _cargoUsuariosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarCargoUsuario() async {
    final cargoUsuarios = await _cargoUsuarioProvider.cargarCargoUsuario();
    _cargoUsuariosController.sink.add(cargoUsuarios);
  }

  dispose() {
    _cargoUsuariosController?.close();
    _cargandoController?.close();
  }
}
