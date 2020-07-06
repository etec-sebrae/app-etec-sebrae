import 'package:flutter/material.dart';
import 'package:seetec_projeto/Model/colors.dart';


class PaginaCadastrar extends StatefulWidget {
  @override
  _PaginaCadastrar createState() => _PaginaCadastrar();
}


class _PaginaCadastrar extends State<PaginaCadastrar> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: corPrimaria,
      appBar: AppBar(
        title: Text('Etec SEBRAE'),
        centerTitle: true,
        backgroundColor: corPrimaria,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context,false),
        )
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: corContainerDescricaoInicio,
        child: Text("Tela de Cadastro de usuario",
          style: TextStyle(
          fontSize: 32, color: Colors.white,
          ), textAlign: TextAlign.center,
        ),

      )
    );
  }
}