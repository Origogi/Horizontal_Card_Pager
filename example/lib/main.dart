import 'package:flutter/material.dart';

import 'package:horizontal_card_pager/horizontal_card_pager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: HorizontalCardPager(titles: null, images: null)),
    );
  }
}
