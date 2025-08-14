import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);
    static final String routeName = "splash";
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
   final prefs = new PreferenciasUsuario();
  @override
  void initState() {
    super.initState();
    this.check();
  }

  check() {
    // final token = false;
    
    // if (prefs.iId!=null) {
        // Navigator.pushReplacementNamed(context, "login");
    // } else {
      if(prefs.ocultarOnBoardingScreen == "1"){
        var timer = Timer(Duration(seconds: 4), () {
             Navigator.pushReplacementNamed(context, "login");
        });
         
      }else{
        var timer = Timer(Duration(seconds: 4), () {
          Navigator.pushReplacementNamed(context, "onBoardingScreen");
        });
      }

      
      
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondoRojo(context),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _crearImagenLogo(context),
            _crearPiePagina(context)
          ],
        )
      ],
    ));
  }

  Widget _crearFondoRojo(context) {
    // final size = MediaQuery.of(context).size;
    return Container(
      // height: size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Color(0xffE60012), Color(0xffE60012)])),
    );
  }

  Widget _crearImagenLogo(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final responsive = Responsive(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: responsive.hp(25)),
          height: responsive.wp(40), //size.height * 0.30
          width: responsive.wp(42), //size.width * 0.60,
          decoration: new BoxDecoration(
            image: DecorationImage(
              image: new AssetImage('assets/splash/logoHino3d.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearPiePagina(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text("DESARROLLADO POR",
              style: TextStyle(fontSize: 14.0, color: Colors.white)),
          SizedBox(height: 5.0),
          Text("TOYOTA DEL PERU S.A",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
