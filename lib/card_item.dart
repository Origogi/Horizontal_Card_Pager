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
      this.noSelectedColor = Colors.red});

  @override
  Widget buildWidget(double diffPosition) {
    double textSize = 40;

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
            color: selectedColor,
            child: Column(
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Icon(iconData),
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: textSize),
                )
              ],
            ),
          ),
        ),
        Opacity(
          opacity: iconOnlyOpacity,
          child: Container(
            padding: EdgeInsets.all(10),
            color: noSelectedColor,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Icon(iconData),
            ),
          ),
        ),
      ],
    ));
  }
}
