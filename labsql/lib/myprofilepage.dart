import 'package:flutter/material.dart';
import 'package:labsql/database.dart';
import 'package:labsql/model.dart';

class MyProfilePage extends StatelessWidget {
  AppDatabase db = AppDatabase();
  final titleController = TextEditingController();
  final conversationController = TextEditingController();

  MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://www.laphamsquarterly.org/sites/default/files/styles/tall_rectangle_custom_user_small_2x/public/images/contributor/donne_360x450.jpg?itok=c3Zzv7IM&timestamp=1410446522"),
                      fit: BoxFit.fill)),
            ),
            const SizedBox(height: 20),
            const Text(
              'John Donne',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Writer",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Address: 123/456, Bangkok, Thailand"),
            const SizedBox(height: 10),
            const Text("Email: johndoe123@a.com"),
            const SizedBox(height: 200),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
