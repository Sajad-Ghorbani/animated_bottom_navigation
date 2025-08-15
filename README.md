# Animated Bottom Navigation

A customizable Flutter package for creating a bottom navigation bar with elegant animations, supporting nested child items, RTL/LTR layouts, and intuitive interactions.

![Animated Bottom Navigation](https://github.com/Sajad-Ghorbani/animated_bottom_navigation/blob/master/media/animated_bottom_navigation.gif)

## Features

- **Smooth Animations**: Elegant slide and rotate animations for item selection and child expansion.
- **Nested Child Items**: Support for expandable sub-items (2–5 children per item).
- **RTL/LTR Support**: Seamless adaptation to right-to-left and left-to-right layouts.
- **Tap Outside to Close**: Close the selected item or expanded children by tapping outside the navigation bar.
- **Back Button Support**: Close the menu when the device's back button is pressed.
- **Customizable Appearance**: Control colors, sizes, margins, and border radius for a tailored look.

## Getting Started

### Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  animated_bottom_navigation: ^latest_version
```

Run the following to install:

```bash
flutter pub get
```

### Usage

Wrap your `Scaffold` with the `AnimatedBottomNavigation` widget and configure it with a list of `TabItem` objects. Each `TabItem` can have optional child items (`TabChildrenItem`) for nested menus.

```dart
import 'package:animated_bottom_navigation/animated_bottom_navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: AnimatedBottomNavigation(
          context: context,
          items: [
            TabItem(
              icon: const Icon(Icons.hive_sharp),
              haveChildren: true,
              activeColor: Colors.white,
              inActiveColor: Colors.white60,
              children: [
                TabChildrenItem(
                  icon: const Icon(Icons.call),
                  title: 'Call',
                  onTap: () {},
                ),
                TabChildrenItem(
                  icon: const Icon(Icons.photo_rounded),
                  title: 'Gallery',
                  onTap: () {},
                ),
                TabChildrenItem(
                  icon: const Icon(Icons.add_road),
                  onTap: () {},
                ),
              ],
            ),
            TabItem(
              icon: const Icon(Icons.library_add),
              haveChildren: true,
              activeColor: Colors.white,
              inActiveColor: Colors.white60,
              children: [
                TabChildrenItem(
                  icon: const Icon(Icons.add_a_photo),
                  onTap: () {},
                ),
                TabChildrenItem(
                  icon: const Icon(Icons.get_app),
                  onTap: () {},
                ),
                TabChildrenItem(
                  icon: const Icon(Icons.settings),
                  onTap: () {},
                ),
              ],
            ),
            TabItem(
              icon: const Icon(Icons.bookmark),
              activeColor: Colors.white,
              inActiveColor: Colors.white60,
            ),
            TabItem(
              icon: const Icon(Icons.camera_alt_rounded),
              haveChildren: true,
              activeColor: Colors.white,
              inActiveColor: Colors.white60,
              children: [
                TabChildrenItem(
                  icon: const Icon(Icons.timer_10_select_rounded),
                  onTap: () {},
                ),
                TabChildrenItem(
                  icon: const Icon(Icons.phone_iphone_rounded),
                  onTap: () {},
                ),
                TabChildrenItem(
                  icon: const Icon(Icons.alarm),
                  onTap: () {},
                ),
                TabChildrenItem(
                  icon: const Icon(Icons.color_lens),
                  onTap: () {},
                ),
              ],
            ),
          ],
          onChanged: (index) {
            print('Selected tab: $index');
          },
        ),
        body: Container(color: Colors.blueAccent),
      ),
    );
  }
}
```

## Attributes

| Attribute            | Description                                                                 | Default Value                              |
|---------------------|-----------------------------------------------------------------------------|--------------------------------------------|
| `context`           | `BuildContext` used for calculating distances and layout.                   | Required                                   |
| `items`             | List of `TabItem` objects defining the navigation icons and optional children. | Required                                   |
| `backgroundColor`   | Background color of the navigation bar.                                     | `Colors.white`                             |
| `backgroundGradient`| Optional gradient for the navigation bar background.                        | `null`                                     |
| `onChanged`         | Callback triggered when a tab is selected, passing the tab index.           | `null`                                     |
| `animationCurve`    | Curve for button change animations.                                         | `Curves.easeIn`                            |
| `animationDuration` | Duration of the animation for tab changes.                                  | `Duration(milliseconds: 200)`              |
| `height`            | Height of the navigation bar (0.0 to 75.0).                                | `75.0`                                     |
| `width`             | Width of each icon in the navigation bar.                                   | `30.0`                                     |
| `letIndexChange`    | Function to control tab changes; return `false` to prevent change.          | `(_) => true`                              |
| `direction`         | Text direction for RTL/LTR layout support.                                  | `TextDirection.ltr`                        |
| `borderRadius`      | Border radius for the navigation bar's upper edges.                        | `BorderRadius.vertical(top: Radius.circular(20))` |
| `horizontalPadding` | Padding on the left and right of the navigation bar.                       | `20.0`                                     |
| `margin`            | Margin around the navigation bar.                                           | `null`                                     |

## TabItem and TabChildrenItem

- **TabItem**: Defines a navigation item with an `icon`, optional `children`, and colors for active/inactive states.
  - `haveChildren`: Set to `true` to enable child items (2–5 children allowed).
  - `activeColor` / `inActiveColor`: Colors for selected and unselected states.
- **TabChildrenItem**: Defines a child item with an `icon`, optional `title`, and `onTap` callback.

## Notes

- Ensure `items` list is not empty.
- For items with children, provide 2–5 `TabChildrenItem` instances.
- Tapping outside the navigation bar or pressing the back button closes the selected item and any expanded children.
- Test RTL layouts for languages like Persian or Arabic to ensure proper animation direction.

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests on the [GitHub repository](https://github.com/Sajad-Ghorbani/animated_bottom_navigation).

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/YourFeature`).
3. Commit your changes (`git commit -m 'Add YourFeature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Open a pull request.

## License

This package is licensed under the [MIT License](LICENSE).

---

&copy; 2025 Sajad Ghorbani. Built with Flutter.