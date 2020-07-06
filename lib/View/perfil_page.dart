import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Color corInicioGradiente = const Color(0xf3223249);
  Color corFinalGradiente = const Color(0xff5165CB);
  Color corContainer = const Color(0xffffffff);

  String _nomealunoperfil = "";
  String _matriculaperfil = "";
  String _emailperfil = "";
  String _cursoperfil = "";

  Future<void> _dadosaluno() async {
    String url = "https://seetecc.herokuapp.com/api/aluno/1";
    http.Response response = await http.get(url);
    setState(() {
      _nomealunoperfil = jsonDecode(response.body)['data']['nome'].toString();
      _matriculaperfil = jsonDecode(response.body)['data']['matricula'].toString();
      _emailperfil = jsonDecode(response.body)['data']['login']['email'].toString();
      _cursoperfil = jsonDecode(response.body)['data']['curso']['nome'].toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    _dadosaluno();
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
              //backgroundImage: AssetImage('assets/profile.png'),
              radius: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),

              child: Text(" ${_nomealunoperfil}", style: TextStyle(fontSize: 24),

              ) ,
            ),

            Card(
              child: ListTile(

                title: Text('RA:', style: TextStyle(fontSize: 12), ),
                subtitle: Text(_matriculaperfil,  style: TextStyle(fontSize: 18),),
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


