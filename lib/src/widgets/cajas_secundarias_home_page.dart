import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class CajaSecundariaHomePage extends StatefulWidget {
  final String valorSubtitulo;
  final String subtitulo;
  final Image image;
  final double alto;
  final double ancho;

  CajaSecundariaHomePage({
    Key key,
    @required this.valorSubtitulo,
    @required this.subtitulo,
    @required this.image, this.alto, this.ancho,
  }) : super(key: key);

  @override
  _CajaSecundariaHomePageState createState() => _CajaSecundariaHomePageState();
}

class _CajaSecundariaHomePageState extends State<CajaSecundariaHomePage> {
  @override
  Widget build(BuildContext context) {
    Responsive _responsive = new Responsive(context);
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20,top: 8),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  margin:
                      EdgeInsets.only(left: 14, top: 8, bottom: 8, right: 13.5),
                  width: widget.ancho,//30,//30,
                  height: widget.alto,//40,//40,
                  child: widget.image),
              Container(
                  child: Text(
                widget.valorSubtitulo, //"03",
                // style: AppConfig.styleValorTituloCajaSecundarias,
                style: TextStyle(
      color: Color(0xFF1C1C1C),
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontSize: _responsive.ip(2.4)),
              )),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    widget.subtitulo, //"Premios Canjeados",
                   style : TextStyle(
      color: Color(0xFF94949A),
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: _responsive.ip(1.8))
                    // style: AppConfig.styleTituloCajaSecundarias,
                  ))
            ],
          ),
          Container(
            width: 7.51,//40.3,
            height: 14,//70.5,
            margin: EdgeInsets.only(right: 10),
            child: Image.asset(
              'assets/home/angleRight.png',
              width: _responsive.ip(1.12),//7.51,
              height: _responsive.ip(2.1),//14,
            )
            // Icon(
            //   FontAwesomeIcons.angleRight,
            //   color: Color(0xFFE60012),
            //   size: 13.0,

            // ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [AppConfig.boxShadow],
      ),
      height: _responsive.ip(6.2)//40,
    );
  }
}
