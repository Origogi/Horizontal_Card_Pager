import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class CardItem {
  Widget buildWidget(double diffPosition);
}

class ImageCarditem extends CardItem {
  final Widget image;

  ImageCarditem({this.image});

  @override
  Widget buildWidget(double diffPosition) {
    return image;
  }
}

class IconTitleCardItem extends CardItem {
  final IconData iconData;
  final String text;
  final Color selectedColor;
  final Color noSelectedColor;

  IconTitleCardItem(
      {this.iconData,
      this.text,
      this.selectedColor = Colors.blue,
      this.noSelectedColor = Colors.white});

  @override
  Widget buildWidget(double diffPosition) {
    double iconOnlyOpacity = 1.0;
    double iconTextOpacity = 0;

    if (diffPosition < 1) {
      iconOnlyOpacity = diffPosition;
      iconTextOpacity = 1 - diffPosition;
    } else {
      iconOnlyOpacity = 1.0;
      iconTextOpacity = 0;
    }

    return Container(
        child: Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: iconTextOpacity,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 6)
                ],
                color: selectedColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Icon(
                      iconData,
                      color: Colors.white,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
        Opacity(
          opacity: iconOnlyOpacity,
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 6),
                ],
                color: noSelectedColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: EdgeInsets.all(10),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Icon(
                iconData,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
