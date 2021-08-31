import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pos_printer/model/command.dart';
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

    commands.add(Command.text(content: 'store name'));
    commands.add(Command.br());
    commands.add(Command.text(content: 'address'));
    commands.add(Command.text(content: 'phone number'));
    commands.add(Command.br());
    commands.add(Command.divider());
    commands.add(Command.text(content: 'thank you'));

    await PosPrinter.print(commands);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text('Running on: $_platformVersion\n'),
            ElevatedButton(
              onPressed: () async {
                await PosPrinter.testPrint();
              },
              child: Text('test print'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _onPrintReceipt,
              child: Text('print receipt'),
            ),
          ],
        )),
      ),
    );
  }
}
