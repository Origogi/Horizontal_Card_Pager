import 'package:flutter/material.dart';

import 'constant/constant.dart';
import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:horizontal_card_pager/card_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'lol',
        textTheme: textTheme,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String champion = "poppy";

  int currentSkinIndex = 2;
  int nextSkinIndex = 2;

  double currentSkinOpacity = 1.0;
  double nextSkinOpacity = 1.0;

  List skinNames = [
    "BLACK SMITH POPPY",
    "NOXUS POPPY",
    "POPPY",
    "BATTLE REGALIA POPPY",
    "STAR GUARDIAN POPPY",
    "HEXTECH PPOPY"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              //Current Image
              Opacity(
                opacity: currentSkinOpacity,
                child: Image.asset(
                  "images/${champion.toLowerCase()}/$currentSkinIndex.jpg",
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
              ),

              //Next Image
              Opacity(
                opacity: nextSkinOpacity,
                child: Image.asset(
                  "images/${champion.toLowerCase()}/$nextSkinIndex.jpg",
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Opacity(
                              opacity: currentSkinOpacity,
                              child: Text(skinNames[currentSkinIndex],
                                  textAlign: TextAlign.center,
                                  style: textTheme.headline1)),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Opacity(
                              opacity: nextSkinOpacity,
                              child: Text(
                                skinNames[nextSkinIndex],
                                style: textTheme.headline1,
                                textAlign: TextAlign.center,
                              )),
                        ),
                      ],
                    ),
                    HorizontalCardPager(
                      items: getSkinImageItems(champion.toLowerCase(), 6),
                      onSelectedItem: (page) {
                        print(page);
                      },
                      onPageChanged: (page) {
                        setState(() {
                          if ((page - currentSkinIndex.toDouble()).abs() >= 1) {
                            currentSkinIndex = nextSkinIndex;
                            currentSkinOpacity = 1.0;
                            nextSkinOpacity = 0;
                          } else if (page > currentSkinIndex) {
                            nextSkinIndex = currentSkinIndex + 1;
                            nextSkinOpacity =
                                page - currentSkinIndex.toDouble();
                            currentSkinOpacity = 1 - nextSkinOpacity;
                          } else if (page < currentSkinIndex) {
                            nextSkinIndex = currentSkinIndex - 1;
                            nextSkinOpacity =
                                currentSkinIndex.toDouble() - page;
                            currentSkinOpacity = 1.0 - nextSkinOpacity;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<CardItem> getSkinImageItems(String name, int length) {
    List<CardItem> items = [];

    for (int i = 0; i < length; i++) {
      items.add(ImageCarditem(
        image: Image.asset(
          "images/${name.toLowerCase()}/$i.jpg",
          fit: BoxFit.cover,
        ),
      ));
    }

    return items;
  }
}
