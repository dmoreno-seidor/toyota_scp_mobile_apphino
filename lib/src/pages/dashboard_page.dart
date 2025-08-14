// import 'dart:convert';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/models/usuario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/Provider.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/usuario_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/campanias_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/catalogo_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/citas_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/home_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/noticias_page.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/usuario_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/menu_widget.dart';

import 'bloc/bottom-navbar-bloc.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);
  static final String routeName = "dashboard";
  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> with WidgetsBindingObserver {
   final prefs = new PreferenciasUsuario();
   final usuarioProvider = new UsuarioProvider();
  //  UsuarioBloc usuarioBloc = new UsuarioBloc();
   UsuarioModel usuarioData;
   BottomNavBarBloc _bottomNavBarBloc;
     StreamSubscription<Position> _positionStream;
 
  int selectedIndex = 0;
  final tabs = [
          HomePage(),
          CatalogoPage(),
          CitasPage(),
          CampaniasPage(),
          NoticiasPage(),
        ];

        @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _bottomNavBarBloc = BottomNavBarBloc();
    // usuarioBloc.consultarDataCliente2(prefs.iId);
    
     Future.delayed(Duration.zero, () {
    //   setState(() {
      //  usuarioBloc.consultarDataCliente2(prefs.iId);
    //       _test();
          });
    usuarioProvider.actualizarTokenFirebase(context,prefs.iId,prefs.token);
    _startTracking();
  }

 _startTracking(){
    final geolocator = Geolocator();
    final locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 5);

    _positionStream = geolocator.getPositionStream(locationOptions).listen(
    _onLocationUpdate);
  }
  _onLocationUpdate(Position position){
    if(position!=null){
      print(position);
      // usuarioLocationBloc.changePosition(position);d
      prefs.latitude = position.latitude;
      prefs.longitud = position.longitude;
    }}

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // went to Background
      ComportamientoUsuario.registrarEvento(prefs, cierreApp: true);
    }
    if (state == AppLifecycleState.resumed) {
      // came back to Foreground
      print('On resume...');
    }
  }

  @override
  Widget build(BuildContext context) {
   final catalogoBloc = Provider.catalogoBloc(context);
   final citasBloc = Provider.citasBloc(context);
   final campaniaBloc = Provider.campaniaBloc(context);
   final noticiasBloc = Provider.noticiasBloc(context);
   final usuarioBloc = Provider.usuarioBloc(context);
   usuarioBloc.consultarDataCliente2(prefs.iId);
  

    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Scaffold(
        key: _scaffoldKey,
        drawer: Container(
            width: MediaQuery.of(context).size.width * 0.60,
            child: MenuWidget()),

        body: 

        StreamBuilder<NavBarItem>(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data) {
           
            case NavBarItem.HOME:

                return Container(
                    child: Stack(
                      children: <Widget>[
                        HomePage(),
                        Positioned(
                          // top: 10.0,
                          left: 0.0,
                          right: 0.0,
                          child: SafeArea(
                            child: Container(
                              // margin: EdgeInsets.only(top:2),
                              child: _crearBarraAppBar(context, _scaffoldKey,snapshot,usuarioBloc),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
              // return HomePage();
            case NavBarItem.CATALOGO:
              return CatalogoPage();
            case NavBarItem.CITAS:
           
               return CitasPage();
            case NavBarItem.CAMPANIA:
              return CampaniasPage();
            case NavBarItem.NOTICIAS:
     
              return NoticiasPage();
          }
        },
      ),



        bottomNavigationBar: 
        // _crearBootomNavigationbar()
        StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          
Responsive _responsive = new Responsive(context);
    return BottomNavigationBar(
      // key: globalKey2,
      type: BottomNavigationBarType.fixed,
      currentIndex: snapshot.data.index,
      fixedColor: Color(0xFFE60012),
      onTap: _bottomNavBarBloc.pickItem,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/home/inicio.png',
              width: _responsive.ip(2.73),//18.25,
              height: _responsive.ip(2.4)//16,
            ),
            activeIcon: new Image.asset(
              'assets/home/inicioActivate.png',
              // width: 16,
               width: _responsive.ip(2.73),//18.25,
              height: _responsive.ip(2.4)//16,
            ),
            title: Text('Inicio',
            style: TextStyle(
    fontSize: _responsive.ip(1.5),
    fontFamily: "HelveticaNeue",
  )
            // AppConfig.styleNavigationBarItem,
            )),
        BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/home/catalogo.png',
              // width: 23,
               width: _responsive.ip(2.73),//18.25,
              height: _responsive.ip(2.4)//16,
            ),
            activeIcon: new Image.asset(
              'assets/home/catalogoActivate.png',
              // width: 23,
              // height: 23,
               width: _responsive.ip(2.73),//18.25,
              height: _responsive.ip(2.4)//16,
            ),
            title: Text('Catálogo', 
            // style: AppConfig.styleNavigationBarItem
            style: TextStyle(
    fontSize: _responsive.ip(1.5),
    fontFamily: "HelveticaNeue",
  )
            )),
        BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/home/citas.png',
              // width: 23,
              // height: 23,
                width: _responsive.ip(2.73),//18.25,
              height: _responsive.ip(2.4)//16,
            ),
            activeIcon: new Image.asset(
              'assets/home/citasActivate.png',
              // width: 23,
              // height: 23,
                width: _responsive.ip(2.73),//18.25,
              height: _responsive.ip(2.4)//16,
            ),
            title: Text('Citas', 
            style: TextStyle(
    fontSize: _responsive.ip(1.5),
    fontFamily: "HelveticaNeue",
  )         
            // AppConfig.styleNavigationBarItem
            )),
        BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/home/campania.png',
              // width: 23,
              // height: 23,
                width: _responsive.ip(2.73),//18.25,
              height: _responsive.ip(2.4)//16,
            ),
            activeIcon: new Image.asset(
              'assets/home/campaniaActivate.png',
              // width: 23,
              // height: 23,
                width: _responsive.ip(2.73),//18.25,
              height: _responsive.ip(2.4)//16,
            ),
            title: Text('Campañas', 
            style: TextStyle(
    fontSize: _responsive.ip(1.5),
    fontFamily: "HelveticaNeue",
  )
            // style: AppConfig.styleNavigationBarItem
            )),
        BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/home/noticias.png',
              // width: 23,
              // height: 23,
                width: _responsive.ip(2.73),//18.25,
              height: _responsive.ip(2.4)//16,
            ),
            activeIcon: new Image.asset(
              'assets/home/noticiasActivate.png',
              // width: 23,
              // height: 23,
                width: _responsive.ip(2.73),//18.25,
              height: _responsive.ip(2.4)//16,
            ),
            title: Text('Noticias', 
            // style: AppConfig.styleNavigationBarItem
            style: TextStyle(
    fontSize: _responsive.ip(1.5),
    fontFamily: "HelveticaNeue",
  ),
            ))
      ],
      
    );
  })
        
        
        
        );
  }

  Widget _crearBarraAppBar(context, _scaffoldKey , AsyncSnapshot snapshot,UsuarioBloc usuarioBloc) {
    Responsive _responsive = new Responsive(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        snapshot.hasData?
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _scaffoldKey.currentState.openDrawer(),
          child: Container(
            padding: EdgeInsets.only(left: 16,top: 10,bottom: 12,right: 16),
                      child: Container(
              // margin: EdgeInsets.only(left: 16),
              height: _responsive.ip(1.8),//12, 
              width: _responsive.ip(2.4),//16, 
              decoration: new BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage('assets/home/sandwich.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ):Container(
            margin: EdgeInsets.only(left: 54),
            height: _responsive.ip(1.8),//12, 
            width: _responsive.ip(2.4),//16, 
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('assets/home/sandwich.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        Container(
          // margin: EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'preguntasFrecuentes'),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: EdgeInsets.only(right: 15,top: 10,left: 15,bottom: 12),
                                  child: Container(
                    height: _responsive.ip(2.4),//16, 
            width: _responsive.ip(2.4),//16, 
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image:
                            new AssetImage('assets/home/preguntasFrecuentes.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   width: 30,
              // ),
              GestureDetector(
                onTap: () {
                    _onExit(usuarioBloc);
                } ,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  
                  padding: EdgeInsets.only(left: 15,right: 16,top: 10,bottom: 12),
                                  child: Container(
                    height: _responsive.ip(2.4),//16, 
            width: _responsive.ip(2.4),//16,  
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: new AssetImage('assets/home/cerrarSesion.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }


  _onExit(UsuarioBloc usuarioBloc){
    Dialogs.confirm(context,title: "Confirmar",message: "Desea Cerrar Sesión?",onCancel: (){
      Navigator.pop(context);
      
    }, onConfirm: ()async{
      Navigator.pop(context);
      prefs.clear();
      // usuarioBloc.dispose();
      // Session session = Session();
      //  await session.clear();
        
                Navigator.pushNamedAndRemoveUntil(
                    context, 'login', (_) => false);
    });
  }

  openDrawer(_scaffoldKey) {
    _scaffoldKey.currentState.openDrawer();
  }

//   Widget _crearBootomNavigationbar() {

//     StreamBuilder(
//         stream: _bottomNavBarBloc.itemStream,
//         initialData: _bottomNavBarBloc.defaultItem,
//         builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {


//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       currentIndex: snapshot.data.index,
//       fixedColor: Color(0xFFE60012),
//       onTap: _bottomNavBarBloc.pickItem,
//       items: <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//             icon: new Image.asset(
//               'assets/home/inicio.png',
//               width: 23,
//               height: 23,
//             ),
//             activeIcon: new Image.asset(
//               'assets/home/inicioActivate.png',
//               width: 23,
//               height: 23,
//             ),
//             title: Text('Inicio')),
//         BottomNavigationBarItem(
//             icon: new Image.asset(
//               'assets/home/catalogo.png',
//               width: 23,
//               height: 23,
//             ),
//             activeIcon: new Image.asset(
//               'assets/home/catalogoActivate.png',
//               width: 23,
//               height: 23,
//             ),
//             title: Text('Catálogo')),
//         BottomNavigationBarItem(
//             icon: new Image.asset(
//               'assets/home/citas.png',
//               width: 23,
//               height: 23,
//             ),
//             activeIcon: new Image.asset(
//               'assets/home/citasActivate.png',
//               width: 23,
//               height: 23,
//             ),
//             title: Text('Citas')),
//         BottomNavigationBarItem(
//             icon: new Image.asset(
//               'assets/home/campania.png',
//               width: 23,
//               height: 23,
//             ),
//             activeIcon: new Image.asset(
//               'assets/home/campaniaActivate.png',
//               width: 23,
//               height: 23,
//             ),
//             title: Text('Campañas')),
//         BottomNavigationBarItem(
//             icon: new Image.asset(
//               'assets/home/noticias.png',
//               width: 23,
//               height: 23,
//             ),
//             activeIcon: new Image.asset(
//               'assets/home/noticiasActivate.png',
//               width: 23,
//               height: 23,
//             ),
//             title: Text('Noticias'))
//       ],
      
//     );
//   });

  
// }
}
