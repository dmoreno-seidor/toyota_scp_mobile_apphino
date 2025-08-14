import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/eventos_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/noticias_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_eventos_loading.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_noticias.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_eventos.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_noticias_loading.dart';
import 'bloc/Provider.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';

class NoticiasPage extends StatefulWidget {
  NoticiasPage({Key key}) : super(key: key);
  static final String routeName = "noticias";
  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final prefs = new PreferenciasUsuario();
  int _currentIndex = 0;
  TabController _controller;

  NoticiasBloc noticiasBloc = NoticiasBloc();
  EventosBloc eventosBloc = EventosBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = new TabController(length: 2, vsync: this);

    //
    Future.delayed(Duration.zero, () {
      //   setState(() {
      noticiasBloc = Provider.noticiasBloc(context);
      eventosBloc = Provider.eventosBloc(context);
      //       _test();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
    final _size = MediaQuery.of(context).size;
    final _responsive = Responsive(context);

    return Scaffold(
      body: Container(
          child: Stack(
        children: <Widget>[
          // Container(
          //   color: Color(0xFFE60012),
          //   width: _size.width,
          //   height: _responsive.hp(36),
          // ),

          new Positioned(
              //  left: 30.0,
              //  top: 30.0,
              child: new Container(
            width: _responsive.wp(100),
            height: _responsive.hp(36),
            decoration: new BoxDecoration(color: Color(0xFFE60012)),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SafeArea(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: _responsive.wp(6), //16,
                          top: _responsive.ip(1),
                          bottom: _responsive.wp(6), //16,
                        ),
                        child: Text(
                          "Noticias",
                          // style: AppConfig.styleCabecerasPaginas,
                          style: TextStyle(
                              // fontFamily: 'HelveticaNeue',
                              fontFamily: "HelveticaNeue",
                              fontSize: _responsive.ip(3.3),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          // top:_responsive.ip(9.6),

                          left: _responsive.wp(6), //16,
                          right: _responsive.wp(6)), //16),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                print(_currentIndex);
                                if (_currentIndex == 1) {
                                  setState(() {
                                    _currentIndex = 0;
                                  });
                                }
                              },
                              child: Container(
                                // width: double.infinity,
                                height: _responsive.ip(7.2), //48,
                                // margin: EdgeInsets.only(
                                //     // top:_responsive.ip(9.6),

                                //     left: _responsive.wp(6),//16,
                                //     right: _responsive.wp(6)),//16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(4),
                                        topLeft: Radius.circular(4)),
                                    border: Border.all(color: Colors.white),
                                    color: _currentIndex == 0
                                        ? Colors.white
                                        : Color(0xFFE60012)),
                                child: Center(
                                  child: Text(
                                    'Noticias',
                                    style: TextStyle(
                                        fontFamily: "HelveticaNeue",
                                        fontSize: _responsive.ip(2.4), //16.0,
                                        fontWeight: FontWeight.bold,
                                        color: _currentIndex == 0
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                print(_currentIndex);
                                if (_currentIndex == 0) {
                                  setState(() {
                                    _currentIndex = 1;
                                  });
                                }
                              },
                              child: Container(
                                child: Container(
                                  // width: double.infinity,
                                  height: _responsive.ip(7.2), //48,
                                  // margin: EdgeInsets.only(
                                  //     // top:_responsive.ip(9.6),

                                  //     left: _responsive.wp(6),//16,
                                  //     right: _responsive.wp(6)),//16),
                                  // padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(4),
                                          topRight: Radius.circular(4)),
                                      // border: Border.all(width: 10, color: Colors.yellow),
                                      color: _currentIndex == 0
                                          ? Color(0xFFE60012)
                                          : Colors.white),
                                  child: Center(
                                    child: Text(
                                      'Eventos',
                                      style: TextStyle(
                                          fontFamily: "HelveticaNeue",
                                          fontSize: _responsive.ip(2.4), //16.0,
                                          fontWeight: FontWeight.bold,
                                          color: _currentIndex == 1
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: _responsive.wp(6), //16,
                        top: _responsive.wp(4), //16,
                        bottom: 8,
                      ),
                      child: Text('Más recientes',
                          // style: AppConfig.styleSubCabecerasPaginas,
                          style: TextStyle(
                              fontFamily: "HelveticaNeue",
                              fontSize: _responsive.ip(2.4), //22,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              color: Colors.white)),
                    )
                  ],
                ),
              ],
            ),
          )),

          // NestedScrollView(
          //   headerSliverBuilder: (context, value) {
          //     return [
          //       // SliverToBoxAdapter(
          //       //   child:
          //       // ),
          //     ];
          //   },
          //   body:

          _currentIndex == 0
              ? Container(
                  // padding: EdgeInsets.only(top: 15),
                  margin: EdgeInsets.only(top: _responsive.hp(27)),
                  child: _containerNoticias(),
                  // ]),
                )
              : Container(
                  // padding: EdgeInsets.only(top: 20),
                  margin: EdgeInsets.only(top: _responsive.hp(27)),
                  child: new SingleChildScrollView(
                    //  child:   Column(
                    //    children: <Widget>[
                    child: _containerEventos(),
                    //  ],
                    //  ),
                  ),
                ),
        ],
      )),
      // ),
    );
  }

  Widget _containerNoticias() {
    final _responsive = Responsive(context);
    String usuario = jsonDecode(prefs.usuarioInfo)["sCorreo"];
    noticiasBloc.cargarNoticias(usuario);
    return StreamBuilder<Object>(
        stream: noticiasBloc.noticiasStream,
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: const Duration(seconds: 2),
            child: snapshot.hasData
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        ContainerNoticias(
                          aNoticias: snapshot.data,
                        )
                      ])
                : SingleChildScrollView(child: ContainerNoticiasLoading()),
          );
        });
  }

  Widget _containerEventos() {
    String usuario = jsonDecode(prefs.usuarioInfo)["sCorreo"];
    eventosBloc.cargarEventos(usuario);
    final _responsive = Responsive(context);

    return StreamBuilder<Object>(
        stream: eventosBloc.eventosStream,
        builder: (context, snapshot) {
          return AnimatedSwitcher(
              duration: const Duration(seconds: 2),
              child: snapshot.hasData
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                          ContainerEventos(
                            aEventos: snapshot.data,
                          )
                        ])
                  : ContainerEventosLoading());
        });
  }
}
