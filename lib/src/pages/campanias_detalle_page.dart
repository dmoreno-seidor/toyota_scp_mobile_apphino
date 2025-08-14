import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/models/campania_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/concesionario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/campania_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
// import 'dart:convert';

import '../preferencias_usuario/preferencias_usuario.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';

class CampaniasDetallePage extends StatefulWidget {
  CampaniasDetallePage({Key key}) : super(key: key);
   static final String routeName = "campaniasDetalle";
  @override
  _CampaniasDetallePageState createState() => _CampaniasDetallePageState();
}

class _CampaniasDetallePageState extends State<CampaniasDetallePage> with WidgetsBindingObserver {
  String _concesionarioSeleccionado = '';
  ConcesionarioModel concesionarioSeleccionado = ConcesionarioModel();
  CampaniaModel campaniaModel;
  // ConcesionarioModel concesionarioModel;
  CampaniaBloc campaniaBloc = CampaniaBloc();
  final prefs = new PreferenciasUsuario();
  

  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
    campaniaModel =
        (ModalRoute.of(context).settings.arguments);
    
    // final size = MediaQuery.of(context).size;
    // final responsive = Responsive(context);

    return Scaffold(
        body: SingleChildScrollView(
                  child: Column(
          children: <Widget>[
            _crearCabecera(concesionarioSeleccionado),
            // Expanded(
            //             child: SingleChildScrollView(
            //               child: Column(
            //       children: <Widget>[
                    _dropdownConcesionarioCampania(campaniaModel,concesionarioSeleccionado),
                _crearCajaContenido(campaniaModel),
                SizedBox(height: 35.0),
            //       ],
            //     ),
            //   ),
            // )
            
          ],
      ),
        ),
    );
  }

  
  Widget _crearCabecera(concesionarioSeleccionado) {
    final _responsive = Responsive(context);
    return Container(
        child: Column(
      children: <Widget>[
        campaniaModel != null?
        Hero(
          tag: '${campaniaModel.id}-campania',
                  child: Stack(
            children: <Widget>[
              Container(
                height: _responsive.ip(60),//400,
                // height: 380,
                // child: Image(
                //     image: 
                //     NetworkImage(campaniaModel.imagen
                //         .replaceAll('/bridge/',
                //              "${AppConfig.api_host_docService}")),
                //     // fit: BoxFit.fill
                //     fit : BoxFit.cover
                // ),
                child: 
                AspectRatio(
                  aspectRatio: 16/9,
                                  child: 
                                  ClipRect(
                                                                      child: 
                 PhotoView(
                    minScale: PhotoViewComputedScale.covered,
            maxScale: PhotoViewComputedScale.covered,
                    // enableRotation: true,
      imageProvider: NetworkImage(campaniaModel.imagen
                          .replaceAll('/bridge/',
                               "${AppConfig.api_host_docService}")
                               
                               
                               ),
                               loadingBuilder: (context, event) {
                             return Container(
           
          margin: EdgeInsets.all(8),
    
          decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              'assets/campania/iconoCarga.gif'),
          fit: BoxFit.cover,
        ),
          
        ),
      );    
                               }
         
    ),
                                  ),
                )

    
              ),
              Positioned(
                // top: 10.0,
                left: 0.0,
                right: 0.0,
                child: SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: _responsive.wp(6), right: _responsive.wp(6)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: EdgeInsets.only(top:10,bottom: 10,right: 16),
                                                      child: Container(
                              //  margin: EdgeInsets.only(bottom: 10),
                                        height: _responsive.ip(1.53), //10.24,
                                        width: _responsive.ip(2.4), //
                              decoration: new BoxDecoration(
                                image: DecorationImage(
                                  image: new AssetImage(
                                      'assets/general/arrow_white.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _button(concesionarioSeleccionado),
            ],
          ),
        ):Container(),
      ]
    ));
  }

  Widget _button(concesionarioSeleccionado) {
    final _responsive = Responsive(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(
                top: _responsive.ip(57)//380
                // top : 330
            ),
            height:_responsive.ip(6),//40.0,
            child:
            campaniaBloc.oConcesionarioSeleccionado!=null?RaisedButton(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Solicitar campaña",
                    style: AppConfig.styleTextBoton,
                  )),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
              elevation: 0.0,
              color: Color(0xffE60012),
              textColor: Colors.white,
              onPressed: () {
                print(campaniaBloc);
                Dialogs.campaniaDialog(
                  context, 
                  campaniaModel: campaniaModel,
                  concesionario: campaniaBloc.oConcesionarioSeleccionado//jsonDecode(campaniaModel.aConcesionarios)
                // aConcesionarios = jsonDecode(campaniaModel['aConcesionarios'])
           
                );
                // DJCC: Registrar el Comportamiento Usuario
                ComportamientoUsuario.registrarEvento(prefs, ingresoRedConcesionario: true);
              },
            ):RaisedButton(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Solicitar campaña",
                    style: AppConfig.styleTextBotonDeshabilitado,
                  )),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
              elevation: 0.0,
              color: Color(0xff9A9B9A),
              textColor: Colors.white,
              onPressed: (){
                print(":v");
              },
            )
            
            ,
          ),
      ],
    );
  }

  Widget _dropdownConcesionarioCampania(campaniaModel,concesionarioSeleccionado) {
    final _responsive = Responsive(context);

    return  Container(
          width: double.infinity,
          margin: EdgeInsets.only(
              left: _responsive.wp(6),
              right: _responsive.wp(6),
              top: 16),
          child:
          Stack(
                                          children: <Widget>[
                                            Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.only(
                                                    left: 16.0, bottom: _responsive.ip(0.9),top: _responsive.ip(1.5)),
                                                child: Text(
                                                  'Concesionario',
                                                  style: TextStyle(
                                                      fontFamily: 'HelveticaNeue',
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: _responsive.ip(1.8),
                                                      color: Color(0xFFE60012)),
                                                )),
                                           

                                             Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.only(
                                                 top: _responsive.ip(2.6)),
                                                child: _dropDownConcesionario(campaniaModel,concesionarioSeleccionado)),
                                          ],
                                        ),
          //  Stack(
          //   children: <Widget>[
          //     Container(
          //         width: double.infinity,
          //         padding: EdgeInsets.only(left: 16.0, top: 6.0),
          //         // margin: EdgeInsets.only(
          //         //     left: 30, right: 24, top: _responsive.hp(29)),
          //         child: Text(
          //           'Concesionario',
          //           style: TextStyle(
          //               fontFamily: 'HelveticaNeue',
          //               fontWeight: FontWeight.bold,
          //               fontStyle: FontStyle.normal,
          //               fontSize: 14.0,
          //               color: Color(0xFFE60012)),
          //         )),
          //     // Text('Placa'),
          //     Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         SizedBox(height: 6),
          //         _dropDownConcesionario(campaniaModel,concesionarioSeleccionado),
          //       ],
          //     ),
          //   ],
          // ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [AppConfig.boxShadow],
          ),
          // height: 54,
          height: _responsive.ip(8.3),
        
        );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdownConcesionario(
    BuildContext context, dynamic concesionario) {
      Responsive _responsive = new Responsive(context);
    List<DropdownMenuItem<String>> lista = new List();
      if (concesionario != null) {
      lista.add(DropdownMenuItem(
          child: Text("Seleccione", 
           style : TextStyle(
                                          fontFamily: 'HelveticaNeue',
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: _responsive.ip(1.8),//12.0,
                                          color: Colors.black)),
          value: "",
        ));
      List<dynamic> listaConcesionario= concesionario;
      // if(listaConcesionario.length==1 ){
      //   _concesionarioSeleccionado =listaConcesionario[0]['id'].toString();
      // }
      listaConcesionario.forEach((elemento) {
        lista.add(DropdownMenuItem(
          child: Text(elemento['nombre'],
           style : TextStyle(
                                          fontFamily: 'HelveticaNeue',
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: _responsive.ip(1.8),//12.0,
                                          color: Colors.black)),
          value: elemento['id'].toString(),
        ));
        print(elemento);
      });
    }

    return lista;
  }

  Widget _dropDownConcesionario(campaniaModel,concesionarioSeleccionado) {
    final _responsive = Responsive(context);
    return StreamBuilder<Object>(
      stream: campaniaBloc.campaniaStream,
      builder: (context, snapshot){
        return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          DropdownButtonHideUnderline(
            child: Expanded(
              child: Container(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: campaniaModel.aConcesionarios.length>0?DropdownButton(
                      iconEnabledColor: Color(0xFFE60012),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.0,
                      ),
                      value: _concesionarioSeleccionado,
                      items: campaniaModel.aConcesionarios== null ?[]:
                      getOpcionesDropdownConcesionario(context, campaniaModel.aConcesionarios),
                      onChanged: (opt) {
                        setState(() {
                          _concesionarioSeleccionado = opt;
                        

                        if(opt==""){
                              campaniaBloc.changeConcesionarioSeleccionado(null);
                        }else{
                              campaniaModel.aConcesionarios.forEach((item) {
                          if (item["id"] == opt) {
                            // concesionarioSeleccionado = item;
                            ConcesionarioModel oConcesionario = ConcesionarioModel.fromJson(item);
                            campaniaBloc.changeConcesionarioSeleccionado(oConcesionario);
                          }
                        });
                        }
                        

          // print(  jsonDecode(campaniaModel.aConcesionarios).where((x) => x.id == opt) );
                        });
                      }):Container(
                        padding: EdgeInsets.only(left: _responsive.wp(6),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("No Existen Concesionario", style: TextStyle(fontFamily: "HelveticaNeue",),),
                          ],
                        ),
                      ),
                ),
              ),
            ),
          )
        ],
      ),
    );
    }
    );

    
  }

  Widget _crearCajaContenido(campaniaModel) {
    final _responsive = Responsive(context);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
          left: _responsive.wp(6),
          right: _responsive.wp(6),
          top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    campaniaModel.nombre,
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontSize: _responsive.ip(2.7),//18.0,
                        color: Color(0xFF000000)),
                  ),
                  SizedBox(height: _responsive.ip(1.5)),//10.0),
                  Text(
                   'Vigencia hasta el '+ campaniaModel.vigencia,
                    style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontSize: _responsive.ip(1.8),//12.0,
                        color: Color(0xFF94949A)),
                  ),
                  SizedBox(height: _responsive.ip(1.5)//10.0
                  ),
                ],
              )),
          Container(
                  margin: EdgeInsets.only(
                      left: 16, right:16, bottom: _responsive.ip(1.2)),//8),
                  child: Divider(thickness: 1.0)),

          _terminosyCondiciones(campaniaModel), 
          
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [AppConfig.boxShadow],
      ),
      // height: 500,
    );
  }

  Widget _terminosyCondiciones(campaniaModel){
    Responsive _responsive = new Responsive(context);
    return Container(
     
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
             padding: EdgeInsets.only( right: 16,left: 16),
            child: Text('Términos y Condiciones',
            style: TextStyle(
              fontFamily: 'HelveticaNeue',
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontSize: _responsive.ip(1.8),//12.0,
              color: Color(0xFF1C1C1C)
            )),
          ),
          SizedBox(height: 5.0),

          // Text(campaniaModel.terminos,
          // textAlign: TextAlign.justify,
          // style: TextStyle(
          //   fontFamily: 'HelveticaNeue',
          //   fontStyle: FontStyle.normal,
          //   fontSize: _responsive.ip(1.8),//12.0,
          //   // height: 1.2,
          //   color: Color(0xFF1C1C1C),
          //   // letterSpacing: 2.5
          // )),

          Container(
            padding: EdgeInsets.only( right: 8,left: 8),
            child: Html(
                            data: campaniaModel.terminos,
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
                              )
                              
                              }),
          )
          
        ],
      ),
      
    );
  }
}
