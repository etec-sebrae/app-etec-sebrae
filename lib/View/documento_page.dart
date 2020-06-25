import 'package:flutter/material.dart';

class DocumentoPage extends StatefulWidget {
  @override
  _DocumentoPageState createState() => _DocumentoPageState();
}

class _DocumentoPageState extends  State<DocumentoPage>{
  String selected;


  Color corInicioGradiente = const Color(0xff3747B2);
  Color corFinalGradiente = const Color(0xff5165CB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [corFinalGradiente, corInicioGradiente],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 250.00,
              child: Image.asset('assets/etec_sebrae.png'),
            ),
            TextFormField(
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16.00),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(color: Colors.white, fontSize: 18.00),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
            ),
            TextFormField(
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16.00),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "RA",
                labelStyle: TextStyle(color: Colors.white, fontSize: 18.00),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
            ),

            DropdownButtonFormField<String>(
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16.00),
              decoration: InputDecoration(
                //hintText: "Selecione o curso...",
                hintStyle: TextStyle(color: Colors.white, fontSize: 18.00),
                labelStyle: TextStyle(color: Colors.white, fontSize: 10.00),
                contentPadding: EdgeInsets.all(8),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
              items: <String>["Desenvolvimento de Sistemas","Desenvolvimento de Aplicativos",].map((String value) {
                return new DropdownMenuItem<String>(
                  value: selected,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String valor ) {
                setState(() {
                  selected = valor;
                });
              },
            ),

            DropdownButtonFormField<String>(
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16.00),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                //hintText: "Selecione seu documento...",
                hintStyle: TextStyle(color: Colors.white, fontSize: 18.00),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
              items: <String>['Declaração de Matricula',].map((String value) {
                return new DropdownMenuItem<String>(
                  value: selected,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => selected = value);
              },
            ),

            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                height: 40.0,
                width: 400.00,
                child: RaisedButton(
                  onPressed: () {
                  },
                  child: Text("Solicitar documento  ",
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  color: Colors.indigoAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      side: BorderSide(color: Colors.indigoAccent),
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
