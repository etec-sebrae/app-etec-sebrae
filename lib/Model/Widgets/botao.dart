import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget construirBotao(
    Color cor, String texto, StatefulWidget paginaDoc, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)),
            color: cor,
            child: Stack(
              children: <Widget>[
                Container(
                  
                  height: 80,
                  width: 380,
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
                  padding: EdgeInsets.only(top:25.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                        'assets/papel.svg',
                        color: Colors.white,
                        width: 30,
                        height: 30,
                      )),
                )
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
      ),
    ],
  );
}
