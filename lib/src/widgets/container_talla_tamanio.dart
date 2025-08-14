import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/catalogo_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class ContainerTallaTamanio extends StatefulWidget {
  final List aTallaTamanio;
  final CatalogoBloc catalogoBloc;

  const ContainerTallaTamanio({Key key, this.aTallaTamanio, this.catalogoBloc})
      : super(key: key);

  @override
  _ContainerTallaTamanio createState() => _ContainerTallaTamanio();
}

class _ContainerTallaTamanio extends State<ContainerTallaTamanio> {
  List<Map> listOfMa;
  bool isExpanded = false;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    Responsive _responsive = new Responsive(context);
    return Container(
      height: _responsive.ip(3.6), //24.0,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: _buildTallaTamanioList,
        itemCount: widget.aTallaTamanio.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildTallaTamanioList(
    BuildContext context,
    int index,
  ) {
    // final _responsive = Responsive(context);
    // bool buttonState = false;

    print(widget.aTallaTamanio[index]);

    return InkWell(
      splashColor: Colors.blueAccent,
      onTap: () async {
        setState(() {
          widget.aTallaTamanio
              .forEach((element) => element['seleccionado'] = false);
          widget.aTallaTamanio[index]['seleccionado'] = true;
        });
        List listCodigo = widget.catalogoBloc.sCodigoPremio.split(".");
        String ultimoCodigo = listCodigo[2][0] +
            listCodigo[2][1] +
            listCodigo[2][2] +
            listCodigo[2][3] +
            widget.aTallaTamanio[index]['codigo'];
        //  String ultimoCodigo = listCodigo[2][0] + listCodigo[2][1] + widget.aTallaTamanio[index]['codigo'] + listCodigo[2][4] + listCodigo[2][5];
        String codigo =
            listCodigo[0] + "." + listCodigo[1] + "." + ultimoCodigo;
        widget.catalogoBloc.changeCodigoPremio(codigo);
        widget.catalogoBloc.changeDescripcionAdicionalTalla(
            " talla " + widget.aTallaTamanio[index]["descripcion"]);
        _getLocation(widget.catalogoBloc);
      },
      child: RadioItem(item: widget.aTallaTamanio[index]),
    );
  }
}

_getLocation(catalogo) async {
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  final coordinates = new Coordinates(position.latitude, position.longitude);
  catalogo.consultarConcesionarioxPremio(
      catalogo.sCodigoPremio, coordinates.latitude, coordinates.longitude);
}

class RadioItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const RadioItem({Key key, this.item}) : super(key: key);
  // RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    Responsive _responsive = new Responsive(context);
    return new Container(
      // margin: EdgeInsets.only(right: 5),
      padding: EdgeInsets.only(right: 8),
      // margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: _responsive.ip(7.5), //50.0,
            padding: EdgeInsets.only(left: 7, right: 7),
            child: new Center(
              child: new Text(item['descripcion'], //_item.buttonText,
                  style: item['seleccionado']
                      ?
                      // AppConfig.styleTallaTamanioActivado
                      TextStyle(
                          fontStyle: FontStyle.normal,
                          fontFamily: "HelveticaNeue",
                          fontWeight: FontWeight.bold,
                          fontSize: _responsive.ip(1.9), //12 ,
                          color: Colors.white)
                      :
                      //  AppConfig.styleTallaTamanioDesactivado,
                      TextStyle(
                          fontStyle: FontStyle.normal,
                          fontFamily: "HelveticaNeue",
                          fontWeight: FontWeight.bold,
                          fontSize: _responsive.ip(1.8), //12
                        )),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(3),
                  topLeft: Radius.circular(3),
                  bottomRight: Radius.circular(3),
                  topRight: Radius.circular(3)),
              color: item['seleccionado'] ? Color(0xFFE60012) : Color(0xffFFFF),
              border: Border.all(
                color: Color(0xFFE60012), //                   <--- border color
                width: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  final Map talla;

  RadioModel(this.talla);
}
