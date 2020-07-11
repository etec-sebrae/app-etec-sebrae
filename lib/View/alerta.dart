import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seetec_projeto/Model/colors.dart';

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