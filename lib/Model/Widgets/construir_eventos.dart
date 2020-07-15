import 'package:flutter/material.dart';
import 'package:seetec_projeto/Model/colors.dart';
import 'package:seetec_projeto/Model/config_file.dart';

Widget construirEventos(
    String titulo, String data, String descricao, BuildContext context, ) {
  SizeConfig().init(context);
  return Container(
    padding: EdgeInsets.only(right: 5.0),
    child: InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0)),
                title: Text(
                  titulo,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: corPrimaria,
                content: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          width: SizeConfig.blockSizeHorizontal*70,
                          height: SizeConfig.blockSizeVertical * 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  corContainerDescricaoInicio,
                                  corContainerDescricaoFim
                                ]),
                          ),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 20.0, 0.0, 10.0),
                                  child: Text(
                                    descricao,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical*60),
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Voltar'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
          color: corSecundaria,
          borderRadius: BorderRadius.circular(15.0),
        ),
        height: 220,
        width: 240,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 0.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                titulo,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                data,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
