import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_qr_contanct/infrastructure/app_state_container.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRSharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateContainer.of(context).state;

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Share'),
      ),
      body: buildBody(jsonEncode(appState.model.toJson())),
    );
  }

  Widget buildBody(String shareString) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
            future: generateQRCode(shareString),
            builder: (_, AsyncSnapshot<Uint8List> snapshot) {
              return SizedBox(
                child: Image.memory(snapshot.data),
              );
            }),
      ),
    );
  }

  Future<Uint8List> generateQRCode(String inputCode) async =>
      await scanner.generateBarCode(inputCode);
}
