import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/unidad_model.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class ExpansionTileMisVehiculos extends StatefulWidget {
  final List aUnidades;

  const ExpansionTileMisVehiculos({Key key, this.aUnidades}) : super(key: key);

  @override
  _ExpansionTileMisVehiculos createState() => _ExpansionTileMisVehiculos();
}

class _ExpansionTileMisVehiculos extends State<ExpansionTileMisVehiculos> {
  List<Map> listOfMa;
  bool isExpanded = false;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: _buildVehiculoList,
                  itemCount: widget.aUnidades.length,
                  shrinkWrap: true,

                );

    
  }

  //   Widget _buildList(BuildContext context, int index) {
  //   return ListTile(
  //     leading: Icon(icons[myList[index].toLowerCase()]),
  //     title: Text(myList[index]),
  //   );
  // }

  Widget _buildVehiculoList(
    BuildContext context,
    int index,
  ) {
    final _responsive = Responsive(context);
    //[{"3":"false"},{"10":"false"},{"11":"false"},{"14":"false"}];

    print(widget.aUnidades[index]['iId'].toString());

    return Container(
    
      margin: EdgeInsets.only(bottom: 8.0),
      width: MediaQuery.of(context).size.width,
      child: ExpansionTile(
        title: Container(
            height: _responsive.ip(7.5),//50,
          padding: EdgeInsets.only(
              left: _responsive.wp(1),
              right: _responsive.wp(1),
              top: 8.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Placa',
                  style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: _responsive.ip(1.8),//12.0,
                      color: Color(0xFFE60012))),
              // SizedBox(height: 3.5),
              Text(widget.aUnidades[index]['sPlaca'], //widget.textNombrePlaca,
                  style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: _responsive.ip(2.1),//14.0,
                      color: Color(0xFF1C1C1C))),
            ],
          ),
        ),
        trailing: Icon(
          widget.aUnidades[index]['isExpanded']
              ? Icons.keyboard_arrow_up
              : Icons.keyboard_arrow_down,
          color: Color(0xFFE60012),
          size: _responsive.ip(3.75),//25.0,
        ),

        // onExpansionChanged: ((newState){
        //       if(newState)
        //           setState(() {
        //             Duration(seconds:  20000);
        //             selected = index;
        //           });
        //           else setState(() {
        //             selected = -1;
        //           });
        //   }),

        onExpansionChanged: ((newState) {
          if (newState)
            setState(() {
              Duration(seconds: 20000);
              selected = index;
              widget.aUnidades[index]['isExpanded'] = newState;
              // print(newState);
            });
          else
            setState(() {
              widget.aUnidades[index]['isExpanded'] = newState;
              selected = index;
            });
        }),

        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(
                      left: 16, right: 16),
                  child: Divider(height: 5.0, thickness: 1.0)),
              Container(
                padding: EdgeInsets.only(
                    left: _responsive.wp(5),
                    right: _responsive.wp(5),
                    top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Modelo',
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(1.8),//12.0,
                                color: Color(0xFF94949A))),
                        SizedBox(height: 3.5),
                        widget.aUnidades[index]['sModelo'] == null || widget.aUnidades[index]['sModelo'] == '' ?
                        Text(
                             'Sin datos',
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(2.1),//14.0,
                                color: Color(0xFF000000)))
                                :Text(
                                 widget.aUnidades[index]['sModelo'],
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(2.1),//14.0,
                                color: Color(0xFF000000)))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('Año',
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(1.8),//12.0,
                                color: Color(0xFF94949A))),
                        SizedBox(height: 3.5),
                        widget.aUnidades[index]['sAnio'].toString() == '0'||widget.aUnidades[index]['sAnio'].toString() == '' ?
                        Text(
                            'Sin datos',
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(2.1),//14.0,
                                color: Color(0xFF000000)))
                        :Text(
                            widget.aUnidades[index]['sAnio'].toString(),
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(2.1),//14.0,
                                color: Color(0xFF000000)))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: _responsive.wp(5),
                    right: _responsive.wp(5),
                    top: 12.0,
                    bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Carroceria',
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(1.8),//12.0,
                                color: Color(0xFF94949A))),
                        SizedBox(
                          height: 3.5,
                        ),
                        widget.aUnidades[index]['sTipoCarroceria'] == null|| widget.aUnidades[index]['sTipoCarroceria'] == '' ?
                        Text(
                               'Sin datos',
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(2.1),//14.0,
                                color: Color(0xFF000000)))
                        :Text(
                            widget.aUnidades[index]['sTipoCarroceria'],
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(2.1),//14.0,
                                color: Color(0xFF000000)))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('Material',
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(1.8),//12.0,
                                color: Color(0xFF94949A))),
                        SizedBox(height: 3.5),
                        widget.aUnidades[index]['sMaterialCarroceria']== null ||widget.aUnidades[index]['sMaterialCarroceria']== ''?
                        Text(
                             'Sin datos',
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(2.1),//14.0,
                                color: Color(0xFF000000)))
                        :Text(
                            widget.aUnidades[index]['sMaterialCarroceria'],
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(2.1),//14.0,
                                color: Color(0xFF000000)))
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [AppConfig.boxShadow],
      ),
    );
  }
}
