import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/models/mis_servicios_model.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/formatters.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class ContainerMisServicios extends StatefulWidget {
  // final String textDia;
  // final String textMes;
  // final String textTipoServicios;
  final MisServiciosModel aMisServicios;
  

  ContainerMisServicios({
    Key key, this.aMisServicios,
  }) : super(key: key);

  @override
  _ContainerMisServicios createState() => _ContainerMisServicios();
}

class _ContainerMisServicios extends State<ContainerMisServicios> {

  List<Map> listOfMa;
  bool isExpanded = false;
  int selected = 0;

  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: _buildMisServiciosList,
      itemCount: widget.aMisServicios.servicios.length,
      shrinkWrap: true,
    );
  }


  Widget _buildMisServiciosList(
    BuildContext context,
    int index,
  ) {
    final _responsive = Responsive(context);
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      // width: MediaQuery.of(context).size.width,
      
      child: ExpansionTile(
        title: Container(
         height: _responsive.ip(8),//50,
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        formatObtenerDia(widget.aMisServicios.servicios[index].fecha),
                        style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(2.4),//16.0,
                                color: Color(0xFF000000))),
                      Text(
                        formatObtenerNombreMes(widget.aMisServicios.servicios[index].fecha),
                        style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(1.8),//12.0,
                                color: Color(0xFFE60012)))
                    ],
                  ),
                  ),
                   Container(
                        margin: EdgeInsets.only(left: 1.5),
                                      height: _responsive.ip(7.0),//36,
                                      child: VerticalDivider(
                                        thickness: 1,
                                          
                                    )),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Tipo de Servicio',
                            style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.w500,
                                fontSize: _responsive.ip(1.8),//12.0,
                                color: Color(0xFF94949A))),
                        SizedBox(height: 3.5),
                       
                       
                        widget.aMisServicios.servicios[index].descrip == null ||widget.aMisServicios.servicios[index].descrip == '' ?


                        Text(
                          'Sin datos',
                          maxLines: 1,//widget.textPremio,
                        overflow: TextOverflow.ellipsis,
                             style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(2.1),//14.0,
                                color: Color(0xFF000000))
                                
                                )
                        :
                        (
                        widget.aMisServicios.servicios[index].isExpanded?
                        
                        Text(
                          widget.aMisServicios.servicios[index].descrip,
                          maxLines: 2,
                             style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(2.1),//14.0,
                                color: Color(0xFF000000))
                                
                                ):
                                Text(
                          widget.aMisServicios.servicios[index].descrip,
                          maxLines: 1,//widget.textPremio,
                        overflow: TextOverflow.ellipsis,
                             style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.bold,
                                fontSize: _responsive.ip(2.1),//14.0,
                                color: Color(0xFF000000)))

                                )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        trailing: Container(
          child: Icon(
            widget.aMisServicios.servicios[index].isExpanded
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
            color: Color(0xFFE60012),
            size: _responsive.ip(3.75)//25.0,
          ),
        ),
        onExpansionChanged: ((newState) {
          if (newState)
            setState(() {
              Duration(seconds: 20000);
              selected = index;
              widget.aMisServicios.servicios[index].isExpanded = newState;
              // print(newState);
            });
          else
            setState(() {
              widget.aMisServicios.servicios[index].isExpanded = newState;
              selected = index;
            });
        }),
        children: <Widget>[

          Container(
            padding: EdgeInsets.only(left: _responsive.wp(10)),
            child:
          Row(
            children: <Widget>[
              Container(
                    padding: EdgeInsets.only(left: _responsive.wp(3), ),
                    height: _responsive.ip(18),//120,
                    child: VerticalDivider(
                        //color: Colors.pinkAccent
                        )),
              
              Flexible(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only( bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              Text('Concesionario',
                                    style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        fontWeight: FontWeight.w500,
                                        fontSize: _responsive.ip(1.8),//12.0,
                                        color: Color(0xFF94949A))),
                              
                              Text(
                                (widget.aMisServicios.servicios[index].concesionario == null || widget.aMisServicios.servicios[index].concesionario == '')
                                  ? Text("Sin datos", style:TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        fontWeight: FontWeight.bold,
                                        fontSize: _responsive.ip(2.1),//14.0,
                                        color: Color(0xFF000000)),)
                                  :  widget.aMisServicios.servicios[index].concesionario,
                                  style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
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
                            //top: 12.0,
                            bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              Text('Asesor',
                                  style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w500,
                                        fontSize: _responsive.ip(1.8),//12.0,
                                        color: Color(0xFF94949A))),
                              widget.aMisServicios.servicios[index].asesor== null ||widget.aMisServicios.servicios[index].asesor== ''  ?
                              Text(
                                'Sin datos',
                                  style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: _responsive.ip(2.1),//14.0,
                                        color: Color(0xFF000000)))
                              :Text(
                                widget.aMisServicios.servicios[index].asesor,
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
                            //top: 12.0,
                            bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              Text('Placa',
                                  style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w500,
                                        fontSize: _responsive.ip(1.8),//12.0,
                                        color: Color(0xFF94949A))),
                              SizedBox(
                                height: 3.5,
                              ),
                              Text(
                                (widget.aMisServicios.servicios[index].placa == null ||widget.aMisServicios.servicios[index].placa =='')
                                ? Text("Sin datos" , style:  TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: _responsive.ip(2.1),//14.0,
                                        color: Color(0xFF000000)),)
                                :widget.aMisServicios.servicios[index].placa,
                                  style : TextStyle(
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
                    SizedBox(height: 5.0,)
                  ],
                ),
              ),
            ],
          ),
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


  //bool isExpanded = false,

}
