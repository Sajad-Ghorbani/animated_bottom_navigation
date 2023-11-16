A Flutter package for implementation bottom navigation with beautiful animation.

![Gif](https://github.com/Sajad-Ghorbani/animated_bottom_navigation/blob/master/media/animated_bottom_navigation.gif "Fancy Gif")

### Add dependency

```yaml
dependencies:
  animated_bottom_navigation: ^latest_version
```

### How to use

```dart
Scaffold(
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
            onTap: () {},
            title: 'Gallery'
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
      // Handle button tap
    },
  ),
  body: Container(color: Colors.blueAccent),
)
```

### Attributes

`context`: BuildContext for use in obtaining distances\
`items`: List of TabItem for show icons\
`backgroundColor`: Color of NavigationBar's background, default Colors.white\
`onChanged`: Function handling taps on items\
`animationCurve`: Curves interpolating button change animation, default Curves.easeIn\
`animationDuration`: Duration of button change animation, default Duration(milliseconds: 150)\
`height`: Height of NavigationBar, min 0.0, max 75.0\
`width`: Width of any widget in NavigationBar, default 40.0\
`letIndexChange`: Function which takes page index as argument and returns bool. If function returns false then page is not changed on button tap. It returns true by default\
`direction`: Direction of app to handle rotate and layout, default TextDirection.ltr\
`borderRadius`: The amount of curvature in the upper edges, default 20.0\
`horizontalPadding`: The amount of distance from the surroundings, default 20.0\
`margin`: Margin for the widget\

## Features

* RTL support
* Elegant transition animation
* Ability to add children for items