# flutter_localized_country_name

A Flutter plugin to get localized country name with the help of Native functions.

Supports both Android and iOS.

# Features

- Get localized country code
- Enabled forcing a locale to use if needed

# How to use

To use this library, all you need to do is call this function below to 
get the localized country names:

```.dart
await FlutterLocalizedCountryName.getLocalizedCountryName(
          countryCode: countryCode,
          localeToUse: forcedLocale
      );
```

Please do note that if you don't supply a value for `localeToUse`, then 
this library will use the current locale of the device if supported by 
the application. If supplied, this library will use that `locale` no 
matter if it's supported by the application or not.

# Contributor
- Angga Dwi Arifandi (a.arifandi@mozio.com)