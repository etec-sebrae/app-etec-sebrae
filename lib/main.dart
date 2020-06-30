import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seetec_projeto/View/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations ([DeviceOrientation.portraitUp,]).then((_) {
      runApp(new MaterialApp(
        home: LoginPage()
      ),
    );
  });
}


