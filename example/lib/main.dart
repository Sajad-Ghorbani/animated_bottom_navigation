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

  List<Widget> widgets = [];

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
            icon: const Icon(
              Icons.hive_sharp,
              size: 30,
            ),
            haveChildren: false,
            children: [
              const Icon(Icons.call, size: 30),
              const Icon(Icons.photo_rounded, size: 30),
              const Icon(Icons.add_road, size: 30),
            ],
          ),
          TabItem(
            icon: const Icon(
              Icons.library_add,
              size: 30,
            ),
            haveChildren: true,
            children: [
              const Icon(Icons.add_a_photo, size: 30),
              const Icon(Icons.get_app, size: 30),
              const Icon(Icons.settings, size: 30),
            ],
          ),
          TabItem(
            icon: const Icon(
              Icons.bookmark,
              size: 30,
            ),
            haveChildren: true,
            children: [
              const Icon(Icons.camera, size: 30),
              const Icon(Icons.battery_charging_full_rounded, size: 30),
            ],
          ),
          TabItem(
            icon: const Icon(
              Icons.camera_alt_rounded,
              size: 30,
            ),
            haveChildren: true,
            children: [
              const Icon(Icons.timer_10_select_rounded, size: 30),
              const Icon(Icons.phone_iphone_rounded, size: 30),
              const Icon(Icons.alarm, size: 30),
              const Icon(Icons.color_lens, size: 30),
            ],
          ),
        ],
        width: 30,
        direction: TextDirection.rtl,
        backgroundColor: Colors.lightBlueAccent,
        curve: Curves.easeIn,
        onChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}
