import 'dart:convert';
import 'package:seetec_projeto/Model/Login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EnviarDocumento {

  static Future<dynamic> postSolicitacao (int aluno, int curso, int documento) async {
    var client = http.Client();
    var jsonBody = jsonEncode({
      'id_aluno': aluno,
      'id_curso': curso,
      'id_documento': documento

    });

    final encoding = Encoding.getByName('utf-8');
    var header = {'Content-Type': 'application/json', "Accept": "application/json", };
    var url = 'https://api-seetec.herokuapp.com/api/solicitacoes';
    var prefs = await SharedPreferences.getInstance();

    try {
      var response = await client.post(url, body: jsonBody,
          encoding: encoding, headers:header);

      if (response.statusCode == 200) {          // testa se o usuario foi encontrado: 200 = ok
        return true;
      }
    }
    finally {         // finally sempre é executado
      client.close();
    }
    return false;
  }
}