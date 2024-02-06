import 'package:flutter/material.dart';
import 'package:labsql/database.dart';
import 'package:labsql/model.dart';

class ProfilePage extends StatelessWidget {
  AppDatabase db = AppDatabase();
  final titleController = TextEditingController();
  final conversationController = TextEditingController();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: const Text('Flutter Demo'),
          backgroundColor: Colors.amber,
        ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              child: Column(
            children: [
              Text(
                'New Conversation',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: titleController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Add a title',
                  icon: Icon(Icons.title),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: conversationController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Start a new conversation',
                  icon: Icon(Icons.description),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Map data = {
                        'title': titleController.text,
                        'conversation': conversationController.text
                      };
                      insert(data);
                      Navigator.pop(context);
                    },
                    child: Text('Post'),
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }

  void insert(Map input) async {
    TopicModel data = TopicModel(
      title: input['title'],
      conversation: input['conversation'],
    );
    await db.insertData(data);
  }
}
