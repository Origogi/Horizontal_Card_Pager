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
    List<Widget> items = [
      Container(
        color: Colors.black.withOpacity(0.5),
      ),
      Container(
        color: Colors.yellow.withOpacity(0.5),
      ),
      Container(
        color: Colors.blue.withOpacity(0.5),
      ),
      Container(
        color: Colors.green.withOpacity(0.5),
      ),
      Container(
        color: Colors.grey.withOpacity(0.5),
      ),
      Container(
        color: Colors.cyan.withOpacity(0.5),
      ),
    ];

    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: HorizontalCardPager(
        onPageChanged: (page) => print("page : $page"),
        onSelectedItem: (page) => print("selected : $page"),
        items: items,
      ))),
    );
  }
}
