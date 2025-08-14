import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class CajaSecundariaLoadingHomePage extends StatefulWidget {
  // final String valorSubtitulo;
  // final String subtitulo;
  final Icon icon;

  CajaSecundariaLoadingHomePage({
    Key key,
    // @required this.valorSubtitulo,
    // @required this.subtitulo,
    @required this.icon,
  }) : super(key: key);

  @override
  _CajaSecundariaLoadingHomePageState createState() =>
      _CajaSecundariaLoadingHomePageState();
}

class _CajaSecundariaLoadingHomePageState
    extends State<CajaSecundariaLoadingHomePage> {
  @override
  Widget build(BuildContext context) {
    Responsive _responsive = new Responsive(context);
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 22),
                    width: _responsive.ip(4.24),//28.3,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffE5E5E5),
                      ),
                    )),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(
                          left: 10, top: 13, bottom: 13, right: 24),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          color: Color(0xffE5E5E5),
                        ),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [AppConfig.boxShadow],
      ),
      height: _responsive.ip(6),//40,
    );
  }
}
