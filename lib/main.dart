import 'package:flutter/material.dart';
import 'package:flutter_qr_contanct/infrastructure/app_state_container.dart';
import 'package:flutter_qr_contanct/pages/main_view.dart';

void main() => runApp(
      AppStateContainer(
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Contacts',
      home: MyHomePage(),
    );
  }
}
