import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/estilos.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/unidad_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/catalogo_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

import '../app_config.dart';

class ContainerCatalogoLoading extends StatefulWidget {

  const ContainerCatalogoLoading({Key key}) : super(key: key);

  @override
  _ContainerCatalogoLoading createState() => _ContainerCatalogoLoading();
}

class _ContainerCatalogoLoading extends State<ContainerCatalogoLoading> {
  List<Map> listOfMa;
  bool isExpanded = false;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    Responsive _responsive = new Responsive(context);
    return 
    
    Container(
       margin: EdgeInsets.only(
                          left: _responsive.wp(3),
                          right: _responsive.wp(3),
                          ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        
        itemBuilder: _buildCategoriaList,
        itemCount: 2,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
            childAspectRatio: //0.7

            // childAspectRatio : MediaQuery.of(context).size.height / 1000
            MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.369),
            
                ),

                
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        
      ),
    );
  }

  Widget _buildCategoriaList(
    BuildContext context,
    int index,
  ) {
    final _responsive = Responsive(context);
    return  Container(
        //  height: _responsive.wp(40),
          width: _responsive.wp(40),
          margin: EdgeInsets.all(8),
    
          decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              'assets/campania/iconoCarga.gif'),
          fit: BoxFit.cover,
        ),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [AppConfig.boxShadow],
          ),
    );
  }
}
