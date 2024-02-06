import 'package:flutter/material.dart';
import 'package:labsql/homepage.dart';
import 'package:labsql/createprofilepage.dart';
import 'package:labsql/myprofilepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  int screenIndex = 0;

  final pageScreen = [
    const HomePage(),
    MyProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Post Data App'),
          backgroundColor: Colors.cyan,
        ),
        body: pageScreen[screenIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Profile'),
          ],
          onTap: (value) {
            setState(() {
              screenIndex = value;
            });
          },
          currentIndex: screenIndex,
        ),
      ),
    );
  }
}