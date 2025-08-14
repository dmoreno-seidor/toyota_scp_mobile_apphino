import 'dart:convert';
import 'dart:io';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:apple_sign_in/apple_sign_in_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:toyota_scp_mobile_apphino/src/comportamiento_usuario/comportamiento_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/models/usuario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/Provider.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/login_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/usuario_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/usuario_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/input_text_login.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = "login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  final prefs = new PreferenciasUsuario();
  UsuarioBloc usuarioBloc = new UsuarioBloc();
  LoginBloc bloc = new LoginBloc();
  bool isLoggedIn = false;
  var _isFetching = false;
  bool passwordVisible = false;
  // static final FacebookLogin facebookSignIn = new FacebookLogin();

  ///Linea agregada
  void initiateFacebookLogin() async {
    final FacebookLogin facebookSignIn = FacebookLogin();
    if (Platform.isAndroid) {
      facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;
    }
    final result = await facebookSignIn.logIn(['email']);

    ///Linea agregada
    switch (result.status) {
      case FacebookLoginStatus.error:
        print("Surgio un error");
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelado por el usuario");
        break;
      case FacebookLoginStatus.loggedIn:
        onLoginStatusChange(true);
        getUserInfo(result);
        break;
    }
  }

  void getUserInfo(FacebookLoginResult result) async {
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
    final profile = json.decode(graphResponse.body);

    String sCorreo = profile["email"];
    if (sCorreo != "") {
      setState(() {
        _isFetching = true;
      });

      Map infoUsuario =
          await usuarioProvider.consultarDatosClientexCorreo(context, sCorreo);

      if (infoUsuario["oResults"].length > 0) {
        setState(() {
          _isFetching = false;
        });
        int iId = infoUsuario["oResults"][0]["iId"];
        await usuarioProvider.actualizarTokenFirebase(
            context, iId, prefs.token);
        //Servicio Actualizar
        prefs.iId = iId;
        prefs.sCorreo = sCorreo;
        prefs.ultimaPagina = 'dashboard';
        Navigator.pushNamedAndRemoveUntil(context, 'dashboard', (_) => false);
        // Dialogs.terminosCondicionesDialog(context, title: "Excelente",
        //           onOk: () async {
        //         Navigator.pop(context);
        //         prefs.iId = iId;
        //         prefs.sCorreo = sCorreo;
        //       prefs.ultimaPagina = 'dashboard';
        //       setState(() {
        //         _isFetching = false;
        //       });
        //       Navigator.pushNamedAndRemoveUntil(
        //           context, 'dashboard', (_) => false);
        //       });
      } else {
        UsuarioModel usuarioModel = new UsuarioModel();
        usuarioModel.sCorreo = profile["email"];
        usuarioModel.sNombres = profile["first_name"];
        usuarioModel.sApellidoPaterno = profile["last_name"];
        usuarioModel.bAutorizacionDatosPersonales = true;
        usuarioModel.bTerminoCondiciones = true;
        usuarioModel.idTipoDocumento = 103;
        Map<String, dynamic> usuario = usuarioModel.toJson();
        bool isValid =
            await usuarioProvider.registrarUsuarioMovil(context, usuario);
        if (isValid) {
          Map infoUsuario = await usuarioProvider.consultarDatosClientexCorreo(
              context, sCorreo);

          int iId = infoUsuario["oResults"][0]["iId"];

          if (iId != null) {
            bool actualizarToken = await usuarioProvider
                .actualizarTokenFirebase(context, iId, prefs.token);

            if (actualizarToken) {
              setState(() {
                _isFetching = false;
              });
              Dialogs.terminosCondicionesDialog(context, title: "Excelente",
                  onOk: () async {
                Navigator.pop(context);
                prefs.iId = iId;
                prefs.sCorreo = sCorreo;
                prefs.ultimaPagina = 'dashboard';
                setState(() {
                  _isFetching = false;
                });
                Navigator.pushNamedAndRemoveUntil(
                    context, 'dashboard', (_) => false);
              });
            } else {
              setState(() {
                _isFetching = false;
              });
            }
          }
          setState(() {
            _isFetching = false;
          });
        } else {
          setState(() {
            _isFetching = false;
          });
        }
      }
    }
  }

  void onLoginStatusChange(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  final usuarioProvider = new UsuarioProvider();

  @override
  void initState() {
    super.initState();
    usuarioBloc = UsuarioBloc();
    WidgetsBinding.instance.addObserver(this);
    // facebookSignIn.logOut();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    usuarioBloc.dispose();
    bloc.dispose();
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
    Responsive responsive = new Responsive(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            children: <Widget>[
              _crearFondo(context),
              SafeArea(child: _loginForm(context)),
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
                                  size: responsive.ip(5.25), //35,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: index.isEven
                                            ? Colors.red
                                            : Colors.red,
                                      ),
                                    );
                                  }),
                              Text(
                                "Validando Credenciales...",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "HelveticaNeue",
                                    fontSize: responsive.ip(2.4)),
                                // style: AppConfig.styleTextCargado,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                  : Container()
            ],
          ),
        ));
  }

  Widget _loginForm(BuildContext context) {
    // final bloc = Provider.of(context);
    final blocUsuario = Provider.usuarioBloc(context);
    // final size = MediaQuery.of(context).size;
    final responsive = Responsive(context);
    return
        // SingleChildScrollView(
        // child:

        Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Padding(
            //   padding: EdgeInsets.only(
            //       top: responsive.hp(9), bottom: responsive.hp(9)),
            //   child:
            Container(
              // margin: EdgeInsets.only(top: responsive.ip(3.3),bottom: responsive.ip(6.6),
              margin: EdgeInsets.only(
                top: responsive.ip(3.3),
                bottom: responsive.ip(6.3),
              ),
              height: responsive.ip(13), //responsive.wp(30),
              width: responsive.ip(14.0), //responsive.wp(35),
              decoration: new BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage('assets/login/logoHino.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: <Widget>[
                  _crearEmail(bloc, context), ////---REVERTIR
                  SizedBox(height: 0.0), ////---REVERTIR
                  _crearPassword(bloc, context), ////---REVERTIR
                  SizedBox(height: 15), ////---REVERTIR
                  _crearBoton(bloc, context, usuarioBloc),
                  SizedBox(height: 7.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        child: Container(
                          height: 1,
                          width: responsive.ip(6.75), //45.0,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      Text("O",
                          style: TextStyle(
                              fontSize: responsive.ip(1.5),
                              color: Colors.white)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: responsive.ip(0.9)),
                        child: Container(
                          height: 1,
                          width: responsive.ip(6.75),
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),

                  Platform.isIOS
                      ? Column(
                          children: <Widget>[
                            SizedBox(height: 7.0),
                            _crearBotonSignInWithAppleId(
                                bloc, context, usuarioBloc)
                          ],
                        )
                      : Container(),
                  SizedBox(height: 7.0),
                  _crearBotonFb(bloc, context),

                  ////---REVERTIR
                  SizedBox(height: 19.0),
                  Text(
                    "¿Eres nuevo por aquí?",
                    style: TextStyle(
                        fontFamily: "HelveticaNeue",
                        fontSize: responsive.ip(1.8),
                        color: Colors.white),
                  ),
                  SizedBox(height: 8.0),
                  InkWell(
                    child: Text("Registrate aquí",
                        style: TextStyle(
                            fontFamily: "HelveticaNeue",
                            fontSize: responsive.ip(1.8),
                            color: Colors.white)),
                    onTap: () {
                      Navigator.pushNamed(context, 'crearCuenta');
                    },
                  ),
                  ////---REVERTIR
                ],
              ),
            ),

            SizedBox(height: 10.0),
          ],
          // ),
        ),

        ////---REVERTIR
        Column(
          children: <Widget>[
            FlatButton(
              child: Text("¿Haz olvidado tu contraseña?",
                  style: TextStyle(
                      fontFamily: "HelveticaNeue",
                      fontSize: responsive.ip(1.8),
                      color: Colors.white)),
              onPressed: () {
                Navigator.pushNamed(context, 'recuperarContrasena');
              },
            ),
          ],
        )
        ////---REVERTIR
      ],
    );
  }

  Widget _crearEmail(LoginBloc bloc, BuildContext parentContext) {
    final responsive = Responsive(context);
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          // padding: EdgeInsets.symmetric(horizontal: responsive.wp(9)),
          // height: 50,
          width: responsive.ip(34.5),
          child: InputTextLogin(
            context: parentContext,
            labelText: 'Correo electrónico',
            // counterText: snapshot.data,
            errorText: snapshot.error,
            hintText: "ejemplo@correo.com",
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc, BuildContext parentContext) {
    final responsive = Responsive(context);
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          // padding: EdgeInsets.symmetric(horizontal: responsive.wp(9)),
          // height: 50,
          width: responsive.ip(34.5),
          child: InputTextLogin(
            context: parentContext,
            labelText: 'Contraseña',
            obscureText: !passwordVisible,
            // counterText: snapshot.data,
            errorText: snapshot.error,
            keyboardType: TextInputType.text,
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Color(0xFF94949A),
              ),
              onPressed: (() {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              }),
            ),
            onChanged: (value) => bloc.changePassword(value),
          ),
        );
      },
    );
  }

  Widget _crearBoton(
      LoginBloc bloc, BuildContext context, UsuarioBloc blocUsuario) {
    final responsive = Responsive(context);
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          width: responsive.ip(34.5), //230,
          height: responsive.ip(6), //40,
          child: RaisedButton(
            child: Container(
              // child: GestureDetector(
              // onTap: () =>
              // ,//Navigator.pushNamed(context, 'dashboard'),
              child: Text("Iniciar sesión",
                  style: TextStyle(
                      fontSize: responsive.ip(2.4), //16.0,
                      color: Colors.white,
                      fontFamily: 'HelveticaNeue')),
              // ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0)),
            elevation: 0.0,
            color: Color(0xffE60012),
            textColor: Colors.white,
            onPressed: () => _login(context, bloc, blocUsuario),
          ),
        );
      },
    );
  }

  Widget _crearBotonVisitanos(LoginBloc bloc, BuildContext context) {
    final responsive = Responsive(context);
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          width: responsive.ip(34.5), //230,
          height: responsive.ip(6), //40,
          margin: EdgeInsets.only(top: responsive.ip(9.5)),
          child: RaisedButton(
            child: Container(
              // child: GestureDetector(
              // onTap: () =>
              // ,//Navigator.pushNamed(context, 'dashboard'),
              child: Text("Visitanos",
                  style: TextStyle(
                      fontSize: responsive.ip(2.4), //16.0,
                      color: Colors.white,
                      fontFamily: 'HelveticaNeue')),
              // ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0)),
            elevation: 0.0,
            color: Color(0xffE60012),
            textColor: Colors.white,
            onPressed: () async {
              const url = 'http://hinoperu.com.pe';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        );
      },
    );
  }

  Widget _crearBotonFb(LoginBloc bloc, BuildContext context) {
    final responsive = Responsive(context);
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Stack(children: <Widget>[
          Container(
            width: responsive.ip(34.5), //230,
            height: responsive.ip(6),
            child: RaisedButton(
                child: Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Text("Entrar con Facebook",
                      style: TextStyle(
                          fontSize: responsive.ip(1.8),
                          fontFamily: 'HelveticaNeue',
                          color: Colors.white)),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
                elevation: 0.0,
                color: Color(0xff3B5999),
                textColor: Colors.white,
                onPressed: () =>
                    initiateFacebookLogin() //_login(bloc, context),
                ),
          ),
          Container(
            // margin:EdgeInsets.only(left: 39, top: 12, bottom: 10),
            margin: EdgeInsets.only(
                left: responsive.ip(5.85),
                top: responsive.ip(1.8),
                bottom: responsive.ip(1.5)),
            height: responsive.ip(2.4), //responsive.wp(6), //30,
            width: responsive.ip(2.4), //responsive.wp(7), //30,
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('assets/login/logoFacebook.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ]);
      },
    );
  }

  _login(BuildContext context, LoginBloc bloc, UsuarioBloc blocUsuario) async {
    setState(() {
      _isFetching = true;
    });

    Map responseUsuarioAutenticacion = await usuarioProvider
        .usuarioAutenticacion(context, bloc.email, bloc.password);
    if (responseUsuarioAutenticacion == null) {
      setState(() {
        _isFetching = false;
      });
    } else {
      if (responseUsuarioAutenticacion["oAuditResponse"]["iCode"] == 1) {
        var sCorreo = responseUsuarioAutenticacion["oResults"]["mail"];
        Map infoUsuario = await usuarioProvider.consultarDatosClientexCorreo(
            context, sCorreo);
        int iId = infoUsuario["oResults"][0]["iId"];
        if (iId != null) {
          bool actualizarToken = await usuarioProvider.actualizarTokenFirebase(
              context, iId, prefs.token);

          if (actualizarToken) {
            setState(() {
              _isFetching = false;
            });
            prefs.iId = iId;
            blocUsuario.consultarDataCliente2(iId);
            prefs.sCorreo = sCorreo;
            prefs.ultimaPagina = 'dashboard';
            Navigator.pushNamedAndRemoveUntil(
                context, 'dashboard', (_) => false);
          } else {
            setState(() {
              _isFetching = false;
            });
          }
        }
        setState(() {
          _isFetching = false;
        });
      } else {
        setState(() {
          _isFetching = false;
        });
      }
    }
  }

  Widget _crearFondo(context) {
    // final size = MediaQuery.of(context).size;
    // final responsive = Responsive(context);

    final fondoImagen = Container(
// height: size.height,
// width: size.width,
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: new AssetImage('assets/login/wallpaperLogin.png'),
          fit: BoxFit.cover,
        ),
      ),
    );

    final fondoNegro = Container(
// height: size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
            Colors.black,
//Color.fromRGBO(0, 0, 0, 26),
//Colors.transparent
            Color.fromRGBO(0, 0, 0, 0.2)
          ])),
    );

    return Positioned(
      child: Stack(
        children: <Widget>[
          fondoImagen,
          fondoNegro,
        ],
      ),
    );
  }

  initiateSignInWithApple() async {
    try {
      final AuthorizationResult result = await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      switch (result.status) {
        case AuthorizationStatus.authorized:
          try {
            print("successfull sign in");
            final AppleIdCredential appleIdCredential = result.credential;
            //var sCorreo = "guillermo.narvaez.21.95@gmail.com";
            String sAppleId = result.credential.user;
            //"guillermo.narvaez.21.95@gmail.com"; //
            if (sAppleId != "" && sAppleId != null) {
              setState(() {
                _isFetching = true;
              });

              //  Map infoUsuario = await usuarioProvider
              //      .consultarDatosClientexCorreo(context, sCorreo);

              Map infoUsuario = await usuarioProvider
                  .consultarDatosUsuarioAppleId(context, sAppleId);

              if (infoUsuario["oResults"].length > 0) {
                int iId = infoUsuario["oResults"][0]["iId"];
                await usuarioProvider.actualizarTokenFirebase(
                    context, iId, prefs.token);
                //Servicio Actualizar
                setState(() {
                  _isFetching = false;
                });
                prefs.iId = iId;
                prefs.sCorreo = infoUsuario["oResults"][0][
                    "sCorreo"]; //"guillermo.narvaez.21.95@gmail.com"; //sCorreo;
                prefs.ultimaPagina = 'dashboard';
                Navigator.pushNamedAndRemoveUntil(
                    context, 'dashboard', (_) => false);
                // Dialogs.terminosCondicionesDialog(context, title: "Excelente",
                //           onOk: () async {
                //         Navigator.pop(context);
                //         prefs.iId = iId;
                //         prefs.sCorreo = sCorreo;
                //       prefs.ultimaPagina = 'dashboard';
                //       setState(() {
                //         _isFetching = false;
                //       });
                //       Navigator.pushNamedAndRemoveUntil(
                //           context, 'dashboard', (_) => false);
                //       });
              } else {
                UsuarioModel usuarioModel = new UsuarioModel();
                usuarioModel.sCorreo = result.credential
                    .email; //"guillermo.narvaez.21.95@gmail.com"//profile["email"];
                usuarioModel.sNombres = result
                    .credential.fullName.givenName; //profile["first_name"];
                usuarioModel.sApellidoPaterno = ""; //profile["last_name"];
                usuarioModel.bAutorizacionDatosPersonales = true;
                usuarioModel.bTerminoCondiciones = true;
                usuarioModel.idTipoDocumento = 103;
                usuarioModel.sAppleId = result.credential.user;
                Map<String, dynamic> usuario = usuarioModel.toJson();
                bool isValid = await usuarioProvider.registrarUsuarioMovil(
                    context, usuario);
                if (isValid) {
                  Map infoUsuario = await usuarioProvider
                      .consultarDatosUsuarioAppleId(context, sAppleId);

                  int iId = infoUsuario["oResults"][0]["iId"];

                  if (iId != null) {
                    bool actualizarToken = await usuarioProvider
                        .actualizarTokenFirebase(context, iId, prefs.token);

                    if (actualizarToken) {
                      setState(() {
                        _isFetching = false;
                      });
                      Dialogs.terminosCondicionesDialog(context,
                          title: "Excelente", onOk: () async {
                        Navigator.pop(context);
                        prefs.iId = iId;
                        prefs.sCorreo = infoUsuario["oResults"][0]["sCorreo"];
                        prefs.ultimaPagina = 'dashboard';
                        setState(() {
                          _isFetching = false;
                        });
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'dashboard', (_) => false);
                      });
                    } else {
                      setState(() {
                        _isFetching = false;
                      });
                    }
                  }
                  setState(() {
                    _isFetching = false;
                  });
                } else {
                  setState(() {
                    _isFetching = false;
                  });
                }
              }
            }
          } catch (e) {
            print("error");
          }
          break;
        case AuthorizationStatus.error:
// do something
          break;

        case AuthorizationStatus.cancelled:
          print('User cancelled');
          break;
      }
    } catch (error) {
      print("error with apple sign in");
    }
  }

  Widget _crearBotonSignInWithAppleId(
      LoginBloc bloc, BuildContext context, UsuarioBloc blocUsuario) {
    final responsive = Responsive(context);
    return Container(
      width: responsive.ip(34.5), //230,
      height: responsive.ip(6),
      child: AppleSignInButton(
        cornerRadius: 100,
        style: ButtonStyle.black,
        //type: ButtonType.continueButton,
        onPressed: () {
          initiateSignInWithApple();
        },
      ),
    );
  }
}
