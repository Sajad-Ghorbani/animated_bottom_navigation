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
            icon: const Icon(Icons.hive_sharp),
            haveChildren: false,
            children: [
              const Icon(Icons.call),
              const Icon(Icons.photo_rounded),
              const Icon(Icons.add_road),
            ],
          ),
          TabItem(
            icon: const Icon(Icons.library_add),
            haveChildren: true,
            children: [
              const Icon(Icons.add_a_photo),
              const Icon(Icons.get_app),
              const Icon(Icons.settings),
            ],
          ),
          TabItem(
            icon: const Icon(Icons.bookmark),
          ),
          TabItem(
            icon: const Icon(Icons.camera_alt_rounded),
            haveChildren: true,
            children: [
              const Icon(Icons.timer_10_select_rounded),
              const Icon(Icons.phone_iphone_rounded),
              const Icon(Icons.alarm),
              const Icon(Icons.color_lens),
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
