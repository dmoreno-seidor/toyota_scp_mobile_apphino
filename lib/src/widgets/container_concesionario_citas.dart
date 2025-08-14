import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../estilos.dart';
import '../models/concesionario_model.dart';
import '../pages/bloc/citas_bloc.dart';
import '../utils/dialogs.dart';
import '../utils/responsive.dart';
import '../app_config.dart';
import '../constantes.dart';
import '../pages/maps_permission.dart';
import '../preferencias_usuario/preferencias_usuario.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';

/// @author Daniel Carpio
class ContainerConcesionarioCitas extends StatefulWidget {
  final List aConcesionarioList;
  final CitasBloc citasBloc;
  final PreferenciasUsuario prefs;

  const ContainerConcesionarioCitas(
      {Key key,
      this.aConcesionarioList,
      this.citasBloc,
      this.prefs})
      : super(key: key);

  @override
  _ContainerConcesionarioCitas createState() => _ContainerConcesionarioCitas();
}

class _ContainerConcesionarioCitas extends State<ContainerConcesionarioCitas> {
  List<Map> listOfMa;
  bool isExpanded = false;
  int selected = 0;

  @override
  Widget build(BuildContext context) {
     return  widget.aConcesionarioList.length==0?
    _noBuildConcesionarioCitasList()
    :
    
     ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: _buildConcesionarioList,
      itemCount: widget.aConcesionarioList.length,
      shrinkWrap: true,
    );
  }

  Widget _noBuildConcesionarioCitasList(){
    Responsive _responsive = new Responsive(context);
    return Container(
      margin:EdgeInsets.only( bottom: 16.0),
      child: Text(
                    // 'No hay campañas vigentes',
                    'No se encontraron concesionarios con este servicio.',
                    // style: AppConfig.styleSubCabecerasPaginas,
                    style: TextStyle(
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontSize: _responsive.ip(2.4),//16,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Colors.black),

                  ),
    );
  }

  Widget _buildConcesionarioList(
    BuildContext context,
    int index) {
    final _responsive = Responsive(context);

    return Stack(
      children: <Widget>[
        Container(
          
          margin: EdgeInsets.only(bottom: 20.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                   ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0)),
                      child: FadeInImage.assetNetwork(
                          image: widget.aConcesionarioList[index].imagen.replaceAll('/bridge/', "${AppConfig.api_host_docService}"),
                          placeholder: 'assets/campania/iconoCarga.gif',
                          fadeInDuration: Duration(milliseconds: 200),
                          fit: BoxFit.cover,      
                        )
                        ),
                  
                ],
              ),
              Container(
                
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ExpansionTile(
                      title: Container(
                          padding: EdgeInsets.only(
                              left: _responsive.wp(1),
                              // right: _responsive.wp(1),
                              top: 12.0,
                              bottom: 12.0),
                          child: Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.aConcesionarioList[index].distrito,
                                  style: TextStyle(
                                      // fontFamily: 'HelveticaNeue',
                                      fontFamily: "HelveticaNeue",
                                      fontSize: _responsive.ip(2.1),
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xffE60012)),
                                ),
                                SizedBox(
                                  height: _responsive.ip(0.75),//5,
                                ),
                                Text(widget.aConcesionarioList[index].nombre,
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
                                widget.aConcesionarioList[index].isExpanded? 
                                Text(widget.aConcesionarioList[index].direccion,
                                    style: TextStyle(
                                // fontFamily: 'HelveticaNeue',
                                fontFamily: "HelveticaNeue",
                                fontSize: _responsive.ip(1.65),
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff94949A))):
                                    Text(widget.aConcesionarioList[index].direccion,
                                maxLines: 1,//widget.textPremio,
                                overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                // fontFamily: 'HelveticaNeue',
                                fontFamily: "HelveticaNeue",
                                fontSize: _responsive.ip(1.65),
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff94949A)))
                              ],
                            ),
                          )),
                      trailing: Container(
                        padding: EdgeInsets.only(top: 16,left: 6),
                        child: Icon(
                          widget.aConcesionarioList[index].isExpanded
                              // isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Color(0xFFE60012),
                          size: _responsive.ip(4.2)//28.0,
                        ),
                      ),
                      onExpansionChanged: ((newState) {
                        if (newState) {
                          setState(() {
                            Duration(seconds: 20000);
                            selected = index;
                            widget.aConcesionarioList[index].isExpanded =
                                newState;
                            // print(newState);
                          });
                        } else
                          setState(() {
                            widget.aConcesionarioList[index].isExpanded =
                                newState;
                            selected = index;
                          });
                      }),
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: 15, right: 15, bottom: 18),
                          child: Column(
                            children: <Widget>[
                              Divider(height: 5.0, thickness: 1),
                              SizedBox(height: 5,),
                              Container(
                                margin: EdgeInsets.only(top: _responsive.ip(1.8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    GestureDetector(
                                        onTap: () {
                                          _launchLlamarURL(widget
                                              .aConcesionarioList[index]
                                              .telefono);
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
                                        )),
                                    GestureDetector(
                                      onTap: () {
                                        _launchWhatsApp(widget.aConcesionarioList[index].whatsapp, widget.aConcesionarioList[index].servicios,widget.citasBloc);
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
                                      onTap: () {
                                        
                                        _launchEmailURL(
                                            widget.aConcesionarioList[index]
                                                .correo, //'nathalymilk@gmail.com',
                                            'CONCESIONARIO ${widget.aConcesionarioList[index].nombre}',
                                            widget.aConcesionarioList[index].servicios,
                                            widget.citasBloc
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
                                      onTap: () {
                                        _launchOpenMap(
                                            widget.aConcesionarioList[index]);
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
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ]
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
             padding: EdgeInsets.only(left: 12.5,right: 12.5),
              child: Center(
                  child: Text(
                '${widget.aConcesionarioList[index].distancia} Km', //"4,3 Km",
                textAlign: TextAlign.center,
                style: TextStyle(
      color: Color(0xFFFFFFFF),
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: _responsive.ip(1.8)),
              )),
              decoration: BoxDecoration(
                color: Color(0xff71C341),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              ),
            )),
      ],
    );
  }

  _launchLlamarURL(String telefono) async {
    final parentContext = context;
    if (telefono == null || telefono == "") {
      // Dialogs.alertDialog(context,
      //     title: "¡Ups...!",
      //     message: "El concesionario no cuenta con un número de celular",
      //     onOk: () {});
      Dialogs.succedDialog(context,
          title: "Aviso",
          message: "El concesionario no cuenta con un número de celular",
          onOk: () {
            Navigator.pop(parentContext);
          });
    } else {
      String url = 'tel:$telefono'; //'tel:+51965951251';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  _launchWhatsApp(String telefonoWhatsapp, String tipoServicio,CitasBloc citasBloc) async {
    //String phoneNumber = '+51965951251';
    print(citasBloc);
     String stringList;
   final parentContext = context;
    if(citasBloc.sFiltroServicios == ""){
        stringList = tipoServicio;
    }else{
         List serviciosSeleccionados = citasBloc.sFiltroServicios.split(",");
    print(serviciosSeleccionados);
    List servicios = tipoServicio.split(',');
    List serviciosMatch = new List();
    serviciosSeleccionados.forEach((element) {
      
      print(element);
        servicios.forEach((element2) {
            if(element==element2){
                // print(element);
                serviciosMatch.add(element);
            }else{
              print(element2);
            }
        });
      
    });

      stringList= serviciosSeleccionados.join(",");
    }

    if (telefonoWhatsapp == null || telefonoWhatsapp == "") {
      // Dialogs.alertDialog(context,
      //     title: "¡Ups...!",
      //     message: "El concesionario no cuenta con WhatsApp",
      //     onOk: () {});
          Dialogs.succedDialog(context,
          title: "Aviso",
          message: "El concesionario no cuenta con WhatsApp",
          onOk: () {
            Navigator.pop(parentContext);
          });
    } else {
      String phoneNumber = telefonoWhatsapp;
      String message = Constantes.textConcesionarioCitasWhatsapp
          .replaceAll('{{TIPO_SERVICIO}}', stringList)//tipoServicio)
          .replaceAll('{{N_CLIENTE}}', widget.prefs.sNombresUsuario)
          .replaceAll('{{N_TELEFONO}}', widget.prefs.sCelular);


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
            Dialogs.succedDialog(context,
                title: "Aviso",
                message:
                    "No se encuentra instalado Whatsapp en tu móvil. Necesitas instalar el app en tu móvil",
                onOk: () {
                  Navigator.pop(parentContext);
                });
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
        Dialogs.succedDialog(context,
            title: "Aviso",
            message:
                "No se encuentra instalado Whatsapp en tu móvil. Necesitas instalar el app en tu móvil",
            onOk: () {
              Navigator.pop(parentContext);
            });
      }

    }
      
    }
    // DJCC: Registrar el Comportamiento Usuario
    ComportamientoUsuario.registrarEvento(widget.prefs, ingresoWhatsapp: true);
  }

  _launchEmailURL(toMailId, String subject, String tipoServicio,CitasBloc citasBloc) async {
    print(citasBloc);
     String stringList;
   final parentContext = context;

   if(citasBloc.sFiltroServicios == ""){
        stringList = tipoServicio;
    }else{
         List serviciosSeleccionados = citasBloc.sFiltroServicios.split(",");
    print(serviciosSeleccionados);
    List servicios = tipoServicio.split(',');
    List serviciosMatch = new List();
    serviciosSeleccionados.forEach((element) {
      
      print(element);
        servicios.forEach((element2) {
            if(element==element2){
                // print(element);
                serviciosMatch.add(element);
            }else{
              print(element2);
            }
        });
      
    });

      stringList= serviciosSeleccionados.join(",");
    }


    if (toMailId == null || toMailId == "") {
      // Dialogs.alertDialog(context,
      //     title: "¡Ups...!",
      //     message: "El concesionario no cuenta con correo",
      //     onOk: () {});
      Dialogs.succedDialog(context,
          title: "Aviso",
          message: "El concesionario no cuenta con correo",
          onOk: () {
            Navigator.pop(parentContext);
          });
    } else {


       String body = Constantes.textConcesionarioCitasCorreo
                                                .replaceAll('{{TIPO_SERVICIO}}', stringList)
                                                .replaceAll('{{USER_CORREO}}', widget.prefs.sCorreo)
                                                .replaceAll('{{N_CLIENTE}}', widget.prefs.sNombresUsuario)
                                                .replaceAll('{{N_TELEFONO}}', widget.prefs.sCelular);


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
          Dialogs.alertDialog(context,
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
              // Dialogs.alertDialog(context,
              //   title: "¡Ups...!",
              //   message:
              //       "No se puede enviar el correo",
              //   onOk: () {});
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

  _launchOpenMap(concesionario) async {
    ConcesionarioModel concesionarioF;
    concesionarioF = concesionario;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MapsPermission(concesionario: concesionarioF);
        });
  }
}
