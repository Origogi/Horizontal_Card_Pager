import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizontal_card_pager/horizontal_card_pager.dart';

void main() {
  const MethodChannel channel = MethodChannel('horizontal_card_pager');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await HorizontalCardPager.platformVersion, '42');
  });
}
