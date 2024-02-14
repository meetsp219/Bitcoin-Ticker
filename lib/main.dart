import 'package:bitcoin_ticker/constants.dart';
import 'package:flutter/material.dart';
import 'CryptoDisplayButtons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget androidPicker() {
    return DropdownButton<String>(
        items: [DropdownMenuItem(child: Text('hello'))],
        onChanged: (seledtedValue) {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'BITCOIN TICKER',
            style: kButtonTextStyle,
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CryptoDisplayButtons('bitcoin'),
                  CryptoDisplayButtons('etherum'),
                  CryptoDisplayButtons('doge coin'),
                ],
              ),
              Container(
                color: Colors.blue,
                height: 100,
                width: double.infinity,
                child: androidPicker(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
