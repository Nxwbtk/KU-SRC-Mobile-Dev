import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.person),
          title: Text('Name $index'),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      }, itemCount: 20),
    );
  }
}