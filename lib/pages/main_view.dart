import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_contact/infrastructure/managers/dialog_manager.dart';
import 'package:flutter_qr_contact/infrastructure/managers/qr_scan_manager.dart';
import 'package:flutter_qr_contact/infrastructure/providers/info_provider.dart';
import 'package:flutter_qr_contact/models/contact_model.dart';
import 'package:flutter_qr_contact/pages/qr_share.dart';
import 'package:flutter_qr_contact/pages/settings_view.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildUI(),
        floatingActionButton: buildSettingsButton(context),
      ),
    );
  }

  Widget buildUI() {
    return Column(
      children: <Widget>[
        buildButtons(),
        buildContactsList(),
      ],
    );
  }

  Widget buildButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButton(
            'Read QR',
            Icons.chrome_reader_mode,
            () async => await QRScanManager.scan(context)
          ),
          FutureBuilder(
              future: InforProvider.readInfo(),
              builder: (_, AsyncSnapshot<String> snapshot) {
                var onPressed = snapshot.data.isNotEmpty
                    ? () => navigateToPage(QRSharePage(snapshot.data))
                    : () => DialogManager.showInformationDialog(
                        context, 'You did\'t configure profile information');

                return buildButton(
                  'Share QR',
                  Icons.screen_share,
                  onPressed,
                );
              }),
        ],
      ),
    );
  }

  Widget buildButton(String text, IconData icon, Function onPressed) {
    return RaisedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget buildContactsList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: FutureBuilder(
          future: ContactsService.getContacts(withThumbnails: false),
          builder: (BuildContext context,
              AsyncSnapshot<Iterable<Contact>> snapshot) {
            var contacts = snapshot.data;

            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (_, index) {
                var contact = contacts.elementAt(index);
                var contactModel = ContactModel(
                    name: contact.displayName,
                    phone: contact.phones.first.value.toString());

                return Card(
                  child: ListTile(
                    title: Text(contactModel.name),
                    subtitle: Text(contactModel.phone),
                    trailing: IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        navigateToPage(
                            QRSharePage(contactModel.toStringJson()));
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildSettingsButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        navigateToPage(SettingsPage());
      },
      child: Icon(Icons.settings),
    );
  }

  navigateToPage(Object page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
}
