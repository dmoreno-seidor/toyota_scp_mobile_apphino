import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toyota_scp_mobile_apphino/src/estilos.dart';
import 'package:toyota_scp_mobile_apphino/src/models/catalogo_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/concesionario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/catalogo_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_config.dart';
import '../constantes.dart';
import '../pages/maps_permission.dart';
import '../preferencias_usuario/preferencias_usuario.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';

class ContainerConcesionarioDetallePremio extends StatefulWidget {
  final List aConcesionarioDetallePremio;
  final CatalogoModel catalogoModel;
  final CatalogoBloc catalogoBloc;
  final PreferenciasUsuario prefs;

  const ContainerConcesionarioDetallePremio({Key key, this.aConcesionarioDetallePremio, this.catalogoModel, this.catalogoBloc, this.prefs}) : super(key: key);

  @override
  _ContainerConcesionarioDetallePremio createState() => _ContainerConcesionarioDetallePremio();
}

class _ContainerConcesionarioDetallePremio extends State<ContainerConcesionarioDetallePremio> {
  List<Map> listOfMa;
  bool isExpanded = false;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return 
    
    widget.aConcesionarioDetallePremio.length==0?
    _nobuildConcesionarioDetallePremioList()
    :
    
     ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: _buildConcesionarioDetallePremioList,
                  itemCount: widget.aConcesionarioDetallePremio.length,
                  shrinkWrap: true,
                );
  }

 Widget _nobuildConcesionarioDetallePremioList(){
    Responsive _responsive = new Responsive(context);
    return   Container(
              // color: Colors.amberAccent,
              // margin: EdgeInsets.only(bottom: 20.0),
              
                child: Text(
                              // 'No hay Concesionarios disponibles',
                              'Por el momento no tenemos Concesionarios disponibles para ti.',
                              // style: AppConfig.styleSubCabecerasPaginas,
                              style: TextStyle(
                // fontFamily: 'HelveticaNeue',
                fontFamily: "HelveticaNeue",
                fontSize: _responsive.ip(2.4),//16,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                color: Colors.black),
                textAlign: TextAlign.center,

                            ),
              
      
        
      );
  }
   


  Widget _buildConcesionarioDetallePremioList(
    BuildContext context,
    int index,
  ) {
    final _responsive = Responsive(context);
    //[{"3":"false"},{"10":"false"},{"11":"false"},{"14":"false"}];

    print(widget.aConcesionarioDetallePremio[index].id.toString());

    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          width: MediaQuery.of(context).size.width,
          child: ExpansionTile(
            title: Container(
              
                padding: EdgeInsets.only(
                    left: 2,
                    right: 0,
                    top: 4.0,
                    bottom: 6.0),
                child: Container(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.aConcesionarioDetallePremio[index].distrito,
                        // style: AppConfig.styleTituloConcesionarioLugar,
                        style: TextStyle(
                            // fontFamily: 'HelveticaNeue',
                            fontFamily: "HelveticaNeue",
                            fontSize: _responsive.ip(2.1),//14,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            color: Color(0xffE60012)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      widget.aConcesionarioDetallePremio[index].isExpanded?Text(widget.aConcesionarioDetallePremio[index].nombre,
                          // style: AppConfig.styleTituloConcesionario,
                          style: TextStyle(
                              // fontFamily: 'HelveticaNeue',
                              fontFamily: "HelveticaNeue",
                              fontSize: _responsive.ip(2.1),//14,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              color: Colors.black),
                           
                        overflow: TextOverflow.ellipsis,
                          ):Text(widget.aConcesionarioDetallePremio[index].nombre,
                          // style: AppConfig.styleTituloConcesionario,
                          style: TextStyle(
                              // fontFamily: 'HelveticaNeue',
                              fontFamily: "HelveticaNeue",
                              fontSize: _responsive.ip(2.1),//14,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              color: Colors.black),
                           maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                          )
                          ,
                          
                      SizedBox(
                        height: 4,
                      ),
                      widget.aConcesionarioDetallePremio[index].isExpanded?
                      Text(widget.aConcesionarioDetallePremio[index].direccion,
                          // style: AppConfig.styleTituloConcesionarioDireccion
                          style: TextStyle(
                                  // fontFamily: 'HelveticaNeue',
                                  fontFamily: "HelveticaNeue",
                                  fontSize: _responsive.ip(1.65),
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xff94949A)),
                          ):
                      Text(widget.aConcesionarioDetallePremio[index].direccion,
                       maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                          // style: AppConfig.styleTituloConcesionarioDireccion
                          style: TextStyle(
      // fontFamily: 'HelveticaNeue',
                            fontFamily: "HelveticaNeue",
                            fontSize: _responsive.ip(1.65),
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            color: Color(0xff94949A)),
                          )

                         
                    ],
                  ),
                )),
        //         trailing: Icon(
        //   widget.aConcesionarioDetallePremio[index].isExpanded
        //       ? Icons.keyboard_arrow_up
        //       : Icons.keyboard_arrow_down,
        //   color: Color(0xFFE60012),
        //   size: 30.0,
        // ),
            trailing: Container(
              margin: EdgeInsets.only(top: _responsive.ip(4.5)),//30),
              child: Icon(
                 widget.aConcesionarioDetallePremio[index].isExpanded
                // isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Color(0xFFE60012),
                size: _responsive.ip(3.75),//25.0,
              ),
            ),
            // onExpansionChanged: (bool expanding) {
            //   setState(() {
            //     isExpanded = expanding;
            //   });
            // },
            onExpansionChanged: ((newState) {
          if (newState) {
            setState(() {
              Duration(seconds: 20000);
              selected = index;
              widget.aConcesionarioDetallePremio[index].isExpanded = newState;
              // print(newState);
            });
            // DJCC: Registrar el Comportamiento Usuario
            ComportamientoUsuario.registrarEvento(widget.prefs, ingresoRedConcesionario: true);
          }
          else
            setState(() {
              widget.aConcesionarioDetallePremio[index].isExpanded = newState;
              selected = index;
            });
        }),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: 15, right: 15, bottom: 18), //EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Divider(height: 5.0, thickness: 1),
                    SizedBox(height: 5,),
                    Container(
                      margin: EdgeInsets.only(top: _responsive.ip(1.8)),//12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.phoneAlt,
                                    color: Color(0xFF00BDE6),
                                    size: _responsive.ip(3.6),//24,
                                  ),
                                  SizedBox(
                                    height: _responsive.ip(1.5)//10,
                                  ),
                                  Text(
                                    "Llamar",
                                    // style: AppConfig
                                    //     .styleTituloConcesionarioOpciones,
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
                              onTap: () {
                                _launchLlamarURL(widget.aConcesionarioDetallePremio[index].telefono);
                              }),
                          GestureDetector(
                            onTap: () {
                              final parentContext = context;

                              String talla = widget.catalogoBloc.sDescripcionAdicionalTalla;
                              String color = widget.catalogoBloc.sDescripcionAdicionalColor;
                              
                              if(talla.isEmpty || color.isEmpty){

                                if(talla.isEmpty && color.isEmpty){
                                  //   Dialogs.alertDialog(context,
                                  // title: "¡Ups...!",
                                  // message: "¡Por favor! elegir una talla & color",
                                  // onOk: () {});
                                   Dialogs.succedDialog(context,
                                  title: "Aviso",
                                  message: "¡Por favor! elegir una talla & color",
                                  onOk: () {
                                    Navigator.pop(parentContext);
                                  });
                                }else{

                                    if(talla.isEmpty){
                                        // Dialogs.alertDialog(context,
                                        // title: "¡Ups...!",
                                        // message: "¡Por favor! elegir una talla",
                                        // onOk: () {});
                                         Dialogs.succedDialog(context,
                                        title: "Aviso",
                                        message: "¡Por favor! elegir una talla",
                                        onOk: () {
                                          Navigator.pop(parentContext);
                                        });
                                    }

                                    if(color.isEmpty){
                                        // Dialogs.alertDialog(context,
                                        // title: "¡Ups...!",
                                        // message: "¡Por favor! elegir una color",
                                        // onOk: () {});
                                        Dialogs.succedDialog(context,
                                        title: "Aviso",
                                        message: "¡Por favor! elegir una color",
                                        onOk: () {
                                          Navigator.pop(parentContext);
                                        });

                                    }

                                }

                              }else{
                                _launchWhatsApp(widget.aConcesionarioDetallePremio[index].whatsapp);
                              }



                              
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Color(0xFF4CAF50),
                                    size: _responsive.ip(3.6),//24,
                                ),
                                SizedBox(
                                  height: _responsive.ip(1.5)//10,
                                ),
                                Text(
                                  "Chatear",
                                  // style: AppConfig
                                  //     .styleTituloConcesionarioOpciones,
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
                            onTap: () {
                              final parentContext = context;
                              String talla = widget.catalogoBloc.sDescripcionAdicionalTalla;
                              String color = widget.catalogoBloc.sDescripcionAdicionalColor;
                              
                              if(talla.isEmpty || color.isEmpty){

                                if(talla.isEmpty && color.isEmpty){
                                  //   Dialogs.alertDialog(context,
                                  // title: "¡Ups...!",
                                  // message: "¡Por favor! elegir una talla & color",
                                  // onOk: () {});
                                  Dialogs.succedDialog(context,
                                  title: "¡Ups...!",
                                  message: "¡Por favor! elegir una talla & color",
                                  onOk: () {
                                    Navigator.pop(parentContext);
                                  });
                                }else{

                                    if(talla.isEmpty){
                                        // Dialogs.alertDialog(context,
                                        // title: "¡Ups...!",
                                        // message: "¡Por favor! elegir una talla",
                                        // onOk: () {});
                                        Dialogs.succedDialog(context,
                                        title: "Aviso",
                                        message: "¡Por favor! elegir una talla",
                                        onOk: () {
                                          Navigator.pop(parentContext);
                                        });
                                    }

                                    if(color.isEmpty){
                                        // Dialogs.alertDialog(context,
                                        // title: "¡Ups...!",
                                        // message: "¡Por favor! elegir una color",
                                        // onOk: () {});
                                        Dialogs.succedDialog(context,
                                        title: "Aviso",
                                        message: "¡Por favor! elegir una color",
                                        onOk: () {
                                          Navigator.pop(parentContext);
                                        });
                                    }

                                }

                              }else{
                                _launchEmailURL( 
                                  widget.aConcesionarioDetallePremio[index].correo,//'nathalymilk@gmail.com',
                                  'CONCESIONARIO ${widget.aConcesionarioDetallePremio[index].nombre}', //'Concesionario Mitsui Automotriz',
                                  Constantes.textConcesionarioPremioCorreo
                                  .replaceAll('{{N_NOMBRE}}', widget.prefs.sNombresUsuario)
                                  .replaceAll('{{N_PREMIO}}',
                                   widget.catalogoBloc.sCodigoPremio +" - "+ widget.catalogoModel.descrip
                                   )
                                  //  +widget.catalogoBloc.sDescripcionAdicionalTalla + widget.catalogoBloc.sDescripcionAdicionalColor)
                                   .replaceAll('{{N_CORREO}}', widget.prefs.sCorreo)
                                   .replaceAll('{{N_TELEFONO}}', "Mi teléfono es  : " + widget.prefs.sCelular + "."));
                              }

                            },
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.envelope,
                                  color: Color(0xFFFFAF00),
                                    size: _responsive.ip(3.6),//24,
                                ),
                                SizedBox(
                                  height: _responsive.ip(1.5)//10,
                                ),
                                Text(
                                  "Escribir",
                                  // style: AppConfig
                                  //     .styleTituloConcesionarioOpciones,
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
                            onTap: () {
                              _launchOpenMap(
                                widget.aConcesionarioDetallePremio[index]
                                // widget.aConcesionarioDetallePremio[index].latitud,
                                // widget.aConcesionarioDetallePremio[index].longitud
                                );
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.mapMarkedAlt,
                                    color: Color(0xFF71C341),
                                      size: _responsive.ip(3.6),//24,
                                    ),
                                    
                                SizedBox(
                                  height: _responsive.ip(1.5)//10,
                                ),
                                Text(
                                  "Ubicar",
                                  // style:
                                  //     AppConfig.styleTituloConcesionarioOpciones,
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
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [AppConfig.boxShadow
            ],
          ),
        ),
        Positioned(
            top: 8.0,
            right: 0.0,
            child: Container(
              height: 28,
             padding: EdgeInsets.only(left: 12.5,right: 12.5),
              child: Center(
                  child: Text(
                '${widget.aConcesionarioDetallePremio[index].distancia} Km',//"4,3 Km",
                textAlign: TextAlign.center,
                style: TextStyle(
      color: Color(0xFFFFFFFF),
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: _responsive.ip(1.8)//12
      ),
                // style: EstilosConfig.styleEtiquetaKilometraje,
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
    if(telefono == null || telefono ==""){
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
    final parentContext = context;
    if(telefonoWhatsapp == null || telefonoWhatsapp ==""){
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
    String message = Constantes.textConcesionarioPremioWhatsapp
    .replaceAll('{{N_NOMBRE}}', widget.prefs.sNombresUsuario)                             
    .replaceAll('{{N_PREMIO}}',widget.catalogoBloc.sCodigoPremio +" - "+ widget.catalogoModel.descrip);
    //  +widget.catalogoBloc.sDescripcionAdicionalTalla + widget.catalogoBloc.sDescripcionAdicionalColor);

    

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
    ComportamientoUsuario.registrarEvento(widget.prefs, ingresoWhatsapp: true);
  }

  _launchEmailURL( toMailId, String subject, String body) async {
    final parentContext = context;
    if(toMailId == null || toMailId ==""){
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

  _launchOpenMap(concesionario) async {
    // LatLng posiConcesionario = new LatLng(double.parse(latitude),double.parse(longitude));
    ConcesionarioModel concesionarioF ;
    concesionarioF = concesionario;
    showDialog(context: context, 
      builder: (BuildContext context){
        return MapsPermission(
          concesionario : concesionarioF);
      }
    );
  }

}
