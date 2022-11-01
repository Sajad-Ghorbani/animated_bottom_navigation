<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.



A Flutter package for implementation bottom navigation with beautiful animation.

![Gif](https://github.com/rafalbednarczuk/curved_navigation_bar/blob/master/example.gif "Fancy Gif")

### Add dependency

```yaml
dependencies:
  animated_bottom_navigation: ^0.0.1 #latest version
```

### Easy to use

```dart
Scaffold(
  bottomNavigationBar: CurvedNavigationBar(
    backgroundColor: Colors.blueAccent,
    items: <Widget>[
      Icon(Icons.add, size: 30),
      Icon(Icons.list, size: 30),
      Icon(Icons.compare_arrows, size: 30),
    ],
    onTap: (index) {
      //Handle button tap
    },
  ),
  body: Container(color: Colors.blueAccent),
)
```

### Attributes

`items`: List of Widgets\
`index`: index of NavigationBar, can be used to change current index or to set initial index\
`color`: Color of NavigationBar, default Colors.white\
`buttonBackgroundColor`: background color of floating button, default same as color attribute\
`backgroundColor`: Color of NavigationBar's background, default Colors.blueAccent\
`onTap`: Function handling taps on items\
`animationCurve`: Curves interpolating button change animation, default Curves.easeOutCubic\
`animationDuration`: Duration of button change animation, default Duration(milliseconds: 600)\
`height`: Height of NavigationBar, min 0.0, max 75.0\
`letIndexChange`: Function which takes page index as argument and returns bool. If function returns false then page is not changed on button tap. It returns true by default\


### Change page programmatically

```dart
 //State class
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: Column(
              children: <Widget>[
                Text(_page.toString(), textScaleFactor: 10.0),
                ElevatedButton(
                  child: Text('Go To Page of index 1'),
                  onPressed: () {
                    //Page change using state does the same as clicking index 1 navigation button
                    final CurvedNavigationBarState? navBarState =
                        _bottomNavigationKey.currentState;
                    navBarState?.setPage(1);
                  },
                )
              ],
            ),
          ),
        ));
  }
```