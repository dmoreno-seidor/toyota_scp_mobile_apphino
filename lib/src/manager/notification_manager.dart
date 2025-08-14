import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toyota_scp_mobile_apphino/src/models/campania_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/noticia_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/evento_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/encuesta_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/respuesta_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/encuesta_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/respuesta_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/respuesta_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

import '../app_config.dart';

class NotificationManger {
  static BuildContext _context;
  // static EncuestaModel encuestaModel;
  // static EncuestaBloc _encuestaBloc;

  static init({@required BuildContext context}) {
    _context = context;
    // _encuestaBloc = Provider.encuestaBloc(context);
  }

  //this method used when notification come and app is closed or in background and
  // user click on it, i will left it empty for you
  static handleDataMsg(
    Map<String, dynamic> data,
  ) {}

  //this our method called when notification come and app is foreground
  static handleNotificationMsg(Map<String, dynamic> message, campaniaModel) {
    debugPrint("from mangger  $message");

    // final dynamic data = message['data'];
    //as ex we have some data json for every notification to know how to handle that
    //let say showDialog here so fire some action
    // if (data.containsKey('showDialog')) {
    // Handle data message with dialog
    _showDialog(message, campaniaModel);
    // }
  }

  static handleNotificationNoticia(Map<String, dynamic> message, noticiaModel) {
    debugPrint("from mangger  $message");

    // final dynamic data = message['data'];
    //as ex we have some data json for every notification to know how to handle that
    //let say showDialog here so fire some action
    // if (data.containsKey('showDialog')) {
    // Handle data message with dialog
    _showDialogNoticias(message, noticiaModel);
    // }
  }

  static handleNotificationEvento(Map<String, dynamic> message, eventoModel) {
    debugPrint("from mangger  $message");

    // final dynamic data = message['data'];
    //as ex we have some data json for every notification to know how to handle that
    //let say showDialog here so fire some action
    // if (data.containsKey('showDialog')) {
    // Handle data message with dialog
    _showDialogEvento(message, eventoModel);
    // }
  }

  static handleNotificationEncuesta(encuestaTipo, encuestaModel, encuestaBloc,
      respuestaBloc, respuestaProvider) {
    debugPrint("from mangger  $encuestaModel");
    // final dynamic data = message['data'];
    //as ex we have some data json for every notification to know how to handle that
    //let say showDialog here so fire some action
    // if (data.containsKey('showDialog')) {
    // Handle data message with dialog
    // if (encuestaTipo.toString().toLowerCase() == 'seleccion') {
    //   _showDialogEncuesta(encuestaModel, encuestaBloc, respuestaBloc);
    // } else if (encuestaTipo.toString().toLowerCase() == 'satisfaccion') {
    //   _showDialogEncuestaSatisfaccion(encuestaModel, encuestaBloc, respuestaBloc);
    // } else {
    //   throw PlatformException(code: '500', message: 'TipoEncuesta does not exist');
    // }

    _automaticShowDialog(encuestaModel, encuestaBloc, respuestaBloc);
  }

  static _automaticShowDialog(encuestaModel, encuestaBloc, respuestaBloc) {
    if (encuestaModel.tipoEncuesta.toString().toLowerCase() == 'seleccion') {
      _showDialogEncuesta(encuestaModel, encuestaBloc, respuestaBloc);
    } else if (encuestaModel.tipoEncuesta.toString().toLowerCase() ==
        'satisfaccion') {
      _showDialogEncuestaSatisfaccion(
          encuestaModel, encuestaBloc, respuestaBloc);
    } else {
      throw PlatformException(
          code: '500', message: 'TipoEncuesta does not exist');
    }
  }

