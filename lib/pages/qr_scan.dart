import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_contact/models/contact_model.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRScanPage extends StatefulWidget {
  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan QR'),),
      body: Center(
        child: Center(
          child: RaisedButton(
            child: Text('Scan'),
            onPressed: () => scan(context),
          ),
        ),
      ),
    );
  }

  Future scan(BuildContext context) async {
    var barcode = await scanner.scan();

    Map<String, dynamic> jsonD = jsonDecode(barcode);

    if (jsonD != null) {
      setState(() {
        final result = ContactModel.fromJson(jsonD);

        if (result != null) {
          showSimpleCustomDialog(context, result);
        }
      });
    }
  }

  void showSimpleCustomDialog(BuildContext context, ContactModel model) {
    var simpleDialog = AlertDialog(
      content: Text('Add ${model.name} - ${model.phone} to contacts?'),
      actions: <Widget>[
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Yes'),
          onPressed: () async {
            await ContactsService.addContact(Contact(
              givenName: model.name,
              phones: [
                Item(
                  label: 'mobile',
                  value: model.phone,
                ),
              ],
            ));

            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => simpleDialog,
    );
  }
}
