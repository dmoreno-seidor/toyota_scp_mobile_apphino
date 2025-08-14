import 'dart:async';

enum NavBarItem { HOME, CATALOGO, CITAS,CAMPANIA,NOTICIAS }

class BottomNavBarBloc {
  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.HOME;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
    
        _navBarController.sink.add(NavBarItem.HOME);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.CATALOGO);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.CITAS);
        break;
      case 3:
        _navBarController.sink.add(NavBarItem.CAMPANIA);
        break;
      case 4:
        _navBarController.sink.add(NavBarItem.NOTICIAS);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}