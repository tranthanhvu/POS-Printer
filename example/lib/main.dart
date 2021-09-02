import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pos_printer/model/command.dart';
import 'package:pos_printer/model/enum.dart';
import 'package:pos_printer/pos_printer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await PosPrinter.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  _onPrintReceipt() async {
    List<Command> commands = [];

    commands.add(Command.text(content: 'store name', align: POSAlign.center));
    commands.add(Command.hr());
    commands.add(Command.text(content: 'address', align: POSAlign.center));
    commands.add(Command.kv(key: 'phone number', value: '0123456789'));
    commands.add(Command.hr());
    commands.add(Command.divider());
    commands.add(Command.text(content: 'thank you', align: POSAlign.center));

    try {
      await PosPrinter.print(commands);
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  _onPrintSimpleReceipt() async {
    List<Command> commands = [];

    commands.add(Command.text(content: 'store name', align: POSAlign.center));
    commands.add(Command.text(content: 'address', align: POSAlign.center));
    commands.add(Command.text(content: 'thank you', align: POSAlign.center));

    try {
      await PosPrinter.print(commands);
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  _onPrintImage() async {
    List<Command> commands = [];

    ByteData data = await rootBundle.load("assets/icon_store.png");
    List<int> imageBytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    String base64Image = base64Encode(imageBytes);
    commands.add(Command.image(imgContent: base64Image));

    await PosPrinter.print(commands);
  }

  _onPrintKeyValue() async {
    List<Command> commands = [];

    commands.add(Command.kv(key: 'phone number', value: '0123456789'));

    await PosPrinter.print(commands);
  }

  _onPrintLinebreak() async {
    List<Command> commands = [];

    commands.add(Command.hr());

    await PosPrinter.print(commands);
  }

  _onPrintDivider() async {
    List<Command> commands = [];

    commands.add(Command.divider());

    await PosPrinter.print(commands);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Text('Running on: $_platformVersion\n'),
                ElevatedButton(
                  onPressed: () async {
                    await PosPrinter.testPrint();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('test print'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onPrintReceipt,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('print receipt'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onPrintImage,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('print image'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onPrintSimpleReceipt,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('print simple receipt'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onPrintKeyValue,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('print key-value'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onPrintLinebreak,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('print linebreak'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onPrintDivider,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('print divider'),
                ),
              ],
            )),
      ),
    );
  }
}
