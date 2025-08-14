import 'dart:convert';
import 'dart:io';
//import 'dart:io' as Io;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/Provider.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/formatters.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
// import 'package:toyota_scp_mobile_apphino/src/widgets/input_text_crear_cuenta.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/text_mi_perfil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/text_mi_perfil_loading.dart';

import 'bloc/usuario_bloc.dart';

import '../comportamiento_usuario/comportamiento_usuario.dart';

class MiPerfilPage extends StatefulWidget {
  MiPerfilPage({Key key}) : super(key: key);
  static final String routeName = "miPerfil";
  @override
  _MiPerfilPageState createState() => _MiPerfilPageState();
}

class _MiPerfilPageState extends State<MiPerfilPage>with WidgetsBindingObserver {
final prefs = new PreferenciasUsuario();
//  UsuarioBloc usuarioBloc = new UsuarioBloc();
File _image;
bool _isFetching=false;

Future getImage(UsuarioBloc usuarioBloc) async {
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
            usuarioBloc.consultarDataCliente2(prefs.iId);
            print(urlImagen);
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
    // final _urlImage = 'https://scontent.flim18-3.fna.fbcdn.net/v/t1.0-9/86935181_10158134461222716_5327045227104436224_n.jpg?_nc_cat=108&_nc_sid=110474&_nc_eui2=AeGDFjPgZuaHa6bsq0t_OF2I-djGZLzneF352MZkvOd4XVW4QPngc1k-CY83SA6xmOk&_nc_oc=AQn320P65FVSAbIDltMGNbBhWVQUEs834P_3GUbju6Rh4uaSTKflJbPMVyBB7N9JmyY&_nc_ht=scontent.flim18-3.fna&oh=f562eb6bc1c481cc5457e7052ac0eb75&oe=5EB778D4';
    // final usuarioDataStorage = prefs.usuarioInfo;
    // Map<String,dynamic> usuarioData = jsonDecode(usuarioDataStorage);
    final usuarioBloc = Provider.usuarioBloc(context);
    final _size = MediaQuery.of(context).size;
    final _responsive = Responsive(context);
    usuarioBloc.consultarDataCliente2(prefs.iId);
    return Scaffold(
      body: StreamBuilder<Object>(
        stream: usuarioBloc.oUsuarioStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Stack(
            children: <Widget>[
              Container(
              child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    color: Color(0xFFE60012),
                    width: _size.width,
                    height: _responsive.hp(36),
                  ),
                  Positioned(
                    top: 10.0,
                    left: 0.0,
                    right: 0.0,
                    child: SafeArea(
                      child: Container(
                        margin: EdgeInsets.only(
                              left: _responsive.wp(6),
                              right: _responsive.wp(6)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                height: _responsive.ip(1.53),//10.24,
                                width: _responsive.ip(2.4),//16,
                                decoration: new BoxDecoration(
                                  image: DecorationImage(
                                    image: new AssetImage(
                                        'assets/general/arrow_white.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            Text(
                              "Mi Perfil",
                              // style: AppConfig.styleCabecerasPaginas,
                              style: TextStyle(
      // fontFamily: 'HelveticaNeue',
                                fontFamily: "HelveticaNeue",
                                fontSize: _responsive.ip(3.3),
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                     margin: EdgeInsets.only(
                                   
                                    top: 8),
                      child: Stack(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, top: 
                                    _responsive.ip(20.4)// 136
                                    ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // SizedBox(
                                    //   height: 36.0,
                                    // ),
                                    Container(height: _responsive.ip(4.4),),
                                    snapshot.hasData?Container(
                                      // padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "${usuarioBloc.oUsuario.sNombres} ${usuarioBloc.oUsuario.sApellidoPaterno} ${usuarioBloc.oUsuario.sApellidoMaterno}",//'Evert Joseph Enciso Lopez',
                                        // textScaleFactor: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Color(0xFF1C1C1C),
                                            fontFamily: 'HelveticaNeue',
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal,
                                            fontSize: _responsive.ip(2.7)
                                            ),//18),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ):Container( 
                                      child: Container(
                                      height: _responsive.ip(2.7),//18,
                                      width: _responsive.wp(70),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(8),
                                              topLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(8),
                                              topRight: Radius.circular(8)),
                                          color: Color(0xffE5E5E5),
                                        ),
                                      )),
                                    snapshot.hasData?Text(
                                      "N° doc. ${usuarioBloc.oUsuario.sNumeroDocumento}",//"${usuarioData['sNumeroDocumento']}",//'43326765',
                                      // textScaleFactor: 2,
                                      style: TextStyle(
                                          color: Color(0xFF94949A),
                                          fontFamily: 'HelveticaNeue',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500,
                                          fontSize: _responsive.ip(2.1)),//14),
                                     maxLines: 1,
                                    ):Container( 
                                      margin: EdgeInsets.only(top:5),
                                      child: 
                                        Container(
                                          height: _responsive.ip(2.7),//18,
                                          width: _responsive.wp(35),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(8),
                                                  topLeft: Radius.circular(8),
                                                  bottomRight: Radius.circular(8),
                                                  topRight: Radius.circular(8)),
                                              color: Color(0xffE5E5E5),
                                            ),
                                          )),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 1.0, // soften the shadow
                                      spreadRadius: 0.0, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        0.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                height: _responsive.ip(13.2)//88,
                              ),
                            ],
                          ),
                        ],
                      ),
                      snapshot.hasData?GestureDetector(
                          child: Center(
                            child: Container(
                            margin: EdgeInsets.only(top: 
                            _responsive.ip(12)// 80
                            ),
                            height: _responsive.ip(13.5),//90, 
                            width: _responsive.ip(13.5),//90, 
                            child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: 
                          _image==null?
                          usuarioBloc.oUsuario.sImagen==''
                          ?Image.asset('assets/home/iconProfile.png',
                           fit: BoxFit.fill,
                          ): CachedNetworkImage(
                                                      fit: BoxFit.cover,
                             imageUrl: usuarioBloc.oUsuario.sImagen.replaceAll('/bridge/', "${AppConfig.api_host_docService}"),
                           placeholder: (context, url) =>
                            Container(
                                                          decoration: new BoxDecoration(
                                                            image: DecorationImage(
                                                              image: new AssetImage(
                                                                  'assets/home/iconProfile.png'),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                        errorWidget: (context, url, error) =>  Container(
                                                          decoration: new BoxDecoration(
                                                    image: DecorationImage(
                                                      image: new AssetImage(
                                                          'assets/home/iconProfile.png'),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                  fadeInCurve: Curves.easeIn,
                                  fadeOutDuration: const Duration(seconds: 1),
                                  fadeInDuration: Duration(milliseconds: 1000)
                                )
                                :  Image.file(_image ,fit: BoxFit.fill, )
                          ),

                        ),
                          ),
                        onTap: (){
                          getImage(usuarioBloc);
                        },
                      ):Center(
                            child: Container(
                            margin: EdgeInsets.only(top: 
                            _responsive.ip(12)// 80
                            ),
                            // margin: EdgeInsets.only(top: _responsive.hp(12)),
                            height: _responsive.ip(13.5),//90,
                            width: _responsive.ip(13.5),//90,
                            child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                         child: 
                                      Image.asset('assets/home/iconProfile.png',
                                      fit: BoxFit.fill,
                                      ),
                      ),

                        ),
                          )
                    ],
                  )),

                ],
              ),
              Flexible(
                          child: GestureDetector(
                            onTap: (){
                              var parentContext = context;
                              Dialogs.succedDialog(context
                              ,title: "Aviso",
                              message: "Para actualizar sus datos, acérquese al concesionario de su preferencia.",
                              onOk: (){
                                Navigator.pop(parentContext);
                              });
                            },
                                                      child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     Container(
                        margin: EdgeInsets.only( 
                              left: 16,
                              right:16,
                               top: 16
                              ),
                        child: Text(
                            'Mi información',
                            // textScaleFactor: 1.8,
                            style: TextStyle(
                              fontFamily: "HelveticaNeue",
                              fontWeight: FontWeight.bold,
                              fontSize: _responsive.ip(2.7)//18
                              // fontSize: (_responsive.ip(3)),
                            ),
                        ),
                      ),
                      Container(
                            margin:
                                EdgeInsets.only(left: 16, top: 4.0),
                            child: Divider(
                              color: Color(0xFFC20A20),
                              endIndent: _responsive.wp(84.0),
                              height: _responsive.ip(1.05),//7.0,
                              thickness: 1,
                            )),
                    Container(
                        // padding: EdgeInsets.only(top:50.0),
                      child: Expanded(
                      child: SingleChildScrollView(
                            child: Column(
                        children: <Widget>[
                            SizedBox(height: 6.0,),
                            _txtTipoDocumento(snapshot,usuarioBloc),
                            _txtNumeroDocumento(snapshot,usuarioBloc),
                            _txtNombres(snapshot,usuarioBloc),
                            _txtApellidoPaterno(snapshot,usuarioBloc),
                            _txtApellidoMaterno(snapshot,usuarioBloc),
                            _txtCelular(snapshot,usuarioBloc),
                            _txtCorreoElectronico(snapshot,usuarioBloc),
                            _txtFechaNacimiento(snapshot,usuarioBloc),
                            // _txtEmpresarioPropietario(snapshot),
                            // _txtRUC(snapshot),
                            _txtCargo(snapshot,usuarioBloc),
                            SizedBox(height: 16.0,),
                        ],
                      )),
                    )),
                  ],
                ),
                          ),
              ),
            ],
          ))  ,_isFetching
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
                ))
              : Container()
            ],
          );
        }
      ),

      // bottomNavigationBar: _crearBootomNavigationbar()
    );
  }

  Widget _txtTipoDocumento(AsyncSnapshot snapshot,usuarioBloc) {
    return snapshot.hasData?TextMiPerfil(
        labelTextTitulo: 'Tipo de Documento', labelTextValue: "${usuarioBloc.oUsuario.sTipoDocumento}")
        :TextMiPerfilLoading();//'DNI');
  }

  Widget _txtNumeroDocumento(AsyncSnapshot snapshot,usuarioBloc) {
    return snapshot.hasData?TextMiPerfil(
        labelTextTitulo: 'Numero de Documento', labelTextValue: "${usuarioBloc.oUsuario.sNumeroDocumento}")
        :TextMiPerfilLoading();//'08765455');
  }

  Widget _txtNombres(AsyncSnapshot snapshot,usuarioBloc) {
    return snapshot.hasData?TextMiPerfil(
        labelTextTitulo: 'Nombres', labelTextValue: "${usuarioBloc.oUsuario.sNombres}")
        :TextMiPerfilLoading();//'Ever Joseph');
  }

  Widget _txtApellidoPaterno(AsyncSnapshot snapshot,usuarioBloc) {
    return snapshot.hasData?TextMiPerfil(
        labelTextTitulo: 'Apellido paterno', labelTextValue: "${usuarioBloc.oUsuario.sApellidoPaterno}")
        :TextMiPerfilLoading();//'Enciso');
  }

  Widget _txtApellidoMaterno(AsyncSnapshot snapshot,usuarioBloc) {
    return snapshot.hasData?TextMiPerfil(
        labelTextTitulo: 'Apellido materno', labelTextValue: "${usuarioBloc.oUsuario.sApellidoMaterno}")
        :TextMiPerfilLoading();//'Lopez');
  }

  Widget _txtCelular(AsyncSnapshot snapshot,usuarioBloc) {
    return snapshot.hasData?TextMiPerfil(
        labelTextTitulo: 'Número de celular', labelTextValue: "${usuarioBloc.oUsuario.sCelular}")
        :TextMiPerfilLoading();//'987-658-443');
  }

  Widget _txtCorreoElectronico(AsyncSnapshot snapshot,usuarioBloc) {
    return snapshot.hasData?TextMiPerfil(
        labelTextTitulo: 'Correo Electronico',
        labelTextValue: "${usuarioBloc.oUsuario.sCorreo}")
        :TextMiPerfilLoading();//'evertenciso@toyota.com.pe');
  }

  Widget _txtFechaNacimiento(AsyncSnapshot snapshot,usuarioBloc) {
    return snapshot.hasData?TextMiPerfil(
        labelTextTitulo: 'Fecha de nacimiento', 
        labelTextValue: formatFechaDD_MM_YYYY("${usuarioBloc.oUsuario.dFechaNacimiento}"))
        :TextMiPerfilLoading();//'12/07/1982');
  }

  // Widget _txtEmpresarioPropietario(AsyncSnapshot snapshot) {
  //   return snapshot.hasData?TextMiPerfil(
  //       labelTextTitulo: 'Empresario / Propietario',
  //       labelTextValue: 'Torino SAC')
  //       :TextMiPerfilLoading();
  // }

  // Widget _txtRUC(AsyncSnapshot snapshot) {
  //   return snapshot.hasData?TextMiPerfil(labelTextTitulo: 'RUC', labelTextValue: '200457698443')
  //   :TextMiPerfilLoading();
  // }

  Widget _txtCargo(AsyncSnapshot snapshot,usuarioBloc) {
    return snapshot.hasData?TextMiPerfil(labelTextTitulo: 'Cargo', labelTextValue: "${usuarioBloc.oUsuario.sTipoUsuario}")
    :TextMiPerfilLoading();
  }
}

