import 'package:rxdart/subjects.dart';
import 'package:toyota_scp_mobile_apphino/src/models/ciudad_model.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/ciudad_provider.dart';

class CiudadBloc{
  final _ciudadesController = new BehaviorSubject<List<CiudadModel>>();
  final _cargandoController = new BehaviorSubject<bool>();
  final _ciudadProvider = new CiudadProvider();

  Stream<List<CiudadModel>> get ciudadesStream => _ciudadesController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarCiudades() async{
    final ciudades = await _ciudadProvider.cargarCiudades();
    _ciudadesController.sink.add(ciudades);
  }
  
  dispose() {
    _ciudadesController?.close();
    _cargandoController?.close();
  }

}





