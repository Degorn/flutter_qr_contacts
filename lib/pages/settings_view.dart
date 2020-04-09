import 'package:flutter/material.dart';
import 'package:flutter_qr_contanct/infrastructure/app_state.dart';
import 'package:flutter_qr_contanct/infrastructure/app_state_container.dart';

class SettingsPage extends StatelessWidget {
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = AppStateContainer.of(context).state;

    nameTextController.text = appState.model.name;
    phoneTextController.text = appState.model.phone;

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
    return Column(
      children: <Widget>[
        buildTextField(nameTextController, 'Name'),
        buildTextField(phoneTextController, 'Phone'),
        buildSaveButton(appState, context),
      ],
    );
  }

  Widget buildSaveButton(AppState appState, BuildContext context) {
    return RaisedButton(
      onPressed: () {
        appState.model.name = nameTextController.text;
        appState.model.phone = phoneTextController.text;
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
