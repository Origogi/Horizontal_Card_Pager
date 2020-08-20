import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef PageChangedCallback = void Function(double page);
typedef PageSelectedCallback = void Function(int index);

class HorizontalCardPager extends StatefulWidget {
  final List<String> titles;
  final List<Widget> images;
  final PageChangedCallback onPageChanged;
  final PageSelectedCallback onSelectedItem;
  final TextStyle textStyle;
  final int initialPage;

  HorizontalCardPager(
      {this.titles,
      this.images,
      this.onPageChanged,
      this.textStyle,
      this.initialPage = 2,
      this.onSelectedItem});

  @override
  _HorizontalCardPagerState createState() => _HorizontalCardPagerState();
}

class _HorizontalCardPagerState extends State<HorizontalCardPager> {
  bool isScrolling = false;
  double currentPosition;
  PageController controller;

  @override
  void initState() {
    super.initState();

    currentPosition = widget.initialPage.toDouble();
    controller = PageController(initialPage: widget.initialPage);

    controller.addListener(() {
      setState(() {
        currentPosition = controller.page;
        print(currentPosition);

        if (widget.onPageChanged != null) {
          Future(() => widget.onPageChanged(currentPosition));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: CardListWidget(controller: controller));
  }
}

class CardListWidget extends StatefulWidget {
  final PageController controller;

  CardListWidget({this.controller});

  @override
  _CardListWidgetState createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  List<Color> colorList = [
    Colors.black.withOpacity(0.5),
    Colors.red.withOpacity(0.5),
    Colors.blue.withOpacity(0.5),
    Colors.amber.withOpacity(0.5),
    Colors.cyan.withOpacity(0.5),
    Colors.indigo.withOpacity(0.5),
    Colors.yellow.withOpacity(0.5)
  ];

  double selectedIndex = 2.0;
  double cardMaxWidth = 0;
  double cardMaxHeight = 0;
  double viewWidth = 0;

  @override
  void initState() {
    super.initState();

    selectedIndex = 2.0;

    widget.controller.addListener(() {
      setState(() {
        selectedIndex = widget.controller.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      viewWidth = constraints.maxWidth;

      cardMaxWidth = viewWidth / 5.0;
      cardMaxHeight = cardMaxWidth;

      List<Widget> cardList = [];

      for (int i = 0; i < colorList.length; i++) {
        double cardWidth = getCardSize(i);
        double cardHeight = cardWidth;

        Widget card = Positioned.directional(
            textDirection: TextDirection.ltr,
            top: getTopPositon(cardHeight, cardMaxHeight),
            start: getStartPosition(cardWidth, i),
            child: Opacity(
              opacity: getOpacity(i),
              child: Container(
                color: colorList[i],
                width: cardWidth,
                height: cardHeight,
              ),
            ));

        cardList.add(card);
      }

      return Stack(children: [
        Container(
          height: cardMaxHeight,
          color: Colors.black12,
          child: Stack(
            children: cardList,
          ),
        ),
        Positioned.fill(
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            controller: widget.controller,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        )
      ]);
    });
  }

  double getWidth(maxHeight, i) {
    double cardMaxWidth = maxHeight / 2;
    return cardMaxWidth - 60 * (i - 2).abs();
  }

  double getHeight(maxHeight, i) {
    double cardMaxHeight = maxHeight / 2;

    if (i == 2) {
      return cardMaxHeight;
    } else if (i == 0 || i == 4) {
      return cardMaxHeight - cardMaxHeight * (4 / 5) - 10;
    } else
      return cardMaxHeight - cardMaxHeight * (4 / 5);
  }

  double getTopPositon(double cardHeigth, double viewHeight) {
    return (viewHeight - cardHeigth) / 2;
  }

  double getStartPosition(double cardWidth, int currentIndex) {
    double diff = (selectedIndex - currentIndex);
    double diffAbs = diff.abs();

    double basePosition = (viewWidth / 2) - (cardWidth / 2);

    if (diffAbs == 0) {
      return basePosition;
    }
    if (diffAbs > 0.0 && diffAbs <= 1.0) {
      if (diff >= 0) {
        return basePosition - (cardMaxWidth * 1.1) * diffAbs;
      } else {
        return basePosition + (cardMaxWidth * 1.1) * diffAbs;
      }
    } else if (diffAbs > 1.0 && diffAbs < 2.0) {
      if (diff >= 0) {
        return basePosition -
            (cardMaxWidth * 1.1) -
            cardMaxWidth * 0.9 * (diffAbs - diffAbs.floor()).abs();
      } else {
        return basePosition +
            (cardMaxWidth * 1.1) +
            cardMaxWidth * 0.9 * (diffAbs - diffAbs.floor()).abs();
      }
    } else {
      if (diff >= 0) {
        return basePosition - cardMaxWidth * 2;
      } else {
        return basePosition + cardMaxWidth * 2;
      }
    }
  }

  double getCardSize(int cardIndex) {
    double diff = (selectedIndex - cardIndex).abs();

    if (diff >= 0.0 && diff < 1.0) {
      return cardMaxWidth - cardMaxWidth * (1 / 5) * ((diff - diff.floor()));
    } else if (diff >= 1.0 && diff < 2.0) {
      return cardMaxWidth -
          cardMaxWidth * (1 / 5) -
          10 * ((diff - diff.floor()));
    } else if (diff >= 2.0 && diff < 3.0) {
      final size = cardMaxWidth -
          cardMaxWidth * (1 / 5) -
          10 -
          5 * ((diff - diff.floor()));

      return size > 0 ? size : 0;
    } else {
      final size = cardMaxWidth - cardMaxWidth * (1 / 5) - 15;

      return size > 0 ? size : 0;
    }
  }

  double getOpacity(int cardIndex) {
    double diff = (selectedIndex - cardIndex);

    if (diff >= -2 && diff <= 2) {
      return 1.0;
    } else if (diff > -3 && diff < -2) {
      return 3 - diff.abs();
    } else if (diff > 2 && diff < 3) {
      return 3 - diff.abs();
    } else {
      return 0;
    }
  }
}
