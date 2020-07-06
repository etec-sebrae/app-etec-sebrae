import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget construirBotao(Color cor, String texto,StatefulWidget paginaDoc,BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)),
            color: cor,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: 80,
                  width: 350,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 35, 0.0, 0.0),
                    child: Text(
                      texto,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(323.0, 25, 0.0, 0.0),
                    child: SvgPicture.asset(
                      'assets/papel.svg',
                      color: Colors.white,
                      width: 30,
                      height: 30,
                    ))
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => paginaDoc),
              );
            },
          ),
        ),
      ],
    );
  }