import 'dart:convert';

import 'package:flutter/material.dart';
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
    // return Column(
    //   children: <Widget>[
    //     buildTextField(nameTextController, 'Name'),
    //     buildTextField(phoneTextController, 'Phone'),
    //     buildSaveButton(appState, context),
    //   ],
    // );

    return FutureBuilder(
        future: InforProvider.readInfo(),
        builder: (_, AsyncSnapshot<String> snapshot) {
          if (snapshot.data.isNotEmpty) {
            Map<String, dynamic> jsonD = jsonDecode(snapshot.data);

            if (jsonD.isNotEmpty) {
              final result = ContactModel.fromJson(jsonD);

              if (result != null) {
                nameTextController.text = result.name;
                phoneTextController.text = result.phone;
              }
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
      onPressed: () {
        var jsonEncoded = jsonEncode((ContactModel()
              ..name = nameTextController.text
              ..phone = phoneTextController.text)
            .toJson());

        InforProvider.writeInfo(jsonEncoded);

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
