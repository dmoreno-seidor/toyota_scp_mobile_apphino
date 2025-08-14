import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/comportamiento_usuario/comportamiento_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/manager/notification_manager.dart';
import 'package:toyota_scp_mobile_apphino/src/models/usuario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/Provider.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/catalogo_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/usuario_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/formatters.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/cajas_secundarias_home_loading_page.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/cajas_secundarias_home_page.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/menu_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/usuario_model.dart';


class HomePage extends StatefulWidget {
  static final String routeName = "home";

  // final prefs = new PreferenciasUsuario();
  HomePage({Key key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final prefs = new PreferenciasUsuario();
  // UsuarioBloc usuarioBloc = new UsuarioBloc();
  CatalogoBloc catalogoBloc = new CatalogoBloc();
  bool _isFetching=false;
File _image;
   
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Future.delayed(Duration.zero,(){
      ///init Notification Manger
      NotificationManger.init(context: context);
      
    // Map info;
    //   NotificationManger.handleNotificationMsg(info);
      
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
    //final _urlImage = 'https://scontent.flim18-3.fna.fbcdn.net/v/t1.0-9/86935181_10158134461222716_5327045227104436224_n.jpg?_nc_cat=108&_nc_sid=110474&_nc_eui2=AeGDFjPgZuaHa6bsq0t_OF2I-djGZLzneF352MZkvOd4XVW4QPngc1k-CY83SA6xmOk&_nc_oc=AQn320P65FVSAbIDltMGNbBhWVQUEs834P_3GUbju6Rh4uaSTKflJbPMVyBB7N9JmyY&_nc_ht=scontent.flim18-3.fna&oh=f562eb6bc1c481cc5457e7052ac0eb75&oe=5EB778D4';
    // final _urlImage =
    //     'https://scontent.flim18-3.fna.fbcdn.net/v/t1.0-9/86935181_10158134461222716_5327045227104436224_n.jpg?_nc_cat=108&_nc_sid=110474&_nc_eui2=AeGDFjPgZuaHa6bsq0t_OF2I-djGZLzneF352MZkvOd4XVW4QPngc1k-CY83SA6xmOk&_nc_oc=AQn320P65FVSAbIDltMGNbBhWVQUEs834P_3GUbju6Rh4uaSTKflJbPMVyBB7N9JmyY&_nc_ht=scontent.flim18-3.fna&oh=f562eb6bc1c481cc5457e7052ac0eb75&oe=5EB778D4';
    // usuarioBloc.consultarDataCliente2(prefs.iId);
    final catalogoBloc =  Provider.catalogoBloc(context);
    final usuarioBloc = Provider.usuarioBloc(context);
    usuarioBloc.consultarDataCliente2(prefs.iId);
    UsuarioModel usuarioEnvio;
    final _responsive = Responsive(context);
    final _size = MediaQuery.of(context).size;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();




    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
          width: MediaQuery.of(context).size.width * 0.60, child: MenuWidget()),
      body: StreamBuilder<Object>(
          stream: usuarioBloc.oUsuarioStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                              color: Color(0xFFE60012),
                              width: _size.width,
                              height: _responsive.hp(36.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      snapshot.hasData?

                                          usuarioBloc.oUsuario.sImagen == ''
                                              ? GestureDetector(
                                                onTap: (){
                                                  getImage(usuarioBloc);
                                                },
                                                                                              child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 22,
                                                        top: _responsive.hp(6)),
                                                    height:
                                                        _responsive.hp(15), //30,
                                                    width:
                                                        _responsive.hp(15), //30,
                                                    decoration: new BoxDecoration(
                                                      image: DecorationImage(
                                                        image: new AssetImage(
                                                            'assets/home/iconProfile.png'),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                              )
                                              : GestureDetector(
                                                onTap: (){
                                                  getImage(usuarioBloc);
                                                },
                                                                                              child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 22,
                                                        top: _responsive.hp(6)),
                                                    height:
                                                        _responsive.hp(16), //30,
                                                    width:
                                                        _responsive.hp(16), //30,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: 
                                                      _image==null?
                                                      
                                                      CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl: usuarioBloc
                                                              .oUsuario.sImagen
                                                              .replaceAll(
                                                                  '/bridge/',
                                                                  "${AppConfig.api_host_docService}"),
                                                          placeholder:
                                                              (context,
                                                                      url) =>
                                                                  Container(
                                                                    decoration:
                                                                        new BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image: new AssetImage(
                                                                            'assets/home/iconProfile.png'),
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                          errorWidget:
                                                              (context, url,
                                                                      error) =>
                                                                  Container(
                                                                    decoration:
                                                                        new BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image: new AssetImage(
                                                                            'assets/home/iconProfile.png'),
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                          fadeInCurve: Curves
                                                              .easeIn,
                                                          // fadeOutDuration: const Duration(seconds: 1),
                                                          fadeInDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      1000))
                                                                      
                                                                      : Image.file(_image ,fit: BoxFit.fill, )
                                                                      ,

                                                      // Image.network(
                                                      //   usuarioBloc.oUsuario.sImagen.replaceAll('/bridge/', "${AppConfig.api_host_docService}"),

                                                      //   fit: BoxFit.cover,
                                                      // ),
                                                    ),
                                                  ),
                                              )
                                          :
                                           GestureDetector(
                                                onTap: (){
                                                  getImage(usuarioBloc);
                                                },
                                                                                        child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 22,
                                                    top: _responsive.hp(6)),
                                                height: _responsive.hp(16), //30,
                                                width: _responsive.hp(16), //30,
                                                decoration: new BoxDecoration(
                                                  image: DecorationImage(
                                                    image: new AssetImage(
                                                        'assets/home/iconProfile.png'),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                           ) ,
                                      snapshot.hasData
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  left: _responsive.wp(19),
                                                  top: _responsive.hp(17)),
                                              height: _responsive.hp(9), //30,
                                              width: _responsive.hp(10),
                                              child: Image.network(
                                                usuarioBloc.oUsuario
                                                    .sImagenCategoriaUsuario
                                                    .replaceAll('/bridge/',
                                                        "${AppConfig.api_host_docService}"),
                                                fit: BoxFit.fill,
                                              ) //30,
                                              )
                                          : Container(
                                              margin: EdgeInsets.only(
                                                  left: _responsive.wp(22),
                                                  top: _responsive.hp(15.5)),
                                              height: _responsive.hp(9), //30,
                                              width: _responsive.hp(7), //30,
                                            )
                                    ],
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, top: 35),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          snapshot.hasData
                                              ? Text(
                                                  "Hola,",
                                                  style: TextStyle(
                                                    fontFamily: "HelveticaNeue",
                                                    color: Colors.white,
                                                    fontSize: _responsive.ip(2.4)//14,
                                                  ),
                                                )
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: 3, bottom: 3),
                                                  height: 16,
                                                  width: 145,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                            topLeft:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8)),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                          snapshot.hasData
                                              ? Text(
                                                  "${usuarioBloc.oUsuario.sNombres} ${usuarioBloc.oUsuario.sApellidoPaterno}", //"${usuarioData['sNombres']}" "${usuarioData['sApellidoPaterno']}",//"Evert Enciso",
                                                  style: TextStyle(
                                                      fontFamily: "HelveticaNeue",
                                                      color: Colors.white,
                                                      fontSize: _responsive.ip(3.3),//22.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: 3, bottom: 3),
                                                  height: 16,
                                                  width: 145,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                            topLeft:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8)),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                          snapshot.hasData
                                              ? Text(
                                                  "N° doc. ${usuarioBloc.oUsuario.sNumeroDocumento}", //"${usuarioData['sNumeroDocumento']}",//"43326765",
                                                  style: TextStyle(
                                                    fontFamily: "HelveticaNeue",
                                                    color: Colors.white,
                                                    fontSize: _responsive.ip(1.8),//12,
                                                  ),
                                                )
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: 3, bottom: 3),
                                                  height: 16,
                                                  width: 145,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                            topLeft:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8)),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                          snapshot.hasData
                                              ? Container(
                                                  margin:
                                                      EdgeInsets.only(top: 8),
                                                  height: _responsive.ip(3.6),//24,
                                                  // width: 100,//_responsive.ip(10.8),//72, 
                                                  child: Image.network(
                                                    usuarioBloc.oUsuario
                                                        .sLabelCategoriaUsuario
                                                        .replaceAll('/bridge/',
                                                            "${AppConfig.api_host_docService}"), //'https://scontent.flim18-3.fna.fbcdn.net/v/t1.0-9/86935181_10158134461222716_5327045227104436224_n.jpg?_nc_cat=108&_nc_sid=110474&_nc_eui2=AeGDFjPgZuaHa6bsq0t_OF2I-djGZLzneF352MZkvOd4XVW4QPngc1k-CY83SA6xmOk&_nc_oc=AQn320P65FVSAbIDltMGNbBhWVQUEs834P_3GUbju6Rh4uaSTKflJbPMVyBB7N9JmyY&_nc_ht=scontent.flim18-3.fna&oh=f562eb6bc1c481cc5457e7052ac0eb75&oe=5EB778D4',
                                                    fit: BoxFit.fill,
                                                  )
                                                  // decoration: new BoxDecoration(
                                                  //   image: DecorationImage(
                                                  //     image: new AssetImage(
                                                  //         'assets/home/rectanguloTipoCliente.png'),
                                                  //     fit: BoxFit.fill,
                                                  //   ),
                                                  // ),
                                                  )
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: 3, bottom: 3),
                                                  height: 16,
                                                  width: 145,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                            topLeft:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8)),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          _crearEstructuraCajas(snapshot, usuarioEnvio,usuarioBloc)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Container(
                        child: Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                        children: <Widget>[
                          _crearCajaPremiosCanjeados(snapshot,usuarioBloc),
                          _crearCajaServiciosRealizados(snapshot,usuarioEnvio,usuarioBloc),
                          _crearCajaVehiculosAsociados(snapshot,usuarioBloc),
                        ],
                      )),
                    ))
                  ],
                ),
                _isFetching
              ? Positioned.fill(
                  child: Container(
                  color: Colors.black45,
                  child: Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SpinKitThreeBounce(
                              size: _responsive.ip(5.25),//35,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color:
                                        index.isEven ? Colors.red : Colors.red,
                                  ),
                                );
                              }),
                          Text(
                            "Subiendo Imagen...",
                            // style: AppConfig.styleTextCargado
                            style: TextStyle(
                            color: Colors.white, 
                            fontFamily: "HelveticaNeue",
                            fontSize: _responsive.ip(2.4)
                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                ):Container()
                

                
              ],
            );
          }),
    );
  }

  Widget _crearEstructuraCajas(
      AsyncSnapshot snapshot, UsuarioModel usuarioEnvio, usuarioBloc) {
    final _responsive = Responsive(context);
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: _responsive.hp(33)),
      child: Column(
        children: <Widget>[
          _crearCajaPuntos(snapshot, usuarioEnvio,_responsive,usuarioBloc),
        ],
      ),
    );
  }

  Widget _crearCajaPuntos(AsyncSnapshot snapshot, UsuarioModel usuarioEnvio,Responsive _responsive,UsuarioBloc usuarioBloc) {
    return snapshot.hasData
        ? GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: 17, top: 22, bottom: 22,right: 10.17),
                    width: _responsive.ip(5.74),//38.33,
                    height: _responsive.ip(6),//40,
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: new AssetImage('assets/home/estrella.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(vertical: 17.0),
                  //     child:
                       Container(
                         height: _responsive.ip(7.2),//48,
                         child: VerticalDivider(
                          thickness: 1,
                            
                      ),
                       ),
                      // ),
                  Flexible(
                                      child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Al día de hoy tienes',
                            // textScaleFactor: 1.2,
                            style: TextStyle(
                            color: Color(0xFFE60012),
                            // fontFamily: 'HelveticaNeue',
                            fontFamily: "HelveticaNeue",
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontSize: _responsive.ip(1.8))//12)
                            // AppConfig.styleTituloCajaPrincipal,
                          ),

                          RichText(
                                                text: TextSpan(children: <
                                                    TextSpan>[
                                              TextSpan(
                                                  text:
                                                      "${formatPuntos(usuarioBloc.oUsuario.iPuntosAcumulados)} ",
                                                  style: TextStyle(
                                                      fontSize: _responsive.ip(3.6),//24.0,
                                                      fontFamily:
                                                          'HelveticaNeue',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color:
                                                          Color(0xFF1C1C1C))),
                                              TextSpan(
                                                  text: 'Puntos',
                                                  style: TextStyle(
                                                      fontSize: _responsive.ip(2.25),//15.0,
                                                      fontFamily:
                                                          'HelveticaNeue',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color:
                                                          Color(0xFF1C1C1C))),
                                            ]))
                          // Row(
                          //   children: <Widget>[
                          //     Flexible(
                          //                                     child: Row(
                          //                                       children: <Widget>[
                          //                                         Text(
                          //         "${formatPuntos(usuarioBloc.oUsuario.iPuntosAcumulados)} ", //usuarioData['iPuntosAcumulados'])} Pts",//'3,500 Pts',
                          //         // textScaleFactor: 2,
                          //         style: TextStyle(
                          //             color: Color(0xFF1C1C1C),
                          //             fontFamily: 'HelveticaNeue',
                          //             fontWeight: FontWeight.bold,
                          //             fontStyle: FontStyle.normal,
                          //             fontSize: 24),
                          //       ), Text(
                          //         "Puntos", //usuarioData['iPuntosAcumulados'])} Pts",//'3,500 Pts',
                          //         // textScaleFactor: 1.5,
                          //         style: TextStyle(
                          //             color: Color(0xFF1C1C1C),
                          //             fontFamily: 'HelveticaNeue',
                          //             fontWeight: FontWeight.bold,
                          //             fontStyle: FontStyle.normal,
                          //             fontSize: 12),
                          //       ),
                          //                                       ],
                          //                                     ),
                          //     ),
                          //   ],
                          // ),
                          ,
                          // usuarioBloc.oUsuario.dPuntosFechaVencimiento==""?Text("No Existe Vigencia"):
                          usuarioBloc.oUsuario.iPuntosAcumulados==0?Text("No Existe Vigencia",
                          style: TextStyle(
                              color: Color(0xFF94949A),
                              // fontFamily: 'HelveticaNeue',
                              fontFamily: "HelveticaNeue",
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: _responsive.ip(1.8))):
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                  Text(
                              'Algunos puntos vencen en',
                              // textScaleFactor: 2,
                              // style: AppConfig.styleSubTituloCajaPrincipal,
                              style: TextStyle(
                              color: Color(0xFF94949A),
                              // fontFamily: 'HelveticaNeue',
                              fontFamily: "HelveticaNeue",
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: _responsive.ip(1.8)),
                            ),
                            Text(
                              '${formatObtenerNombreMesAnioV2(usuarioBloc.oUsuario.dPuntosFechaVencimiento)}',
                              // textScaleFactor: 2,
                              style: TextStyle(
                              color: Color(0xFF94949A),
                              fontFamily: "HelveticaNeue",
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              fontSize: _responsive.ip(1.8))//12)
                            ),
                              ],
                            )
                           
                          
                        ],
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [AppConfig.boxShadow],
              ),
              height: _responsive.ip(15),//100,
            ),
            onTap: () {
              usuarioEnvio = usuarioBloc.oUsuario;
              final parentContext = context;
              if (usuarioEnvio.idEstadoActivacion == 2) {


                  if(usuarioEnvio.iPuntosAcumulados>0){
                        Navigator.pushNamed(context, 'misPuntos',
                    arguments: jsonEncode(usuarioEnvio));
                  }else{
                    Dialogs.succedDialog(context,
                    title: "Aviso",
                    message:
                        "Por el momento, no tienes puntos registrados.",
                    onOk: () {
                      Navigator.pop(parentContext);
                    });
                  }

                
              } else {
                Dialogs.succedDialog(context,
                    title: "Aviso",
                    message:
                        "Para revisar sus puntos acercarse a un concesionario para activar su cuenta",
                    onOk: () {
                        Navigator.pop(parentContext);
                    });
              }
            })
        : Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(
                        left: 16, top: 22, bottom: 22, right: 5),
                    width: _responsive.ip(10.8),//72.0,
                    height: _responsive.ip(10.57),//70.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffE5E5E5),
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: _responsive.ip(2.55)),//17.0),
                    child: VerticalDivider()),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: _responsive.ip(3),//20,
                        width: _responsive.wp(40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          color: Color(0xffE5E5E5),
                        ),
                      ),
                      Container(
                        height: _responsive.ip(3),//20,
                        width: _responsive.wp(40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          color: Color(0xffE5E5E5),
                        ),
                      ),
                      Container(
                        height: _responsive.ip(3),//20,
                        width: _responsive.wp(40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          color: Color(0xffE5E5E5),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [AppConfig.boxShadow],
            ),
            height: _responsive.ip(15),//100,
          );
  }


  Future getImage(usuarioBloc) async {
    final File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null){
       print(image);

        setState(() {
           
            _isFetching= true;
              });
				
			  String fileName = image.path.split("/").last.split(".")[0];
				String fileType = image.path.split("/").last.split(".")[1];

          List<int> imageBytes = image.readAsBytesSync();
          String base64String = base64Encode(imageBytes);

          String idImagen = await usuarioBloc.obtenerIdImagen(context , fileType, fileName, base64String, image);
          
          if(idImagen!=''){
            String urlImagen  = await usuarioBloc.obtenerUrlImagen(context, idImagen,prefs.iId);
            print(urlImagen);
            prefs.sImagen = "/bridge" + urlImagen;
             _image = image; 
             _isFetching= false;
              setState(() {
            
              });

          }else{
            setState(() {
            //_image = image; 
            _isFetching= true;
              });
          }
    }
  }


  Widget _crearCajaPremiosCanjeados(AsyncSnapshot snapshot,usuarioBloc) {
    Responsive _responsive = new Responsive(context);
    return snapshot.hasData
        ? GestureDetector(
            child: CajaSecundariaHomePage(
              alto: _responsive.ip(3.6),
              ancho: _responsive.ip(4),
              image: 
              // Icon(
              //   FontAwesomeIcons.gift,
              //   color: Color(0xFF71C341),
              //   size: 23.82,
              // ),
              Image.asset(
              'assets/home/gift.png',
              fit: BoxFit.fill,
              // width: _responsive.ip(3.57),
              // height: _responsive.ip(3.6),
            ),
              valorSubtitulo:
                  "${usuarioBloc.oUsuario.iCantidadPremios}", //"${usuarioData['iCantidadPremios'].toString()}",//"03",
              subtitulo: 'Premios Canjeados',
            ),
            onTap: () {
              final parentContext = context;
              if (usuarioBloc.oUsuario.idEstadoActivacion == 2) {
                
                  

                  if(int.parse(usuarioBloc.oUsuario.iCantidadPremios,radix : 10)>0){
                        Navigator.pushNamed(context, 'misPremios');
                  }else{
                    Dialogs.succedDialog(context,
                    title: "Aviso",
                    message:
                        "Por el momento, no tienes premios canjeados.",
                    onOk: () {
                      Navigator.pop(parentContext);
                    });
                  }



              } else {
                Dialogs.succedDialog(context,
                    title: "Aviso",
                    message:
                        "Para revisar sus premios acercarse a un concesionario para activar su cuenta",
                    onOk: () {
                       Navigator.pop(parentContext);
                    });
              }
            })
        : CajaSecundariaLoadingHomePage(
            icon: Icon(
              FontAwesomeIcons.gift,
              color: Color(0xFF71C341),
              size: _responsive.ip(3.75),//25.0,
            ),
          );
  }

  Widget _crearCajaServiciosRealizados(AsyncSnapshot snapshot , UsuarioModel usuarioEnvio,usuarioBloc) {
    Responsive _responsive = new Responsive(context);
    return snapshot.hasData
        ? GestureDetector(
            child: CajaSecundariaHomePage(
              // icon: Icon(
              //   FontAwesomeIcons.wrench,
              //   color: Color(0xFF00BDE6),
              //   size: 25.0,
              // ),
              alto: _responsive.ip(3.6),//40,
              ancho: _responsive.ip(4.5),//30,
              image: Image.asset(
              'assets/home/iconServicios.png',
               fit: BoxFit.fitHeight,
              width: _responsive.ip(3.6),//18.25,
              height: _responsive.ip(3.6)
            ),
              valorSubtitulo: "${usuarioBloc.oUsuario.iCantidadServicios}",
              subtitulo: 'Servicio Realizados',
            ),
             onTap: (){
               final parentContext = context;
               usuarioEnvio = usuarioBloc.oUsuario;
                if(int.parse(usuarioBloc.oUsuario.iCantidadServicios,radix : 10)>0){
                        Navigator.pushNamed(context, 'misServicios' , arguments: jsonEncode(usuarioEnvio));
                  }else{
                    Dialogs.succedDialog(context,
                    title: "Aviso",
                    message:
                        "Por el momento, no tienes servicios realizados.",
                    onOk: () {
                      Navigator.pop(parentContext);
                    });
                  }
               
             } 
            )
            
        : CajaSecundariaLoadingHomePage(
            icon: Icon(
              FontAwesomeIcons.gift,
              color: Color(0xFF00BDE6),
              size: _responsive.ip(3.75)//25.0,
            ),
            // valorSubtitulo: "${ usuarioBloc.oUsuario.iCantidadPremios}", //"${usuarioData['iCantidadPremios'].toString()}",//"03",
            // subtitulo: 'Premios Canjeados',
          );
  }

  Widget _crearCajaVehiculosAsociados(AsyncSnapshot snapshot,usuarioBloc) {
     Responsive _responsive = new Responsive(context);
    return snapshot.hasData
        ? GestureDetector(
            child: CajaSecundariaHomePage(
              // icon: Icon(
              //   FontAwesomeIcons.truck,
              //   color: Color(0xFF6F92DD),
              //   size: 25.0,
              // ),
              alto: _responsive.ip(3.6),//40,
              ancho: _responsive.ip(4.5),//30,
              
             image :  Image.asset(
              'assets/home/iconVehiculos.png',
              fit: BoxFit.fitHeight,
              height: _responsive.ip(3.6),
              width: _responsive.ip(2.22),
            ),
              valorSubtitulo: "${usuarioBloc.oUsuario.iCantidadVehiculos}",
              subtitulo: 'Vehículos Asociados',
            ),
            onTap: () => Navigator.pushNamed(context, 'misVehiculos'),
          )
        : CajaSecundariaLoadingHomePage(
            icon: Icon(
              FontAwesomeIcons.gift,
              color: Color(0xFF71C341),
              size: _responsive.ip(3.75)//25.0,
            ),
            // valorSubtitulo: "${ usuarioBloc.oUsuario.iCantidadPremios}", //"${usuarioData['iCantidadPremios'].toString()}",//"03",
            // subtitulo: 'Premios Canjeados',
          );
  }
}
