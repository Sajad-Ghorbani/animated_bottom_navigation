import 'package:animated_bottom_navigation/animated_bottom_navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  late List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    widgets = [
      const Center(child: Text('Page1')),
      const Center(child: Text('Page2')),
      const Center(child: Text('Page3')),
      const Center(child: Text('Page4')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: widgets[currentIndex],
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
                title: 'Gallery',
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
        width: 30,
        direction: TextDirection.rtl,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeIn,
        onChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}
