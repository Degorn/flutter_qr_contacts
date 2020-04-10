import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_qr_contact/infrastructure/managers/dialog_manager.dart';
import 'package:flutter_qr_contact/infrastructure/providers/info_provider.dart';
import 'package:flutter_qr_contact/models/contact_model.dart';

class SettingsPage extends StatelessWidget {
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildBody(context),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return FutureBuilder(
        future: InforProvider.readInfo(),
        builder: (_, AsyncSnapshot<String> snapshot) {
          if (snapshot.data.isNotEmpty) {
            final jsonData = jsonDecode(snapshot.data);
            final result = ContactModel.fromJson(jsonData);

            if (result != null) {
              nameTextController.text = result?.name ?? '';
              phoneTextController.text = result?.phone ?? '';
            }
          }

          return Column(
            children: <Widget>[
              buildTextField(nameTextController, 'Name'),
              buildTextField(phoneTextController, 'Phone'),
              buildSaveButton(context),
            ],
          );
        });
  }

  Widget buildSaveButton(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        if (nameTextController.text.isEmpty ||
            phoneTextController.text.isEmpty) {
          await DialogManager.showInformationDialog(
              context, 'All fields must be filled correctly.');

          return;
        }

        var infoJson = ContactModel(
          name: nameTextController.text,
          phone: phoneTextController.text,
        ).toStringJson();

        InforProvider.writeInfo(infoJson);

        Navigator.pop(context);
      },
      child: Text('Save'),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }
}
