import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Color corInicioGradiente = const Color(0xf3223249);
  Color corFinalGradiente = const Color(0xff5165CB);
  Color corContainer = const Color(0xffffffff);
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
              backgroundImage: AssetImage('assets/profile.png'),
              radius: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                    labelText: 'Nome:'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                    labelText: 'RA:'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                    labelText: 'E-mail:'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                    labelText: 'Data Nascimento:'
                ),
              ),
            ),
            RaisedButton(
              child: Text('Enviar'),
            ),
          ],
        ),



      ),



    );
  }
}


