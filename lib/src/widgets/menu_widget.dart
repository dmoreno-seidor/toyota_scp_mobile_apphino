import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:toyota_scp_mobile_apphino/src/pages/home_page.dart';
// import 'package:toyota_scp_mobile_apphino/src/pages/login_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/mi_perfil_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/mis_premios_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/mis_puntos_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/mis_servicios_page.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

import '../app_config.dart';

class MenuWidget extends StatelessWidget {


   
  @override
  Widget build(BuildContext context) {


    // final _urlImage =
    //     'https://scontent.flim18-3.fna.fbcdn.net/v/t1.0-9/86935181_10158134461222716_5327045227104436224_n.jpg?_nc_cat=108&_nc_sid=110474&_nc_eui2=AeGDFjPgZuaHa6bsq0t_OF2I-djGZLzneF352MZkvOd4XVW4QPngc1k-CY83SA6xmOk&_nc_oc=AQn320P65FVSAbIDltMGNbBhWVQUEs834P_3GUbju6Rh4uaSTKflJbPMVyBB7N9JmyY&_nc_ht=scontent.flim18-3.fna&oh=f562eb6bc1c481cc5457e7052ac0eb75&oe=5EB778D4';
    final prefs = new PreferenciasUsuario();
    //  final usuarioDataStorage = prefs.usuarioInfo;
    String usuarioInfo = prefs.usuarioInfo;
    String sNombresUsuario = prefs.sNombresUsuario;
    String sNumeroDocumento = prefs.sNumeroDocumento;
    String sImagen = prefs.sImagen;
    // Map<String,dynamic> usuarioData = jsonDecode(usuarioDataStorage);
    Responsive _responsive = new Responsive(context);



    _onExit(){
      Dialogs.confirm(context,title: "Confirmar",message: "Desea Cerrar Sesión?",onCancel: (){
        Navigator.pop(context);
        
      }, onConfirm: ()async{
        Navigator.pop(context);
        prefs.clear();
        // Session session = Session();
        //  await session.clear();
          
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'login', (_) => false);
      });
    }


    return Drawer(
        child: SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
              child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(left: 20, right: 17, top:19 ),
                              height:  _responsive.ip(1.5) ,//10.24,
                              width: _responsive.ip(2.4),///16,
                              decoration: new BoxDecoration(
                                image: DecorationImage(
                                  image: new AssetImage(
                                      'assets/home/iconDrawer.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                  // IconButton(
                  //     padding: EdgeInsets.symmetric(horizontal: 20.0),
                  //     icon: Icon(Icons.arrow_back),
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     })
                ],
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      left: 20, right: 20, bottom: 20), //EdgeInsets.all(20.0),
                  // color: Colors.black45,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              sImagen == ''

