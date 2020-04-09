import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_qr_contanct/infrastructure/app_state.dart';
import 'package:flutter_qr_contanct/infrastructure/app_state_container.dart';
import 'package:flutter_qr_contanct/infrastructure/providers/info_provider.dart';
import 'package:flutter_qr_contanct/models/contact_model.dart';

class SettingsPage extends StatelessWidget {
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = AppStateContainer.of(context).state;

    // nameTextController.text = appState.model.name;
    // phoneTextController.text = appState.model.phone;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildBody(appState, context),
        ),
      ),
    );
  }

  Widget buildBody(AppState appState, BuildContext context) {
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
              buildSaveButton(appState, context),
            ],
          );
        });
  }

  Widget buildSaveButton(AppState appState, BuildContext context) {
    return RaisedButton(
      onPressed: () {
        // appState.model.name = nameTextController.text;
        // appState.model.phone = phoneTextController.text;

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
