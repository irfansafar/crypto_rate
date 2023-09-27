import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'networking.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String btcUSD = '?';

  rateFetch() async {
    double data = await getUrl(selectedCurrency);
    setState(() {
      btcUSD = data.toStringAsFixed(0);
    });
  }

  @override
  void initState() {
    rateFetch();
  }

  Widget plaformCheck() {
    if (Platform.isAndroid) {
      return androidCurrency();
    } else if (Platform.isIOS) {
      return getIosCurrency();
    }
  }

  Widget androidCurrency() {
    List<DropdownMenuItem<String>> currencies = [];
    for (String currency in currenciesList) {
      var CurrencyValue = DropdownMenuItem(
        child: Text(
          currency,
          textAlign: TextAlign.center,
        ),
        value: currency,
      );
      currencies.add(CurrencyValue);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currencies,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          rateFetch();
        });
      },
    );
  }

  Widget getIosCurrency() {
    List<Text> currencies = [];
    for (String currency in currenciesList) {
      var CurrencyValue = Text(currency);
      currencies.add(CurrencyValue);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedValue) {
        print(selectedValue);
      },
      children: currencies,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btcUSD $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: plaformCheck(),
          ),
        ],
      ),
    );
  }
}
