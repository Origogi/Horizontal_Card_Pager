import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'card_item.dart';

typedef PageChangedCallback = void Function(double page);
typedef PageSelectedCallback = void Function(int index);

class HorizontalCardPager extends StatefulWidget {
  final List<CardItem> items;
  final PageChangedCallback onPageChanged;
  final PageSelectedCallback onSelectedItem;
  final TextStyle textStyle;
  final int initialPage;

  HorizontalCardPager(
      {this.items,
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

        if (widget.onPageChanged != null) {
          Future(() => widget.onPageChanged(currentPosition));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double viewWidth = constraints.maxWidth;
      double viewHeight = viewWidth / 5.0;

      double cardMaxWidth = viewHeight;
      double cardMaxHeight = cardMaxWidth;

      return GestureDetector(
          onHorizontalDragEnd: (details) {
            isScrolling = false;
          },
          onHorizontalDragStart: (details) {
            isScrolling = true;
          },
          onTapUp: (details) {
            if ((currentPosition - currentPosition.floor()).abs() <= 0.15) {
              int selectedIndex = onTapUp(
                  context, viewHeight, viewWidth, currentPosition, details);

              if (selectedIndex == 2) {
                if (widget.onSelectedItem != null) {
                  Future(() => widget.onSelectedItem(currentPosition.round()));
                }
              } else if (selectedIndex >= 0) {
                int goToPage = currentPosition.toInt() + selectedIndex - 2;
                controller.animateToPage(goToPage,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutExpo);
              }
            }
          },
          child: CardListWidget(
            items: widget.items,
            controller: controller,
            viewWidth: viewWidth,
            cardMaxHeight: cardMaxHeight,
            cardMaxWidth: cardMaxWidth,
          ));
    });
  }

  int onTapUp(context, cardMaxWidth, viewWidth, currentPosition, details) {
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    double dx = localOffset.dx;

    for (int i = 0; i < 5; i++) {
      double cardWidth = getCardSize(cardMaxWidth, i, 2.0);
      double left =
          getStartPosition(cardWidth, cardMaxWidth, viewWidth, i, 2.0);

      if (left <= dx && dx <= left + cardWidth) {
        return i;
      }
    }
    return -1;
  }
}

class CardListWidget extends StatefulWidget {
  final PageController controller;
  final double cardMaxWidth;
  final double cardMaxHeight;
  final double viewWidth;
  final List<CardItem> items;

  CardListWidget(
      {this.controller,
      this.cardMaxHeight,
      this.cardMaxWidth,
      this.viewWidth,
      this.items});

  @override
  _CardListWidgetState createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  double selectedIndex = 2.0;

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
    List<Widget> cardList = [];

    for (int i = 0; i < widget.items.length; i++) {
      double cardWidth = getCardSize(widget.cardMaxWidth, i, selectedIndex);
      double cardHeight = cardWidth;

      Widget card = Positioned.directional(
          textDirection: TextDirection.ltr,
          top: getTopPositon(cardHeight, widget.cardMaxHeight),
          start: getStartPosition(cardWidth, widget.cardMaxWidth,
              widget.viewWidth, i, selectedIndex),
          child: Opacity(
            opacity: getOpacity(i),
            child: Container(
              child: widget.items[i]
                  .buildWidget((i.toDouble() - selectedIndex).abs()),
              width: cardWidth,
              height: cardHeight,
            ),
          ));

      cardList.add(card);
    }

    return Stack(children: [
      Container(
        height: widget.cardMaxHeight,
        child: Stack(
          children: cardList,
        ),
      ),
      Positioned.fill(
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.items.length,
          controller: widget.controller,
          itemBuilder: (context, index) {
            return Container();
          },
        ),
      )
    ]);
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

double getTopPositon(double cardHeigth, double viewHeight) {
  return (viewHeight - cardHeigth) / 2;
}

double getStartPosition(double cardWidth, double cardMaxWidth, double viewWidth,
    int cardIndex, double selectedIndex) {
  double diff = (selectedIndex - cardIndex);
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

double getCardSize(double cardMaxWidth, int cardIndex, double selectedIndex) {
  double diff = (selectedIndex - cardIndex).abs();

  if (diff >= 0.0 && diff < 1.0) {
    return cardMaxWidth - cardMaxWidth * (1 / 5) * ((diff - diff.floor()));
  } else if (diff >= 1.0 && diff < 2.0) {
    return cardMaxWidth - cardMaxWidth * (1 / 5) - 10 * ((diff - diff.floor()));
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
