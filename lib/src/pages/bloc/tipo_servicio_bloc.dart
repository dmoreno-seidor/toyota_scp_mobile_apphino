import 'package:rxdart/subjects.dart';

import '../../models/tipo_servicio_model.dart';
import '../../providers/tipo_servicio_provider.dart';

class TipoServicioBloc {
  final _tipoServiciosController =
      new BehaviorSubject<List<TipoServicioModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _tipoServicioProvider = new TipoServicioProvider();

  Stream<List<TipoServicioModel>> get tipoServiciosStream =>
      _tipoServiciosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarTipoServicio() async {
    final tipoServicios = await _tipoServicioProvider.cargarTipoServicio();
    _tipoServiciosController.sink.add(tipoServicios);
  }

  dispose() {
    _tipoServiciosController?.close();
    _cargandoController?.close();
  }
}
