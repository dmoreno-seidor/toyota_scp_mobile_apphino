import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/formatters.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class ContainerEventosLoading extends StatefulWidget {
 

  const ContainerEventosLoading({Key key}) : super(key: key);
  @override
  _ContainerEventosLoadingState createState() =>
      _ContainerEventosLoadingState();
}

class _ContainerEventosLoadingState extends State<ContainerEventosLoading> {
  //  int id;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: _buildEventoList, //iterar
      itemCount: 2,
      shrinkWrap: true,
    );
  }

  Widget _buildEventoList(BuildContext context, int index) {
  
    Responsive _responsive = new Responsive(context);
    return Container(
      margin:EdgeInsets.only(left:16.0, right: 16.0, bottom: 16.0),
      child: Stack(children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/campania/iconoCarga.gif'),
                  ),
                ],
              ),
            ]),
    );

  }
}
