import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:toyota_scp_mobile_apphino/src/estilos.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/talla_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/unidad_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/catalogo_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
// import '../app_config.dart';

class ContainerColor extends StatefulWidget {
  final List aColor;
   final CatalogoBloc catalogoBloc; 

  const ContainerColor({Key key, this.aColor, this.catalogoBloc}) : super(key: key);

  @override
  _ContainerColor createState() => _ContainerColor();
}

class _ContainerColor extends State<ContainerColor> {
  List<Map> listOfMa;
  bool isExpanded = false;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    Responsive _responsive = new Responsive(context);
    return Container(
      height: _responsive.ip(3.9),//26.0,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: _buildColorList,
        itemCount: widget.aColor.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildColorList(
    BuildContext context,
    int index,
  ) {
    // final _responsive = Responsive(context);
    // bool buttonState = false;

    print(widget.aColor[index]);

    return InkWell(
      splashColor: Colors.blueAccent,
      onTap: () {
        setState(() {
          widget.aColor.forEach((element) => element['seleccionado'] = false);
          widget.aColor[index]['seleccionado'] = true;
        });
        List listCodigo = widget.catalogoBloc.sCodigoPremio.split(".");
              String ultimoCodigo = listCodigo[2][0] + listCodigo[2][1] + widget.aColor[index]['codigo'] + listCodigo[2][4] + listCodigo[2][5];
              //  String ultimoCodigo = listCodigo[2][0] + listCodigo[2][1] + widget.aColor[index]['codigo'] + listCodigo[2][4] + listCodigo[2][5];//listCodigo[2][2];
               String codigo = listCodigo[0] +"."+ listCodigo[1] + "."+ultimoCodigo;
              widget.catalogoBloc.changeCodigoPremio(codigo);
              widget.catalogoBloc.changeDescripcionAdicionalColor(" color "+widget.aColor[index]["descripcion"]);
              _getLocation(widget.catalogoBloc);
      },
      child: RadioItem(item: widget.aColor[index]),
    );
  }
}
_getLocation(catalogo) async{
            Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
              final coordinates = new Coordinates(position.latitude, position.longitude);
                 catalogo.consultarConcesionarioxPremio(catalogo.sCodigoPremio, coordinates.latitude, coordinates.longitude);
}



class RadioItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const RadioItem({Key key, this.item}) : super(key: key);
  // RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
     Responsive _responsive = new Responsive(context);
    return Row(
      children: <Widget>[
        Container(
          child: item['seleccionado']
              ? 
              (item["codehex"]=="FFFFFF"?
              Container(
                  child: Icon(
                    Icons.check,
                    color: Colors.black,
                    size: _responsive.ip(2.7),//18,
                  ),
                ):Container(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: _responsive.ip(2.7),//18,
                  ),
                )  )
              : Container(),
          height: _responsive.ip(3.6),//24,
          width: _responsive.ip(3.6),//24,
          
          decoration: BoxDecoration(
             border: Border.all(
              color: item['codehex']=="FFFFFF"?Colors.black
              :Color(int.parse("#${item['codehex']}"
                        .replaceAll('#', '0xff'))),
              width: 1,
            ),
            shape: BoxShape.circle,
            color: Color(int.parse("#${item['codehex']}"
                .replaceAll('#', '0xff'))), //Color(0xFF1C1C1C),
          ),
        ),
        SizedBox(
          width: 8,
        ),
      ],
    );

    //  Container(
    //   // margin: EdgeInsets.only(right: 5),
    //     padding: EdgeInsets.only(right: 8),
    //   // margin: new EdgeInsets.all(15.0),
    //   child: new Row(
    //     mainAxisSize: MainAxisSize.max,
    //     children: <Widget>[
    //       new Container(
    //         height: 50.0,
    //         width: 35.0,
    //         child: new Center(
    //           child: new Text(  item['descripcion'] ,//_item.buttonText,
    //               style: item['seleccionado']  ?TextStyle( fontWeight: FontWeight.w500, fontSize: 12 , color: Colors.white)
    //        :TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
    //                   ),
    //         ),
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.only(
    //           bottomLeft: Radius.circular(7),
    //           topLeft: Radius.circular(7),
    //           bottomRight: Radius.circular(7),
    //           topRight: Radius.circular(7)),
    //           color:  item['seleccionado']?Color(0xFFE60012):Color(0xffFFFF),
    //                     border: Border.all(
    //         color: Color(0xFFE60012), //                   <--- border color
    //         width: 1.2,
    //       ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class RadioModel {
  final Map talla;

  RadioModel(this.talla);
}
