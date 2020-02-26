import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localized_country_name/flutter_localized_country_name.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_localized_country_name');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 'Country Name';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getLocalizedCountryName', () async {
    expect(await FlutterLocalizedCountryName.getLocalizedCountryName(countryCode: "countryCode"), 'Country Name');
  });
}
