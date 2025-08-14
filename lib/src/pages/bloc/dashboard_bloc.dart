
import 'package:rxdart/subjects.dart';

class DashboardBloc{
  final _selectedIndexController = BehaviorSubject<int>.seeded(0);

  Stream<int> get selectedIndexStream => _selectedIndexController.stream;
  Function(int) get changeSelectedIndex => _selectedIndexController.sink.add;
  int get selectedIndexLastValue => _selectedIndexController.value;
  
  dispose() {
    _selectedIndexController?.close();
  }

}