  static _showDialog(
      Map<String, dynamic> message, CampaniaModel campaniaModel) {
    Responsive _responsive = new Responsive(_context);
    //you can use data map also to know what must show in MyDialog
    showDialog(
        context: _context,
        builder: (BuildContext context) {
          return
              //         Dialog(
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              // child :

              Container(
            child:
                // Stack(children: <Widget>[
                Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: _responsive.hp(30),
                  width: _responsive.wp(90),
                  child: FadeInImage.assetNetwork(
                    image: message["imagen"].replaceAll(
                        '/bridge/', "${AppConfig.api_host_docService}"),
                    placeholder: 'assets/campania/iconoCarga.gif',
                    fadeInDuration: Duration(milliseconds: 200),
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //                       Row(

                    // children: <Widget>[
                    FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xFFE60012))),
                      color: Color(0xFFE60012),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      onPressed: () {
                        // print(navigatorKey);
                        Navigator.of(context).pop();
                        // print(campaniaModel);
                        Navigator.pushNamed(context, 'campaniasDetalle',
                            arguments: campaniaModel);
                      },
                      child: Text(
                        "Ver Campaña",
                        style: TextStyle(fontSize: 18.0
                        , color: Colors.white,
                        fontFamily: 'HelveticaNeue',),
                      ),
                      // )
                      // ]
                    ),

                    FlatButton(
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "En otro momento",
                        style: TextStyle(
                          fontSize: 15.0,
                           color: Colors.white,
                           fontFamily: 'HelveticaNeue',),
                      ),
                      // )
                      // ]
                    ),
                  ],
                ),
              ],
            ),

            // ],

            //  ),
            // )
          );
        });
  }

  static _showDialogNoticias(
      Map<String, dynamic> message, NoticiaModel noticiaModel) {
    Responsive _responsive = new Responsive(_context);
    //you can use data map also to know what must show in MyDialog
    showDialog(
        context: _context,
        builder: (BuildContext context) {
          return
              //         Dialog(
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              // child :

              Container(
            child:
                // Stack(children: <Widget>[
                Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: _responsive.hp(30),
                  width: _responsive.wp(90),
                  child: FadeInImage.assetNetwork(
                    image: message["imagen"].replaceAll(
                        '/bridge/', "${AppConfig.api_host_docService}"),
                    placeholder: 'assets/campania/iconoCarga.gif',
                    fadeInDuration: Duration(milliseconds: 200),
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //                       Row(

                    // children: <Widget>[
                    FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xFFE60012))),
                      color: Color(0xFFE60012),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      onPressed: () {
                        // print(navigatorKey);
                        Navigator.of(context).pop();
                        // print(campaniaModel);
                        Navigator.pushNamed(context, 'noticiasDetalle',
                            arguments: noticiaModel);
                      },
                      child: Text(
                        "Ver Noticia",
                        style: TextStyle(fontSize: 18.0,
                         color: Colors.white,
                         fontFamily: 'HelveticaNeue',),
                      ),
                      // )
                      // ]
                    ),

                    FlatButton(
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "En otro momento",
                        style: TextStyle(
                          fontSize: 15.0, 
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',),
                      ),
                      // )
                      // ]
                    ),
                  ],
                ),
              ],
            ),

            // ],

            //  ),
            // )
          );
        });
  }

  static _showDialogEvento(
      Map<String, dynamic> message, EventoModel eventoModel) {
    Responsive _responsive = new Responsive(_context);
    //you can use data map also to know what must show in MyDialog
    showDialog(
        context: _context,
        builder: (BuildContext context) {
          return
              //         Dialog(
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              // child :

              Container(
            child:
                // Stack(children: <Widget>[
                Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: _responsive.hp(30),
                  width: _responsive.wp(90),
                  child: FadeInImage.assetNetwork(
                    image: message["imagen"].replaceAll(
                        '/bridge/', "${AppConfig.api_host_docService}"),
                    placeholder: 'assets/campania/iconoCarga.gif',
                    fadeInDuration: Duration(milliseconds: 200),
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //                       Row(

                    // children: <Widget>[
                    FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xFFE60012))),
                      color: Color(0xFFE60012),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      onPressed: () {
                        // print(navigatorKey);
                        Navigator.of(context).pop();
                        // print(campaniaModel);
                        Navigator.pushNamed(context, 'eventosDetalle',
                            arguments: eventoModel);
                      },
                      child: Text(
                        "Ver Evento",
                        style: TextStyle(
                          fontSize: 18.0, 
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',),
                      ),
                      // )
                      // ]
                    ),

                    FlatButton(
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "En otro momento",
                        style: TextStyle(
                          fontSize: 15.0, 
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',),
                      ),
                      // )
                      // ]
                    ),
                  ],
                ),
              ],
            ),

            // ],

            //  ),
            // )
          );
        });
  }

  static _showDialogEncuesta(EncuestaModel encuestaModel,
      EncuestaBloc encuestaBloc, RespuestaBloc respuestaBloc) {
    //you can use data map also to know what must show in MyDialog
    showDialog(
        context: _context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Container(
                  // width: 226,
                  height: 400,
                  child:
                      // Stack(children: <Widget>[
                      Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //     height: _responsive.hp(30),
                      //     width: _responsive.wp(90),
                      //     child: Text(encuestaModel.titulo)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 30.0,
                                right: 30.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Encuesta HINO",
                                  style: TextStyle(
                                      fontFamily: 'HelveticaNeue',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xFF1C1C1C)),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  encuestaModel.titulo,
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color(0xFF1C1C1C)),
                                ),
                                SingleChildScrollView(
                                    child: Container(
                                  height: 200.0,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (
                                      context,
                                      index,
                                    ) {
                                      {
                                        print(
                                            encuestaModel.alternativas[index]);

                                        return InkWell(
                                            splashColor: Colors.white,
                                            onTap: () async {
                                              setState(() {
                                                encuestaModel.alternativas
                                                    .forEach((element) =>
                                                        element['seleccionado'] =
                                                            false);
                                                encuestaModel
                                                        .alternativas[index]
                                                    ['seleccionado'] = true;
                                              });
                                            },
                                            child: Container(
                                              // padding: EdgeInsets.only(right: 5),

                                              // margin: new EdgeInsets.all(15.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: new Container(
                                                      height: 50,
                                                      child: Row(
                                                        children: <Widget>[
                                                          encuestaModel.alternativas[
                                                                      index][
                                                                  "seleccionado"]
                                                              ? Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              10,
                                                                          left:
                                                                              5),
                                                                  width: 25.0,
                                                                  height: 25.0,

                                                                  child: Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  // color: Color(0xff71C341),
                                                                  decoration:
                                                                      new BoxDecoration(
                                                                    color: Color(
                                                                        0xff71C341),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                )
                                                              : Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              10,
                                                                          left:
                                                                              5),
                                                                  width: 25.0,
                                                                  height: 25.0,
                                                                  decoration:
                                                                      new BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Color(
                                                                          0xFF94949A), //                   <--- border color
                                                                      width:
                                                                          1.2,
                                                                    ),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                ),
                                                          Flexible(
                                                            child: new Text(
                                                              encuestaModel
                                                                          .alternativas[
                                                                      index][
                                                                  "descripcion"], //_item.buttonText,
                                                              style: encuestaModel
                                                                              .alternativas[
                                                                          index]
                                                                      [
                                                                      "seleccionado"]
                                                                  ? TextStyle(
                                                                    fontFamily: 'HelveticaNeue',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black)
                                                                  : TextStyle(
                                                                    fontFamily: 'HelveticaNeue',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        7),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        7),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            7),
                                                                topRight: Radius
                                                                    .circular(
                                                                        7)),
                                                        border: Border.all(
                                                          color: encuestaModel
                                                                          .alternativas[
                                                                      index][
                                                                  "seleccionado"]
                                                              ? Color(
                                                                  0xFF71C341)
                                                              : Color(
                                                                  0xffFFFF), //                   <--- border color
                                                          width: 1.2,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ));
                                      }
                                    },
                                    itemCount:
                                        encuestaModel.alternativas.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                  ),
                                ))
                              ],
                            ),
                          ),

                          //                       Row(

                          // children: <Widget>[
                          FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFF71C341))),
                            color: Color(0xFF71C341),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () async {
                              // print(navigatorKey);
                              Navigator.of(context).pop();

                              int posi =
                                  encuestaBloc.finalPosiEncuestaLastValue + 1;
                              encuestaBloc.changeUltimaPosi(posi);
                              if (encuestaBloc.aEncuestasLastValue.length ==
                                  encuestaBloc.finalPosiEncuestaLastValue) {
                                RespuestaModel respuesta = new RespuestaModel();
                                respuesta.idPregunta = "";
                                respuesta.respuesta = "";
                                encuestaModel.alternativas.forEach((x) {
                                  if (x['seleccionado']) {
                                    respuesta.idPregunta = encuestaBloc
                                        .aEncuestasLastValue[encuestaBloc
                                                .finalPosiEncuestaLastValue -
                                            1]
                                        .id;
                                    respuesta.respuesta = x['id'];
                                  }
                                });
                                respuestaBloc
                                    .actualizarListaRespuesta(respuesta);

                                respuestaBloc
                                    .guardarEncuesta(
                                        encuestaBloc
                                            .aEncuestasLastValue[0].idEncuesta,
                                        respuestaBloc.aRespuestasLastValue)
                                    .then((value) {
                                  print('guardarEncuesta-> $value');
                                  if (value == true)
                                    NotificationManger.successDialog(
                                      title: "¡Excelente!",
                                      message:
                                          "Muchas gracias por realizar la encuesta, tus puntos han sido agregados con exito, puedes revisarlos en tu Historial de Puntos ",
                                    );
                                  else {
                                    NotificationManger.errorDialog();
                                  }
                                }).catchError((err) {
                                  print('guardarEncuesta -> ${err.toString()}');
                                  // NotificationManger.errorDialog(
                                  //   message: "Ha ocurrido un error no previsto - ${err.toString()}"
                                  // );
                                });
                              } else {
                                //  respuestaBloc.aRespuestaStream()
                                RespuestaModel respuesta = new RespuestaModel();
                                respuesta.idPregunta = "";
                                respuesta.respuesta = "";
                                encuestaModel.alternativas.forEach((x) {
                                  if (x['seleccionado']) {
                                    respuesta.idPregunta = encuestaBloc
                                        .aEncuestasLastValue[encuestaBloc
                                                .finalPosiEncuestaLastValue -
                                            1]
                                        .id;
                                    respuesta.respuesta = x['id'];
                                  }
                                });
                                respuestaBloc
                                    .actualizarListaRespuesta(respuesta);
                                // print(respuesta);

                                _automaticShowDialog(
                                    encuestaBloc.aEncuestasLastValue[
                                        encuestaBloc
                                            .finalPosiEncuestaLastValue],
                                    encuestaBloc,
                                    respuestaBloc);
                              }
                            },
                            child: Text(
                              "Siguiente",
                              style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                  fontSize: 14.0, color: Colors.white),
                            ),
                            // )
                            // ]
                          ),

                          // FlatButton(
                          //   textColor: Colors.white,
                          //   padding: EdgeInsets.all(8.0),
                          //   onPressed: () => Navigator.of(context).pop(),
                          //   child: Text(
                          //     "En otro momento",
                          //     style: TextStyle(fontSize: 15.0, color: Colors.white),
                          //   ),
                          //   // )
                          //   // ]
                          // ),
                        ],
                      ),
                    ],
                  ),

                  // ],

                  //  ),
                ));
          });
        });
  }

  static _showDialogEncuestaSatisfaccion(EncuestaModel encuestaModel,
      EncuestaBloc encuestaBloc, RespuestaBloc respuestaBloc) {
    double rating = 0.0;

    //you can use data map also to know what must show in MyDialog
    showDialog(
        context: _context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Container(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 30.0,
                                right: 30.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Encuesta HINO",
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xFF1C1C1C)),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  encuestaModel.titulo,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color(0xFF1C1C1C)),
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 30.0),
                                    child: Container(
                                      // height: 20.0,
                                      child: Center(
                                          child: SmoothStarRating(
                                        rating: rating,
                                        isReadOnly: false,
                                        size: 40,
                                        filledIconData: Icons.star,
                                        halfFilledIconData: Icons.star_half,
                                        defaultIconData: Icons.star_border,
                                        starCount: 5,
                                        allowHalfRating: false,
                                        spacing: 2.0,
                                        color:
                                            Color.fromRGBO(253, 193, 42, 1.0),
                                        borderColor:
                                            Color.fromRGBO(253, 193, 42, 1.0),
                                        onRated: (value) {
                                          print("rating value -> $value");
                                          // print("rating value dd -> ${value.truncate()}");
                                          rating = value;
                                        },
                                      )),
                                    )),
                                Text(
                                  encuestaModel.descripcion,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12,
                                      color: Color(0xFF1C1C1C)),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 20.0,
                          ),

                          FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFF71C341))),
                            color: Color(0xFF71C341),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              // print(navigatorKey);

                              Navigator.of(context).pop();

                              int posi =
                                  encuestaBloc.finalPosiEncuestaLastValue + 1;
                              encuestaBloc.changeUltimaPosi(posi);
                              if (encuestaBloc.aEncuestasLastValue.length ==
                                  encuestaBloc.finalPosiEncuestaLastValue) {
                                RespuestaModel respuesta = new RespuestaModel(
                                    idPregunta: encuestaModel.id,
                                    respuesta: rating.toString());
                                respuestaBloc
                                    .actualizarListaRespuesta(respuesta);
                                // Guardar la respuesta

                                respuestaBloc
                                    .guardarEncuesta(
                                        encuestaBloc
                                            .aEncuestasLastValue[0].idEncuesta,
                                        respuestaBloc.aRespuestasLastValue)
                                    .then((value) {
                                  print('guardarEncuesta-> $value');
                                  if (value == true)
                                    NotificationManger.successDialog(
                                      title: "¡Excelente!",
                                      message:
                                          "Muchas gracias por realizar la encuesta, tus puntos han sido agregados con exito, puedes revisarlos en tu Historial de Puntos ",
                                    );
                                  else {
                                    NotificationManger.errorDialog();
                                  }
                                }).catchError((err) {
                                  print('guardarEncuesta -> ${err.toString()}');
// NotificationManger.errorDialog(
// message: "Ha ocurrido un error no previsto - ${err.toString()}"
// );
                                });
                              } else {
                                RespuestaModel respuesta = new RespuestaModel(
                                    idPregunta: encuestaModel.id,
                                    respuesta: rating.toString());
                                respuestaBloc
                                    .actualizarListaRespuesta(respuesta);
// print(respuesta);

                                _automaticShowDialog(
                                    encuestaBloc.aEncuestasLastValue[
                                        encuestaBloc
                                            .finalPosiEncuestaLastValue],
                                    encuestaBloc,
                                    respuestaBloc);
                              }
                            },
                            child: Text(
                              "Enviar",
                              style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                  fontSize: 14.0, color: Colors.white),
                            ),
                          ),

                          FlatButton(
                            // color: Color(0xFF71C341),
                            // textColor: Colors.grey,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              // print(navigatorKey);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "En otro momento",
                              style:
                                  TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                    fontSize: 12.0, color: Colors.grey),
                            ),
                          )
                          //   // )
                        ],
                      ),
                    ],
                  ),

                  //  ),
                ));
          });
        });
  }

  // static void alert(BuildContext context,
  //     {String title = '', String message = '', VoidCallback onOk}) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return CupertinoAlertDialog(
  //           title: Text(
  //             title,
  //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  //           ),
  //           content: Text(
  //             message,
  //             style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
  //           ),
  //           actions: <Widget>[
  //             CupertinoDialogAction(
  //               child: Text("Ok"),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }

  static void successDialog({String title = '', String message = ''}) {
    showDialog(
        context: _context,
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
                                fontFamily: 'HelveticaNeue',
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
                                  fontFamily: 'HelveticaNeue',
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
                                // onPressed: onOk,
                                onPressed: () => Navigator.of(context).pop(),
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

  static void errorDialog(
      {String title = '¡Alerta!',
      String message =
          'No se ha podido grabar correctamente la encuesta, disculpe las molestias '}) {
    showDialog(
        context: _context,
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
                                fontFamily: 'HelveticaNeue',
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
                                  fontFamily: 'HelveticaNeue',
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
                                // onPressed: onOk,
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  "Ok, Entendido",
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                      fontSize: 18.0, color: Colors.white
                                      ),
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
                              'assets/recuperarContrasena/circuloNaranja.png'),
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

  static void dialogIntroductorioEncuesta(
      {String title = '',
      String message = '',
      EncuestaBloc encuestaBloc,
      RespuestaBloc respuestaBloc,
      RespuestaProvider respuestaProvider}) {
    showDialog(
        context: _context,
        builder: (BuildContext context) {
          return Stack(children: <Widget>[
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: Container(
                width: 226,
                height: 370,
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        // height: 300,
                        // width: 192,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0xFF1C1C1C)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 70,
                              height: 69.95,
                              decoration: new BoxDecoration(
                                image: DecorationImage(
                                  image: new AssetImage(
                                      'assets/encuesta/encuestaLogo.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
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
                                  fontFamily: 'HelveticaNeue',
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
                    Column(
                      children: <Widget>[
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
                                        side: BorderSide(
                                            color: Color(0xFF71C341))),
                                    color: Color(0xFF71C341),
                                    textColor: Colors.white,
                                    // padding: EdgeInsets.all(8.0),
                                    // onPressed: onOk,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _automaticShowDialog(
                                          encuestaBloc.aEncuestasLastValue[0],
                                          encuestaBloc,
                                          respuestaBloc);
                                      // _showDialogEncuesta(
                                      //     encuestaBloc.aEncuestasLastValue[0],
                                      //     encuestaBloc,respuestaBloc);
                                    },
                                    child: Text(
                                      "Empezar",
                                      style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                          fontSize: 14.0,
                                          color: Colors.white,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ))
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  width: 152,
                                  height: 40,
                                  child: FlatButton(
                                    // shape: new RoundedRectangleBorder(
                                    //     borderRadius:
                                    //         new BorderRadius.circular(18.0),
                                    //     side: BorderSide(
                                    //         color: Color(0xFF71C341))),
                                    // color: Color(0xFF71C341),
                                    // textColor: Colors.white,
                                    // padding: EdgeInsets.all(8.0),
                                    // onPressed: onOk,
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text(
                                      "En otro momento",
                                      style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                          fontSize: 14.0,
                                          color: Color(0xff94949A),
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ))
                            ])
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ]);
        });
  }
}

class RadioItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const RadioItem({Key key, this.item}) : super(key: key);
  // RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      // margin: EdgeInsets.only(right: 5),
      padding: EdgeInsets.only(right: 8),
      // margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 35.0,
            child: new Center(
              child: new Text(
                item['descripcion'], //_item.buttonText,
                style: item['seleccionado']
                    ? TextStyle(
                      fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white)
                    : TextStyle(fontWeight: FontWeight.w500, fontSize: 12,
                    fontFamily: 'HelveticaNeue',),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7),
                  topLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                  topRight: Radius.circular(7)),
              color: item['seleccionado'] ? Color(0xFFE60012) : Color(0xffFFFF),
              border: Border.all(
                color: Color(0xFFE60012), //                   <--- border color
                width: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  final Map talla;

  RadioModel(this.talla);
}
