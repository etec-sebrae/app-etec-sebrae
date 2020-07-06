import 'package:flutter/material.dart';
import 'package:seetec_projeto/Model/colors.dart';

class ResetSenha extends StatefulWidget {
  @override
  _ResetSenha createState() => _ResetSenha();
}


class _ResetSenha extends State<ResetSenha> {


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
          color: corContainerDescricaoInicio,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Text("Tela de Reset de Senha",
            style: TextStyle(
              fontSize: 32, color: Colors.white,
            ), textAlign: TextAlign.center,
          ),
        )
    );
  }
}