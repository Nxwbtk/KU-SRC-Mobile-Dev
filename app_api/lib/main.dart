import 'dart:convert';

import 'package:app_api/model2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<List> getAllProduct() async {
    List users = [];
    var res = await http.get(Uri.https("fakestoreapi.com", "users"));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      print(data.length);
      for (var i in data) {
        users.add(UserModel(
            id: i['id'],
            email: i['email'],
            username: i['username'],
            password: i['password'],
            name: Name(
                firstname: i['name']['firstname'],
                lastname: i['name']['lastname']),
            phone: i['phone'],
            iV: i['__v']));
      }
      return users;
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  @override
  Widget build(BuildContext context) {
    getAllProduct();
    return Scaffold(
      appBar: AppBar(
        title: Text("User"),
      ),
      body: FutureBuilder(
        future: getAllProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("Fullname: " + snapshot.data![index].name.firstname + " " + snapshot.data![index].name.lastname),
                            subtitle:
                                Text("Username: " + snapshot.data![index].username),
                            leading: const Icon(Icons.person),
                            trailing: Text(snapshot.data![index].phone),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: snapshot.data!.length),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
