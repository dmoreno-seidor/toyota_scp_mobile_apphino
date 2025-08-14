import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class ContainerNoticiasLoading extends StatefulWidget {
  const ContainerNoticiasLoading({Key key}) : super(key: key);

  @override
  _ContainerNoticiasLoadingState createState() =>
      _ContainerNoticiasLoadingState();
}

class _ContainerNoticiasLoadingState extends State<ContainerNoticiasLoading> {
  //  int id;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: _buildNoticiaList, //iterar
      itemCount: 2,
      shrinkWrap: true,
    );

    // final _size = MediaQuery.of(context).size;
    // final _responsive = Responsive(context);
  }

  Widget _buildNoticiaList(BuildContext context, int index) {
    Responsive _responsive = new Responsive(context);
    return Stack(
      children: <Widget>[
        Container(
          // margin: EdgeInsets.only(bottom: 20.0),
          margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
// margin: EdgeInsets.only(bottom: 20.0),
          width: MediaQuery.of(context).size.width,
          child: Stack(children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Image.asset('assets/campania/iconoCarga.gif'),
                ),
              ],
            ),
          ]),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
// color: Colors.white,
// boxShadow: [AppConfig.boxShadow],
          ),
        ),
      ],
    );
  }
}
