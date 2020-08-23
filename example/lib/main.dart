import 'package:flutter/material.dart';

import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:horizontal_card_pager/card_item.dart';

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
    List<CardItem> items = [
      IconTitleCardItem(
        text: "icon",
        iconData: Icons.access_time,
      ),
      IconTitleCardItem(
        text: "icon",
        iconData: Icons.access_time,
      ),
      IconTitleCardItem(
        text: "icon",
        iconData: Icons.access_time,
      ),
      IconTitleCardItem(
        text: "icon",
        iconData: Icons.access_time,
      ),
    ];

    List<CardItem> images = [
      ImageCarditem(
          image: Image.asset(
        'images/karma.jpg',
        fit: BoxFit.fitWidth,
      )),
      ImageCarditem(
          image: Image.asset(
        'images/lux.jpg',
        fit: BoxFit.fitWidth,
      )),
      ImageCarditem(
          image: Image.asset(
        'images/nami.jpg',
        fit: BoxFit.fitWidth,
      )),
      ImageCarditem(
          image: Image.asset(
        'images/panteon.jpg',
        fit: BoxFit.fitWidth,
      )),
      ImageCarditem(
          image: Image.asset(
        'images/riven.jpg',
        fit: BoxFit.fitWidth,
      )),
      ImageCarditem(
          image: Image.asset(
        'images/soraka.jpg',
        fit: BoxFit.fitWidth,
      )),
    ];

    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: HorizontalCardPager(
        onPageChanged: (page) => print("page : $page"),
        onSelectedItem: (page) => print("selected : $page"),
        // items: images,
        items: items,
      ))),
    );
  }
}
