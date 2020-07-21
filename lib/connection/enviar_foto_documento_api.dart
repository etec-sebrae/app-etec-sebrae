import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EnviarImagem {

  static Future<dynamic> enviarImagemDoc(String aluno,int ra,String imagem,String descricao) async {
    var client = http.Client();
    var jsonBody = jsonEncode({
      'descricao' : descricao,
      'id_aluno' : ra,
      'imagem' : imagem,
      'status': 1,
    });

    final encoding = Encoding.getByName('utf-8');
    var header = {'Content-Type': 'application/json', "Accept": "application/json", };
    var url = 'https://api-seetec.herokuapp.com/api/relatorio';

    try{
      var response = await client.post(url, body: jsonBody,encoding: encoding,headers: header);
      if(response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
    }
    finally{
      client.close();
    }
}}