import 'package:flutter/material.dart';
import 'package:flutter_qr_contact/pages/main_view.dart';

void main() => runApp(MyApp());

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
