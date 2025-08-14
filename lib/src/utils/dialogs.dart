// import 'dart:convert';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/constantes.dart';
// import 'package:toyota_scp_mobile_apphino/src/estilos.dart';
import 'package:toyota_scp_mobile_apphino/src/models/campania_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/concesionario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/mis_premios_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/mis_servicios_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/maps_permission.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_anios_page.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/container_anios_page_servicios.dart';
import 'package:url_launcher/url_launcher.dart';

import '../preferencias_usuario/preferencias_usuario.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';

class Dialogs {
  static void alert(BuildContext context,
      {String title = '', String message = '', VoidCallback onOk}) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: Text(
              message,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  static void confirm(BuildContext context,
      {String title = '',
      String message = '',
      VoidCallback onCancel,
      VoidCallback onConfirm}) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: TextStyle(fontFamily: "HelveticaNeue",fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: Text(
              message,
              style: TextStyle(fontFamily: "HelveticaNeue",fontWeight: FontWeight.w300, fontSize: 15),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: onCancel,
                child: Text(
                  "Cancel",
                  style: TextStyle(fontFamily: "HelveticaNeue",color: Color(0xFFE60012)),
                ),
              ),
              CupertinoDialogAction(
                child: Text("Ok", style: TextStyle(fontFamily: "HelveticaNeue",)),
                onPressed: onConfirm,
              )
            ],
          );
        });
  }

  static void succedDialog(BuildContext context,
      {String title = '', String message = '', Function onOk}) {
    // final responsive = Responsive(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(children: <Widget>[
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: Container(
                width: 226,
                height: 250,
                padding: EdgeInsets.only(top: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        // height: 300,
                        // width: 192,
                        padding: EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              title,
                              style: TextStyle(
                                  fontFamily: "HelveticaNeue",
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0xFF1C1C1C)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Flexible(
                                child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "HelveticaNeue",
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xFF1C1C1C)),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              width: 152,
                              height: 40,
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(18.0),
                                    side: BorderSide(color: Color(0xFF71C341))),
                                color: Color(0xFF71C341),
                                textColor: Colors.white,
                                padding: EdgeInsets.all(8.0),
                                onPressed: onOk,
                                // onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  "Ok, Entendido",
                                  style: TextStyle(
                                    fontFamily: "HelveticaNeue",
                                      fontSize: 18.0, color: Colors.white),
                                ),
                              ))
                        ]),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 220),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 70,
                      height: 69.95,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: new AssetImage(
                              'assets/recuperarContrasena/circuloVerde.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 37.93,
                      height: 35.22,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: new AssetImage(
                              'assets/recuperarContrasena/checkBlanco.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]);
        });
  }

  static void alertDialog(BuildContext context,
      {String title = '', String message = '', VoidCallback onOk}) {
    // final responsive = Responsive(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(children: <Widget>[
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 140,
                    width: 240,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 5.0),
                        Text(
                          title,
                          style: TextStyle(
                              fontFamily: "HelveticaNeue",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Flexible(
                            child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: "HelveticaNeue",),
                        )),
                      ],
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: 
                              Color(0xffE60012)
                              
                              )),
                          color: 
                          Color(0xffE60012),
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "Ok, Entendido",
                            style:
                                TextStyle(fontFamily: "HelveticaNeue",fontSize: 18.0, color: Colors.white),
                          ),
                        )
                      ]),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 220),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffE60012)
                        // image: DecorationImage(
                        //   image: new AssetImage(
                        //       'assets/recuperarContrasena/circuloNaranja.png'),
                        //   fit: BoxFit.fill,
                        // ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: new AssetImage(
                              'assets/recuperarContrasena/aletaBlanco.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]);
        });
  }

  static void informationDialog(BuildContext context, 
      {String title = '', String message = '', VoidCallback onOk}) {
    final responsive = Responsive(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(children: <Widget>[
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                            child: Container(
                      margin:
                          EdgeInsets.only(top:15, left:8, right: 8),
                      child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "HelveticaNeue",
                                  fontSize: responsive.ip(2.4)),
                            ),
                    ),
                  ),
                  Container(
                    height: responsive.ip(51),
                    width: responsive.ip(57),
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0),
                    child:
                    SingleChildScrollView(
               
                   child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        
                        SizedBox(height: 10),
                         Html(
                          data: message,
                           style: {
                              "div": Style(
                              textAlign: TextAlign.justify,
                              fontFamily: "HelveticaNeue",
                              fontSize: FontSize.percent(85)
                              //
                              ),
                              "b": Style(
                              textAlign: TextAlign.justify,
                              fontFamily: "HelveticaNeue",
                              fontSize: FontSize.percent(85)
                              //
                              ),
                             
                              

                              }),
                        
                      ],
                    )),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(100.0),
                                side: BorderSide(color: Color(0xFF71C341))),
                            color: Color(0xFF71C341),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              "Ok, Entendido",
                              style: TextStyle(
                                  fontSize: responsive.ip(2.7), color: Colors.white,  fontFamily: "HelveticaNeue",),
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ]);
        });
  }

  static void campaniaDialog(BuildContext context, 
      {CampaniaModel campaniaModel , ConcesionarioModel concesionario, VoidCallback onOk}) {
    final responsive = Responsive(context);
    final prefs = new PreferenciasUsuario();
    
    // dynamic concesionario = jsonDecode(concesionarioModel);
    // List<dynamic> listaConcesionario = jsonDecode(concesionario); 

    _launchLlamarURL(String telefono) async {
        final parentContext = context;
    if(telefono == null || telefono==""){
      // Dialogs.alertDialog(context,
      //     title: "¡Ups...!",
      //     message:
      //         "El consesionario no cuenta con un número de celular",
      //     onOk: () {});
      Dialogs.succedDialog(context,
          title: "Aviso",
          message:
              "El consesionario no cuenta con un número de celular",
          onOk: () {
            Navigator.pop(parentContext);
          });
    }else{
String url = 'tel:$telefono';//'tel:+51965951251';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  _launchWhatsApp(String telefonoWhatsapp) async {  
    //String phoneNumber = '+51965951251'; 
    final parentContext =context;
    if(telefonoWhatsapp == null || telefonoWhatsapp==""){
      // Dialogs.alertDialog(context,
      //     title: "¡Ups...!",
      //     message:
      //         "El consesionario no cuenta con WhatsApp",
      //     onOk: () {});
      Dialogs.succedDialog(context,
          title: "Aviso",
          message:
              "El consesionario no cuenta con WhatsApp",
          onOk: () {
            Navigator.pop(parentContext);
          });
    }else{
    String phoneNumber = telefonoWhatsapp;
    String message = Constantes.textCampaniaWhatsapp
        .replaceAll('{{N_NOMBRE}}',prefs.sNombresUsuario )
        .replaceAll('{{N_CAMPANIA}}', '${campaniaModel.nombre}');
        
    if (Platform.isIOS) {
      final Uri params = Uri(
            query: "text=${message}", //add subject and body here
          );
      phoneNumber = phoneNumber.replaceAll("+", "");
          var url =   "https://wa.me/$phoneNumber"+ params.toString();
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            // Dialogs.alertDialog(context,
            //     title: "¡Ups...!",
            //     message:
            //         "No se encuentra instalado Whatsapp en tu móvil. Necesitas instalar el app en tu móvil",
            //     onOk: () {});
                Dialogs.alertDialog(context,
                title: "Aviso",
                message:
                    "No se encuentra instalado Whatsapp en tu móvil. Necesitas instalar el app en tu móvil",
                onOk: () {});
          }

    }else{
         var whatsappUrl = "whatsapp://send?phone=$phoneNumber&text=$message";
    
          if (await canLaunch(whatsappUrl)) {
            await launch(whatsappUrl);
          } else {
            // throw 'Could not launch $whatsappUrl';
            // Dialogs.alertDialog(context,
            //     title: "¡Ups...!",
            //     message:
            //         "No se encuentra instalado Whatsapp en tu móvil. Necesitas instalar el app en tu móvil",
            //     onOk: () {});
            Dialogs.alertDialog(context,
                title: "Aviso",
                message:
                    "No se encuentra instalado Whatsapp en tu móvil. Necesitas instalar el app en tu móvil",
                onOk: () {});
          }
    }



    }
    // DJCC: Registrar el Comportamiento Usuario
    ComportamientoUsuario.registrarEvento(prefs, ingresoWhatsapp: true);
  }

  _launchEmailURL( toMailId, String subject, String body) async {
    final parentContext=context;
    if(toMailId == null || toMailId == ""){
      // Dialogs.alertDialog(context,
      //     title: "¡Ups...!",
      //     message:
      //         "El concesionario no cuenta con correo",
      //     onOk: () {});
      Dialogs.succedDialog(context,
          title: "Aviso",
          message:
              "El concesionario no cuenta con correo",
          onOk: () {
            Navigator.pop(parentContext);
          });
      
    }else{ 
    if(Platform.isIOS){
           final Uri params = Uri(
            scheme: 'mailto',
            path: toMailId,
            query: 'subject=$subject&body=$body', //add subject and body here
          );

          var url = params.toString();
          if (await canLaunch(url)) {
            await launch(url);
          } else {
          //    Dialogs.alertDialog(context,
          // title: "¡Ups...!",
          // message:
          //     "No se puede enviar el correo",
          // onOk: () {});
          Dialogs.succedDialog(context,
          title: "Aviso",
          message:
              "No se puede enviar el correo",
          onOk: () {
            Navigator.pop(parentContext);
          });
          }
      }else{
          var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // throw 'No se puede enviar el correo $url';
      // Dialogs.alertDialog(context,
      //     title: "¡Ups...!",
      //     message:
      //         "No se puede enviar el correo",
      //     onOk: () {});
        Dialogs.succedDialog(context,
          title: "Aviso",
          message:
              "No se puede enviar el correo",
          onOk: () {
            Navigator.pop(parentContext);
          });
    }
      }
    }
  }

    showDialog(
        context: context,
        builder: (BuildContext context,) {
         final _responsive  = new Responsive(context);






         
          return 

            Dialog(
              
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            
              child: 
              SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
                  children: <Widget>[

                   Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        // margin: EdgeInsets.only(bottom: 20.0),
                        // padding: EdgeInsets.all(15),
                        // padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [AppConfig.boxShadow],
                          ),
                        // child: Card(
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(15.0))
                        //           ),
                          child:
                           Column(
                             
                            children: <Widget>[
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //imagen
                                  
                                    ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5.0),
                                            topRight: Radius.circular(5.0)),
                                        child: FadeInImage.assetNetwork(
                                            image: concesionario.imagen.replaceAll('/bridge/',
                                                    "${AppConfig.api_host_docService}"),
                                            placeholder: 'assets/campania/iconoCarga.gif',
                                            fadeInDuration: Duration(milliseconds: 200),
                                            fit: BoxFit.cover,
                                            // height: 100,
                                                                    
                                          )),
                                  
                                ]
                              ),
                                  // cuerpoCard
                                 Container(

                                  
                                   decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
            color: Colors.white,
            // boxShadow: [AppConfig.boxShadow],
          ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[


                                        Container(
                                          margin: EdgeInsets.only(left: 16,top: 16.0,),
                                          child: Column(
                                            crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                            children: <Widget>[
                                                 Text(concesionario.distrito,
                                              style: TextStyle(
                                      // fontFamily: 'HelveticaNeue',
                                      fontFamily: "HelveticaNeue",
                                      fontSize: _responsive.ip(2.1),
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xffE60012))),
                                           SizedBox(
                                  height: _responsive.ip(0.75),//5,
                                ),
                                          Text(concesionario.nombre,
                                              style: TextStyle(
                                      // fontFamily: 'HelveticaNeue',
                                      fontFamily: "HelveticaNeue",
                                      fontSize: _responsive.ip(2.1),
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black)
                                                  ),
                                       SizedBox(
                                  height: _responsive.ip(0.75),//5,
                                ),
                                          Text(
                                              concesionario.direccion,
                                              // overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                // fontFamily: 'HelveticaNeue',
                                fontFamily: "HelveticaNeue",
                                fontSize: _responsive.ip(1.65),
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff94949A))),
                                            ],
                                          ),
                                        ),
                                       
                                  
                                           
                                        Container(
                                          margin: EdgeInsets.only(top:16,
                              left: 15, right: 15, bottom: 18),
                                          child: Column(
                                            children: <Widget>[
                                              Divider(height: 5.0, thickness: 1),
                                                SizedBox(height: 5,),
                                                Container(
                                                  margin: EdgeInsets.only(top: _responsive.ip(1.8)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap: (){
                                                        _launchLlamarURL(concesionario.telefono);
                                                      },
                                                        child: Column(
                                                children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.phoneAlt,
                                                    color: Color(0xFF00BDE6),
                                                    size: _responsive.ip(3.6),
                                                  ),
                                                  SizedBox(
                                                    height: _responsive.ip(1.5)//10,
                                                  ),
                                                  Text(
                                                    "Llamar",
                                                    style: TextStyle(
                                                    // fontFamily: 'HelveticaNeue',
                                                    fontFamily: "HelveticaNeue",
                                                    fontSize: _responsive.ip(1.8), 
                                                    fontWeight: FontWeight.normal,
                                                    fontStyle: FontStyle.normal,
                                                    color: Color(0xff94949A)),
                                                  )
                                                ],
                                              ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: (){
                                                        _launchWhatsApp(concesionario.whatsapp);
                                                      },
                                                        child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  FontAwesomeIcons.whatsapp,
                                                  color: Color(0xFF4CAF50),
                                                  size: _responsive.ip(3.6)
                                                ),
                                                SizedBox(
                                                height: _responsive.ip(1.5)//10
                                                ),
                                                Text(
                                                  "Chatear",
                                                  style: TextStyle(
                                  // fontFamily: 'HelveticaNeue',
                                  fontFamily: "HelveticaNeue",
                                  fontSize: _responsive.ip(1.8), 
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xff94949A))
                                                )
                                              ],
                                      ),
                                                    ),
                                                    GestureDetector(
                                                        onTap: (){
                                                          _launchEmailURL( 
                                    concesionario.correo,//'nathalymilk@gmail.com',
                                    'CONCESIONARIO ${concesionario.nombre}', //'Concesionario Mitsui Automotriz',
                                    Constantes.textCampaniaCorreo
                                    .replaceAll('{{N_NOMBRE}}', prefs.sNombresUsuario)//nombre
                                    .replaceAll('{{N_CAMPANIA}}',campaniaModel.nombre)//nombreCampaña
                                    .replaceAll('{{N_CORREO}}', jsonDecode(prefs.usuarioInfo)["sCorreo"])//correo
                                    .replaceAll('{{N_TELEFONO}}', prefs.sCelular + ".")//telefeno
                                    );
                                                        },
                                                        child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  FontAwesomeIcons.envelope,
                                                  color: Color(0xFFFFAF00),
                                                  size: _responsive.ip(3.6)
                                                ),
                                                SizedBox(
                                                  height: _responsive.ip(1.5),
                                                ),
                                                Text(
                                                  "Escribir",
                                                  style:TextStyle(
                                                    // fontFamily: 'HelveticaNeue',
                                                    fontFamily: "HelveticaNeue",
                                                    fontSize: _responsive.ip(1.8), 
                                                    fontWeight: FontWeight.normal,
                                                    fontStyle: FontStyle.normal,
                                                    color: Color(0xff94949A))
                                                )
                                              ],
                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: (){
                                                        print(concesionario);
                                                        // double latitude = double.parse(concesionario.latitud);
                                                        // double longitude = double.parse(concesionario.longitud);
                                                        // LatLng posiConcesionario = new LatLng(latitude, longitude);
                                                        showDialog(context: context, 
                                                          builder: (BuildContext context){
                                                            return MapsPermission(
                                                              concesionario : concesionario
                                                              // posiConcesionario : posiConcesionario
                                                              );
                                                          }
                                                        );
                                                        //  Navigator.pushNamed(context, 'mapsPermission');
                                                      },
                                                      child: Column(
                                              children: <Widget>[
                                                Icon(FontAwesomeIcons.mapMarkedAlt,
                                                    color: Color(0xFF71C341),
                                                    size: _responsive.ip(3.6)
                                                    ),
                                                    
                                                SizedBox(
                                                  height: _responsive.ip(1.5),
                                                ),
                                                Text(
                                                  "Ubicar",
                                                  style:TextStyle(
                                                    // fontFamily: 'HelveticaNeue',
                                                    fontFamily: "HelveticaNeue",
                                                    fontSize: _responsive.ip(1.8), 
                                                    fontWeight: FontWeight.normal,
                                                    fontStyle: FontStyle.normal,
                                                    color: Color(0xff94949A))
                                                )
                                              ],
                                             ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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




                      ),

                      Positioned(
                                  top: 10.0,
                                  right: 0.0,
                                  child: Container(
                                    height: 28,
                                    // width: 64,
                                    padding: EdgeInsets.only(left: 12.5,right: 12.5),
                                    child: Center(
                                        child: Text('${concesionario.distancia} KM',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: 'HelveticaNeue',
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: _responsive.ip(1.8)))),
                                    decoration: BoxDecoration(
                color: Color(0xff71C341),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              ),

                                  )
                                  
                                  
                                  
                                  
                                  
                                  ),
                
                  ]
                )
                    
                  
                
              )
            
            
            );
    
          
        });






        
  }


  static void dialogSortDate(BuildContext context, 
      {String title = '', String message = '', List aAnio, MisPremiosBloc misPremioBloc,VoidCallback onOk}) {
    final responsive = Responsive(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(children: <Widget>[
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                margin: EdgeInsets.all(15),
                              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: responsive.hp(50),//340,
                      width: 380,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Column(
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "HelveticaNeue",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                            message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "HelveticaNeue",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFFE60012)),
                          )
                             ,

                             
                             
                            ],
                          ),
                          Expanded(
                              child:
                               SingleChildScrollView(
                                child: ContainerAnios(
                                  aAnios : aAnio,
                                  misPremiosBloc: misPremioBloc
                                )
                             ))
                             
                        ],
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Color(0xffE60012))),
                              color: Color(0xffE60012),
                              textColor: Colors.white,
                              padding: EdgeInsets.all(8.0),
                              onPressed: () {
                                misPremioBloc.changeAnio(misPremioBloc.sFilterRespuestaAnioLastValue);
                                Navigator.of(context).pop();
                                // misPremioBloc.changeAnio(misPremioBloc.sFilterRespuestaAnioLastValue);
                              },
                              // Navigator.of(context).pop(),
                              child: Text(
                                "Buscar",
                                style: TextStyle(
                                    fontFamily: "HelveticaNeue",fontSize: 16.0, color: Colors.white),
                              ),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ]);
        });
  }

  static void dialogSortDateMisServicios(BuildContext context, 
      {String title = '', String message = '', List aAnio, MisServiciosBloc misServiciosBloc,VoidCallback onOk}) {
    final responsive = Responsive(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(children: <Widget>[
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                margin: EdgeInsets.all(15),
                              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: responsive.hp(50),//340,
                      width: 380,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Column(
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "HelveticaNeue",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                            message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "HelveticaNeue",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFFE60012)),
                          )
                            ],
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                                child: ContainerAniosServicios(
                                  aAnios : aAnio,
                                  misServiciosBloc: misServiciosBloc
                                )
                             ))
                        ],
                      ),
                    ),
                    Container(
                      height: 32,
                      width: 125,
                      margin: EdgeInsets.symmetric(vertical: 6.5, horizontal: 31.45),
                      child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(100.0),
                                  side: BorderSide(color: Color(0xffE60012))),
                              color: Color(0xffE60012),
                              textColor: Colors.white,
                              // padding: EdgeInsets.all(8.0),
                              onPressed: () {
                                misServiciosBloc.changeAnio(misServiciosBloc.sFilterRespuestaAnioLastValue);
                                Navigator.of(context).pop();
                                // misPremioBloc.changeAnio(misPremioBloc.sFilterRespuestaAnioLastValue);
                              },
                              // Navigator.of(context).pop(),
                              child: Text(
                                "Buscar",
                                style: TextStyle(
                                  fontFamily: "HelveticaNeue",
                                    fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                    ),
                  ],
                ),
              ),
            ),
          ]);
        });
  }

    static void dialogforFirebase(BuildContext context, 
      {Map data,  VoidCallback onOk}) {
        AlertDialog alertDialog = new AlertDialog(
            content: new Container(
            height: 400.0,
            child: new Column(
            children: <Widget>[
            new Text(
            "MyCompany:",
            ),
            new Text(
            "hola",
            ),
            new Padding(padding: EdgeInsets.all(20.0)),
            new RaisedButton(
            child: new Text("OK"),
            onPressed: () => Navigator.pop(context),
            )
            ],
            ),
            ),
            );
            showDialog(context: context, child: alertDialog);
    
    }


    static void terminosCondicionesDialog(BuildContext context,
      {String title = '', Function onOk}) {
    // final responsive = Responsive(context);
    TextStyle defaultStyle =
        TextStyle(color: Color(0xff1C1C1C), fontSize: 12.0);
    TextStyle linkStyle =
        TextStyle(color: Color(0xFFE60012), fontWeight: FontWeight.normal);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Stack(children: <Widget>[
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: Container(
                width: 226,
                height: 240,
                padding: EdgeInsets.only(top: 15.0),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        // height: 300,
                        // width: 192,
                        padding: EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 35,
                            ),
                            Text(
                              title,
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0xFF1C1C1C)),
                            ),
                            
                            Flexible(
                               
                                                                  child: Container(
                                                                     alignment: Alignment.center,
                              // padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: RichText(
                          text: TextSpan(
                        style: defaultStyle,
                        children: <TextSpan>[
                          
                          TextSpan(text: 'Tu cuenta ha sido creado exitosamente. Usted ha aceptado el uso de datos personales, '
                          
                          ,style: TextStyle(fontFamily: 'HelveticaNeue',)),
                          TextSpan(
                            
                              text: 'políticas y privacidad ',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Dialogs.informationDialog(context,
                                        title: "POLÍTICAS Y PRIVACIDAD",
                                        message:Constantes.politicasYprivacidad,
                                        onOk: () {});
                                  }),
                                   TextSpan(text: 'y'
                          
                          ,style: TextStyle(fontFamily: 'HelveticaNeue',)),
                          TextSpan(
                            
                              text: ' términos y condiciones',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Dialogs.informationDialog(context,
                                        title: "TÉRMINOS Y CONDICIONES – HINO APP",
                                        message:
                                            Constantes.terminosYcondiciones,
                                        onOk: () {});
                                  }),
                          TextSpan(text: ' del aviso legal ',style: TextStyle(fontFamily: 'HelveticaNeue',)),
                        ],
                      )),
                            ),
                                )
                          ],
                        ),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              width: 152,
                              height: 40,
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(18.0),
                                    side: BorderSide(color: Color(0xFF71C341))),
                                color: Color(0xFF71C341),
                                textColor: Colors.white,
                                padding: EdgeInsets.all(8.0),
                                onPressed: onOk,
                                // onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  "Ok, Entendido",
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                      fontSize: 18.0, color: Colors.white),
                                ),
                              ))
                        ]),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 220),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 70,
                      height: 69.95,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: new AssetImage(
                              'assets/recuperarContrasena/circuloVerde.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 37.93,
                      height: 35.22,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: new AssetImage(
                              'assets/recuperarContrasena/checkBlanco.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]);
        });
  }
}
