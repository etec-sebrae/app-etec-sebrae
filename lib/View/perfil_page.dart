import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seetec_projeto/Model/Login.dart';
import 'package:http/http.dart' as http;
import 'package:seetec_projeto/Model/Login.dart';
import 'package:seetec_projeto/Model/Login.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

  Color corInicioGradiente = const Color(0xf3223249);
  Color corFinalGradiente = const Color(0xff5165CB);
  Color corContainer = const Color(0xffffffff);

  String _nomealunoperfil = Login.nome;
  int _matriculaperfil = Login.matricula;
  String _emailperfil = Login.email;

  String _cursoperfil = Login.Cursoaluno;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados Pessoais'),
        centerTitle: true,
        backgroundColor: corInicioGradiente,
      ),
      body:
      Container(
        height: double.infinity,
        width: double.infinity,
        color: corContainer,
        child: Column(


          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(

              backgroundColor: Color(0xff223249),
              radius: 60,
              child: Icon(
                Icons.assignment_ind,
                size: 105.0,
                color: Colors.white60,

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),

              child: Text(" ${_nomealunoperfil}", style: TextStyle(fontSize: 24),

              ) ,
            ),

            Card(
              child: ListTile(

                title: Text('RA:', style: TextStyle(fontSize: 12), ),
                subtitle: Text(_matriculaperfil.toString(),  style: TextStyle(fontSize: 18),),
              ),
            ),

            Card(
              child: ListTile(

                title: Text('E-Mail:', style: TextStyle(fontSize: 12), ),
                subtitle: Text(_emailperfil,  style: TextStyle(fontSize: 18),),
              ),
            ),
            Card(
              child: ListTile(

                title: Text('Curso:', style: TextStyle(fontSize: 12), ),
                subtitle: Text(_cursoperfil,  style: TextStyle(fontSize: 18),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}