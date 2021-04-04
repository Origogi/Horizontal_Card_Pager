
<div align="center">
    <img src="https://user-images.githubusercontent.com/35194820/91010815-29a04c80-e61e-11ea-8cb3-52c68d7b8810.png">
</a>
</div>

<div align="center">
	<a href="https://flutter.io">
    <img src="https://img.shields.io/badge/Platform-Flutter-yellow.svg"
      alt="Platform" />
  </a>
  <a href="https://pub.dev/packages/horizontal_card_pager">
   <img src="https://img.shields.io/badge/pub-v1.1.0-blue" />
</a>
</div>
  
Use dynamic and beautiful card view pagers (horizontal direction) to help you create great apps.

## Preview

### Mobile

<div align="center">
    <img src="https://user-images.githubusercontent.com/35194820/90704450-73f69600-e2cb-11ea-85bc-e3e6b702e30f.gif" width="190">
    <img src="https://user-images.githubusercontent.com/35194820/90978412-c4e6e280-e588-11ea-9e5e-6b1f38fc6c30.gif" width="200">
    <img src="https://user-images.githubusercontent.com/35194820/91016063-21004400-e627-11ea-8899-06f991c8e58c.gif" width="200">
</a>
</div>
<div align="center">
    <img src="https://user-images.githubusercontent.com/35194820/91016317-90763380-e627-11ea-85d9-926674648ea4.gif">
</a>
</div>
<div align="center">
   <A href="https://github.com/Origogi/Vertical_Card_Pager">Vertical Card Pager </A>
</a>
</div>

### Web

<div align="center">
    <img src="https://user-images.githubusercontent.com/35194820/94567342-55aa8f80-02a6-11eb-9433-d010792e57b1.png">
</a>
</div>

<div align="center">
   <A href="https://origogi.github.io/Horizontal_Card_Pager/#/">Web Link</A>
</div>

## Installing

1. Add dependency to `pubspec.yaml`

    *Get the latest version in the 'Installing' tab on pub.dartlang.org*
    
```dart
dependencies:
    horizontal_card_pager: ^1.1.0
```

2. Import the package

```dart
import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:horizontal_card_pager/card_item.dart';
```

3. Adding `HorizontalCardPager`

*With optional parameters*
```dart
HorizontalCardPager(
    initialPage : 2 // default value is 2
    onPageChanged: (page) => print("page : $page"),
    onSelectedItem: (page) => print("selected : $page"),
    items: { ... },  // set ImageCardItem or IconTitleCardItem class
))
```

4. Put `CardItem` object in items parameter in `HorizontalCardPager`

If the contents of the card contain only images, use the `ImageCardItem` class. and If the contents of the card include an icon and a title, use the `IconTitleCardItem` class.

|Image|Icon & Text|
|------|---|
|![imagetype](https://user-images.githubusercontent.com/35194820/91019509-12685b80-e62c-11ea-832f-eca13c90a8ce.PNG)|![icontitletype](https://user-images.githubusercontent.com/35194820/91019511-1300f200-e62c-11ea-8efd-f669b96b8705.PNG)|

### `ImageCardItem`

~~~dart

class ImageCarditem extends CardItem {
  final Widget image;

  ImageCarditem({this.image});
}
~~~

### `IconTitleCardItem`

~~~dart
class IconTitleCardItem extends CardItem {
  final IconData iconData;
  final String text;
  final Color selectedBgColor;
  final Color noSelectedBgColor;
  final Color selectedIconTextColor;
  final Color noSelectedIconTextColor;

  IconTitleCardItem(
      {this.iconData,
      this.text,
      this.selectedIconTextColor = Colors.white,
      this.noSelectedIconTextColor = Colors.grey,
      this.selectedBgColor = Colors.blue,
      this.noSelectedBgColor = Colors.white});
}
~~~

## How to use

Check out the **example** app in the [example](example) directory or the 'Example' tab on pub.dartlang.org for a more complete example.

## Reference

This package's animation is inspired from from this [Dribbble](https://dribbble.com/shots/5097519-California-National-Park-Guide?utm_source=Clipboard_Shot&utm_campaign=KEVINGAUTIER&utm_content=California%20National%20Park%20Guide&utm_medium=Social_Share) art.

## TODO

- [x] Attach Gesture Detector
- [x] implement call back method
- [x] Enable to customize card design
    - [x] icon & title
    - [x] image only
- [x] Implements sample app
- [x] Publish plugin