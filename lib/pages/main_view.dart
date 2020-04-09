import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_contanct/infrastructure/app_state_container.dart';
import 'package:flutter_qr_contanct/infrastructure/providers/info_provider.dart';
import 'package:flutter_qr_contanct/pages/qr_scan.dart';
import 'package:flutter_qr_contanct/pages/qr_share.dart';
import 'package:flutter_qr_contanct/pages/settings_view.dart';

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
    // final appState = AppStateContainer.of(context).state;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButton(
            'Read QR',
            Icons.chrome_reader_mode,
            () => navigateToPage(QRScanPage()),
          ),
          FutureBuilder(
              future: InforProvider.readInfo(),
              builder: (_, AsyncSnapshot<String> snapshot) {
                var dataToShare = '';
                if (snapshot.data.isNotEmpty) {
                  dataToShare = jsonEncode(snapshot.data);
                }

                return buildButton(
                  'Share QR',
                  Icons.screen_share,
                  () => navigateToPage(QRSharePage(dataToShare)),
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

                return Card(
                  child: ListTile(
                    title: Text(contact.displayName),
                    subtitle: Text(contact.phones.first.value.toString()),
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
