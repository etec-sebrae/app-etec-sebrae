import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color corInicioGradiente = const Color(0xff3747B2);
Color corFinalGradiente = const Color(0xff5165CB);
Color corPrimaria = const Color(0xff223249);
Color corSecundaria = const Color(0xff5263BB);
Color corContainer = const Color(0xff394BB1);
Color corContainerDescricaoInicio = const Color(0xff5264CB);
Color corContainerDescricaoFim = const Color(0xff3A4BB5);
Color corSegundoIcon = const Color(0xff394BB3);
Color corTerceiroIcone = const Color(0xff5165C6);
Color corQuartoIcone = const Color(0xff627BF2);
Color corQuintoIcone = const Color(0xff6BB5FE);

alert(BuildContext context, String msg){
  showDialog(
      context: context,
      builder: (context){
        return AlertDialog(

          backgroundColor: corQuintoIcone,
          title: Text("Login", textAlign: TextAlign.center,),
          content: Text(msg, textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 20.0),),
          actions: <Widget>[
            FlatButton(
             color: corPrimaria,
             child: Text("Ok"),
             onPressed: (){
              Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
}