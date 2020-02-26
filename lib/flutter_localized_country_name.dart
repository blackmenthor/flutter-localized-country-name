import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localized_country_name/constants.dart';

class FlutterLocalizedCountryName {
  static const MethodChannel _channel =
      const MethodChannel(Constants.CHANNEL_NAME);

  static Future<String> getLocalizedCountryName({
    @required
    String countryCode,
    String localeToUse
  }) async {
    Map params = {
      Constants.METHOD_GET_LOCALIZED_NAME_ARG_CODE: countryCode,
    };
    if (localeToUse != null) params[Constants.METHOD_GET_LOCALIZED_NAME_ARG_LOCALE] = localeToUse;

    final String countryName = await _channel.invokeMethod(Constants.METHOD_GET_LOCALIZED_NAME, params);
    return countryName;
  }
}
