import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seetec_projeto/Model/Login.dart';
import 'package:http/http.dart' as http;
import 'package:seetec_projeto/Model/colors.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Gradient gradiente() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [corFinalGradiente, corInicioGradiente],
      tileMode: TileMode.repeated,
    );
  }

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
        backgroundColor: corSegundoIcon,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        
        color: corPrimaria,
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
              child: Text(
                " ${_nomealunoperfil}",
                style: TextStyle(fontSize: 24,color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(
                    'RA:',
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    _matriculaperfil.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(
                    'E-Mail:',
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    _emailperfil,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(
                    'Curso:',
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    _cursoperfil,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
