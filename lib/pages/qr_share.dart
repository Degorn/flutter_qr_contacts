import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRSharePage extends StatelessWidget {
  final String info;

  QRSharePage(this.info);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Share'),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
            future: generateQRCode(info),
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
