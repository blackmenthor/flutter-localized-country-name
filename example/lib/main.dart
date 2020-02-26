import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_localized_country_name/flutter_localized_country_name.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _countryCodeController;
  TextEditingController _forcedLocaleController;
  String _countryName;

  @override
  void initState() {
    super.initState();
    _countryCodeController = TextEditingController();
    _forcedLocaleController = TextEditingController();
  }

  @override
  void dispose() {
    _countryCodeController.dispose();
    _forcedLocaleController.dispose();
    super.dispose();
  }

  convertCountryName() async {
    String countryCode = _countryCodeController.text;
    String forcedLocale = _forcedLocaleController.text;
    String countryName;
    try {
      String countryName = await FlutterLocalizedCountryName.getLocalizedCountryName(
          countryCode: countryCode,
          localeToUse: forcedLocale
      );
    } on PlatformException {
      countryName = 'Failed to get country name.';
    }
    setState(() {
      _countryName = countryName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example app'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _countryCodeController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Country name (*)"
                ),
              ),
              TextField(
                controller: _forcedLocaleController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Forced Locale"
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: RaisedButton(
                  onPressed: convertCountryName,
                  child: Text(
                    "CONVERT"
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Text(
                      'Country name is: $_countryName\n',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
