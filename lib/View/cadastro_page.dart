import 'package:flutter/material.dart';


class PaginaCadastrar extends StatefulWidget {
  @override
  _PaginaCadastrar createState() => _PaginaCadastrar();
}


class _PaginaCadastrar extends State<PaginaCadastrar> {
  Color corPrimaria = const Color(0xff223249);
  Color corSecundaria = const Color(0xff5263BB);
  Color corContainer = const Color(0xff394BB1);
  Color corContainerDescricaoInicio = const Color(0xff5264CB);
  Color corContainerDescricaoFim = const Color(0xff3A4BB5);
  Color corSegundoIcon = const Color(0xff394BB3);
  Color corTerceiroIcone = const Color(0xff5165C6);
  Color corQuartoIcone = const Color(0xff627BF2);
  Color corQuintoIcone = const Color(0xff6BB5FE);


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