import 'package:central_bank/pages/calculate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((value) => runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Central Bank',
            routes: {
              '/': (context) => Home(),
              '/calculate': (context) => Calculate()
            },
          )));
}