                                  ? Container(
                                      width: _responsive.ip(9.6),//64,
                                      height: _responsive.ip(9.6),//64,
                                      margin: EdgeInsets.only(bottom: 40.0 ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/home/iconProfile.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ))
                                  : Container(
                                      margin: EdgeInsets.only(bottom: 20.0),
                                      width: _responsive.ip(9.6),//64,
                                      height: _responsive.ip(9.6),//64,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: sImagen.replaceAll('/bridge/',"${AppConfig.api_host_docService}"),
                                              placeholder: (context, url) =>
                                                  Container(
                                                    decoration:
                                                        new BoxDecoration(
                                                      image: DecorationImage(
                                                        image: new AssetImage(
                                                            'assets/home/iconProfile.png'),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Container(
                                                    decoration:
                                                        new BoxDecoration(
                                                      image: DecorationImage(
                                                        image: new AssetImage(
                                                            'assets/home/iconProfile.png'),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                              fadeInCurve: Curves.easeIn,
                                              // fadeOutDuration: const Duration(seconds: 1),
                                              fadeInDuration: Duration(
                                                  milliseconds: 1000))),
                                    ),
                            ],
                          ),
                          
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                   child: Text(
                                    sNombresUsuario, //"${usuarioData['sNombres']}" "${usuarioData['sApellidoPaterno']}",//'Evert Enciso',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "HelveticaNeue",
                                      fontWeight: FontWeight.bold,
                                      fontSize: _responsive.ip(2.7),//18,
                                      color: Color(0xEFF1C1C1C)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "N° doc. ${sNumeroDocumento}", //"${usuarioData['sNumeroDocumento']}",//'43326765',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: "HelveticaNeue",
                                  fontSize: _responsive.ip(1.8),//12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF94949A)
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  color: Color(0xFF96969b),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 16,top: 18),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 18),
                        child: GestureDetector(
                          onTap: (){
                                Navigator.of(context).pop();
                          },
                                              child: Row(
                            children: <Widget>[
                              Container(
                                                          child: Image.asset(
                                  'assets/drawer/home.png',
                                  width: _responsive.ip(2.4),//16,
                                  height: _responsive.ip(2.4),//16,
                                ),
                                
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10.86 ),
                                child: Text(
                                      'Inicio',
                                      style: TextStyle(
                                        fontSize: _responsive.ip(2.4),
                                        fontFamily: 'HelveticaNeue',
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF1C1C1C),
                                        fontWeight: FontWeight.bold
                                      ),
                                      // style: AppConfig.styleMenuWidget
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 18),
                        child: GestureDetector(
                          onTap: (){
                              Navigator.popAndPushNamed(
                                  context, MiPerfilPage.routeName);
                          },
                                              child: Row(
                            children: <Widget>[
                              Container(
                                                          child: Image.asset(
                                  'assets/drawer/perfil.png',
                                  width: _responsive.ip(2.4),//16,
                                  height: _responsive.ip(2.4),//16,
                                ),
                                
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10.86 ),
                                child: Text(
                                      'Perfil',
                                      style: TextStyle(
                                        fontSize: _responsive.ip(2.4),
                                        fontFamily: 'HelveticaNeue',
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF1C1C1C),
                                        fontWeight: FontWeight.bold
                                      ),
                                      // style: AppConfig.styleMenuWidget
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 18),
                        child: GestureDetector(
                          onTap: (){
                            final parentContext = context;
                            Map usuarioEnvio = jsonDecode(usuarioInfo);

                                               if (usuarioEnvio['idEstadoActivacion'] == 2) {


                  if(usuarioEnvio['iPuntosAcumulados']>0){
                        Navigator.popAndPushNamed(
                                  context, MisPuntosPage.routeName,arguments: usuarioInfo);
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
                                
                          },
                                              child: Row(
                            children: <Widget>[
                              Container(
                                                          child: Image.asset(
                                  'assets/drawer/puntos.png',
                                  width: _responsive.ip(2.4),//16,
                                  height: _responsive.ip(2.4),//16,
                                ),
                                
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10.86 ),
                                child: Text(
                                      'Puntos',
                                      style: TextStyle(
                                        fontSize: _responsive.ip(2.4),
                                        fontFamily: 'HelveticaNeue',
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF1C1C1C),
                                        fontWeight: FontWeight.bold
                                      ),
                                      // style: AppConfig.styleMenuWidget
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 18),
                        child: GestureDetector(
                          onTap: (){
                      Map usuarioEnvio = jsonDecode(usuarioInfo);

                              final parentContext = context;
              if (usuarioEnvio['idEstadoActivacion'] == 2) {
                
                  

                  if(int.parse(usuarioEnvio['iCantidadPremios'],radix : 10)>0){
                        Navigator.popAndPushNamed(
                                  context, MisPremiosPage.routeName);
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

                              
                          },
                                              child: Row(
                            children: <Widget>[
                              Container(
                                                          child: Image.asset(
                                  'assets/drawer/premios.png',
                                  width: _responsive.ip(2.4),//16,
                                  height: _responsive.ip(2.4),//16,
                                ),
                                
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10.86 ),
                                child: Text(
                                      'Premios',
                                      style: TextStyle(
                                        fontSize: _responsive.ip(2.4),
                                        fontFamily: 'HelveticaNeue',
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF1C1C1C),
                                        fontWeight: FontWeight.bold
                                      ),
                                      // style: AppConfig.styleMenuWidget
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 18),
                        child: GestureDetector(
                          onTap: (){
                            final parentContext = context;
                          Map usuarioEnvio = jsonDecode(usuarioInfo);
                                    if(int.parse(usuarioEnvio['iCantidadServicios'],radix : 10)>0){
                              Navigator.popAndPushNamed(
                                          context, MisServiciosPage.routeName,arguments: usuarioInfo);
                          }else{
                            Dialogs.succedDialog(context,
                            title: "Aviso",
                            message:
                                "Por el momento, no tienes servicios realizados.",
                            onOk: () {
                              Navigator.pop(parentContext);
                            });
                          }

                              
                          },
                                              child: Row(
                            children: <Widget>[
                              Container(
                                                          child: Image.asset(
                                  'assets/drawer/servicios.png',
                                  width: _responsive.ip(2.4),//16,
                                  height: _responsive.ip(2.4),//16,
                                ),
                                
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10.86 ),
                                child: Text(
                                      'Servicios',
                                      style: TextStyle(
                                        fontSize: _responsive.ip(2.4),
                                        fontFamily: 'HelveticaNeue',
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF1C1C1C),
                                        fontWeight: FontWeight.bold
                                      ),
                                      // style: AppConfig.styleMenuWidget
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
           



            ],
          )),
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 16),
                  child: Divider(
                    color: Color(0xFF96969b),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(left: 16.0, bottom: 16),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          child: Image.asset(
                            'assets/drawer/exit.png',
                            width: _responsive.ip(2.4),//16,
                            height: _responsive.ip(2.4),//16,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Align(
                            child: Text(
                              'Cerrar sesión',
                              style: TextStyle(
                                  fontFamily: "HelveticaNeue",
                                  fontSize: _responsive.ip(2.1), color: Color(0xFF94949A)),
                            ),
                            alignment: Alignment(
                                -1.5, 0), // alignment: Alignment(1.25, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => _onExit(),
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, 'login', (_) => false),
                  // Navigator.popAndPushNamed(context, LoginPage.routeName),
                )
              ],
            ),
          )
        ],
      ),
    ));

    
  }

  
}
