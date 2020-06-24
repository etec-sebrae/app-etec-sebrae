import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetSenha extends StatefulWidget {
  @override
  _ResetSenha createState() => _ResetSenha();
}


class _ResetSenha extends State<ResetSenha> {
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