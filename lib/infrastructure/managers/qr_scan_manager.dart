import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_contact/infrastructure/managers/dialog_manager.dart';
import 'package:flutter_qr_contact/models/contact_model.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRScanManager {
  static Future scan(BuildContext context) async {
    var barcode = await scanner.scan();

    Map<String, dynamic> jsonD = jsonDecode(barcode);

    if (jsonD != null) {
      final result = ContactModel.fromJson(jsonD);

      if (result != null) {
        Function confirmationFunction = () async {
          await ContactsService.addContact(Contact(
            givenName: result.name,
            phones: [
              Item(
                label: 'mobile',
                value: result.phone,
              ),
            ],
          ));

          Navigator.of(context).popUntil((route) => route.isFirst);
        };

        DialogManager.showConfirmationDialog(
          context,
          'Add ${result.name} - ${result.phone} to contacts?',
          confirmationFunction,
        );
      }
    }
  }
}
