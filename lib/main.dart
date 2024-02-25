import 'package:bitcoin_ticker/NetworkHelper.dart';
import 'package:bitcoin_ticker/constants.dart';
import 'package:flutter/material.dart';
import 'CryptoDisplayButtons.dart';
import 'coin_data.dart' as coin_data;
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? selectedCurrency = coin_data.currenciesList[0];

  Widget androidPicker() {
    List<DropdownMenuItem<String>> dropdownMenuItems = [];
    for (String value in coin_data.currenciesList) {
      dropdownMenuItems.add(
        DropdownMenuItem(
          value: value,
          child: Text(value),
        ),
      );
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownMenuItems,
        onChanged: (selectedValue) {
          currencyChanged(selectedValue ?? '');
        });
  }

  CupertinoPicker iOSPicker() {
    List<Widget> pickerItems = [];

    for (String currency in coin_data.currenciesList) {
      pickerItems.add(Text(
        currency,
        style: kButtonTextStyle,
      ));
    }

    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (itemIndex) {
        currencyChanged(coin_data.currenciesList[itemIndex]);
      },
      children: pickerItems,
    );
  }

  void currencyChanged(String newCurrency) {
    setState(() {
      selectedCurrency = newCurrency;
      getDisplayButtons();
    });
  }

  Future<String> getData(String crypto, String currency) async {
    String url =
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$kAPIKey&invert=true&output_format=json';

    NetworkHelper networkHelper = NetworkHelper(url);
    dynamic data = await networkHelper.getData();
    double rate = await data['rate'];

    String displayString = '';
    displayString = '$crypto = ${rate.toStringAsFixed(4)} $currency';
    print(displayString);
    return displayString;
  }

  void getDisplayString() {
    String displayString = "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(getData('BTC', 'USD'));
    getDisplayButtons();
  }

  List<CryptoDisplayButtons> cryptoDisplayButtons = [];
  void getDisplayButtons() async {
    cryptoDisplayButtons = [];
    for (String crypto in coin_data.cryptoList) {
      String s = await getData(crypto, selectedCurrency ?? 'USD');
      print("selected currency :: $selectedCurrency");
      setState(() {
        cryptoDisplayButtons.add(CryptoDisplayButtons(s));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
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
                children: cryptoDisplayButtons,
              ),
              Container(
                color: Colors.lightBlue,
                height: 150,
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30),
                child: Center(
                  child: Platform.isIOS ? iOSPicker() : androidPicker(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
