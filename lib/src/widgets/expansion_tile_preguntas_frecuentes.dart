import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

import '../app_config.dart';

class ExpansionTilePreguntasFrecuentes extends StatefulWidget {
  final List preguntasFrecuentes;
  // final String textNombrePregunta;
  // final String textDetallePregunta;

  const ExpansionTilePreguntasFrecuentes({Key key, this.preguntasFrecuentes}) : super(key: key);
  


  @override
  _ExpansionTilePreguntasFrecuentes createState() => _ExpansionTilePreguntasFrecuentes();
}

class _ExpansionTilePreguntasFrecuentes extends State<ExpansionTilePreguntasFrecuentes> {
bool isExpanded = false;
  int selected = 0;
  @override
  Widget build(BuildContext context) {

    // final _responsive = Responsive(context);
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: _buildPreguntasFrecuentesList,
      itemCount: widget.preguntasFrecuentes.length,
      shrinkWrap: true,
    );
  }

  Widget _buildPreguntasFrecuentesList(BuildContext context, int index){
    final _responsive = Responsive(context);
    print(widget.preguntasFrecuentes[index].iId);

    return Container(
              margin: EdgeInsets.only( bottom: 8.0),
              width: MediaQuery.of(context).size.width,
              // height: 45,
              child: ExpansionTile(
                title: Container(
                  // height: 50,
                  // height: _responsive.ip(8),
                  padding: EdgeInsets.only( top: _responsive.ip(0.2),bottom: _responsive.ip(0.2)),
                  child: Text(widget.preguntasFrecuentes[index].sNombre,
                  maxLines: 2,
                        style: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: _responsive.ip(1.8),//12.0,
                          color: Color(0xFF1C1C1C)
                        )
                        
                        )
                ),
                trailing:  Icon(
                    widget.preguntasFrecuentes[index].isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Color(0xFFE60012),
                    size: _responsive.ip(3.75),//25.0,
                  ),
                onExpansionChanged: ((newState) {
          if (newState)
            setState(() {
              Duration(seconds: 20000);
              selected = index;
              widget.preguntasFrecuentes[index].isExpanded = newState;
              // print(newState);
            });
          else
            setState(() {
              widget.preguntasFrecuentes[index].isExpanded = newState;
              selected = index;
            });
        }),
                children:<Widget> [
                  Container(
                          padding: EdgeInsets.only(left: _responsive.wp(6),right: _responsive.wp(6), bottom: 10.0),
                          child: 
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                            child: Text(widget.preguntasFrecuentes[index].sRespuesta,
                                            style: TextStyle(
                                                fontFamily: 'HelveticaNeue',
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.normal,
                                                fontSize: _responsive.ip(1.8),//12.0,
                                                color: Color(0xFF000000)
                                              )
                                            ),
                                          ),
                                ],
                              ),
                            
                          ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                boxShadow:  [AppConfig.boxShadow],
              ),
            );

  }
}
