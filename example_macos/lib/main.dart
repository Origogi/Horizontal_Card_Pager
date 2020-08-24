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

  int selected = 2;

  @override
  Widget build(BuildContext context) {
    List<String> name = [
      "Catalina",
      "El capitan",
      "High Sierra",
      "Mojave",
      "Sierra",
      "Yosemite"
    ];

    List<CardItem> images = [
      ImageCarditem(
        image: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black45, offset: Offset(0, 4), blurRadius: 5),
          ], borderRadius: BorderRadius.all(Radius.circular(3))),
          child: Image.asset(
            'images/catalina.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      ImageCarditem(
        image: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black45, offset: Offset(0, 4), blurRadius: 5),
          ], borderRadius: BorderRadius.all(Radius.circular(3))),
          child: Image.asset(
            'images/el_capitan.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      ImageCarditem(
        image: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black45, offset: Offset(0, 4), blurRadius: 5),
          ], borderRadius: BorderRadius.all(Radius.circular(3))),
          child: Image.asset(
            'images/high_sierra.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      ImageCarditem(
        image: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black45, offset: Offset(0, 4), blurRadius: 5),
          ], borderRadius: BorderRadius.all(Radius.circular(3))),
          child: Image.asset(
            'images/mojave.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      ImageCarditem(
        image: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black45, offset: Offset(0, 4), blurRadius: 5),
          ], borderRadius: BorderRadius.all(Radius.circular(3))),
          child: Image.asset(
            'images/sierra.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      ImageCarditem(
        image: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black45, offset: Offset(0, 4), blurRadius: 5),
          ], borderRadius: BorderRadius.all(Radius.circular(3))),
          child: Image.asset(
            'images/yosemite.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    ];

    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name[selected],
            style: TextStyle(fontSize: 30),
          ),
          HorizontalCardPager(
            onPageChanged: (page) {
              print("page : $page");

              if (page.floor() - page == 0) {
                setState(() {
                  selected = page.toInt();
                });
              }
            },
            onSelectedItem: (page) => print("selected : $page"),
            items: images,
          ),
        ],
      ))),
    );
  }
}
