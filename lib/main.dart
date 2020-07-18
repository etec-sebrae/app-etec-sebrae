import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seetec_projeto/View/login_page.dart';
import 'package:seetec_projeto/View/main_page.dart';

import 'View/enviar_documentos.dart';
import 'View/login_page.dart';
import 'View/main_page.dart';
import 'View/solicitar_documento.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations ([DeviceOrientation.portraitUp,]).then((_) {
      runApp(new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage()
      ),
    );
  });
}


