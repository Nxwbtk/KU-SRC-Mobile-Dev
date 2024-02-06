import 'package:flutter/material.dart';
import './model.dart';
import './database.dart';

class updateForm extends StatefulWidget {
  @override
  State<updateForm> createState() => _updateFormState();
}

class _updateFormState extends State<updateForm> {
  AppDatabase db = AppDatabase();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as TopicModel;

    final titleController = TextEditingController(text: data.title);
    final conversationController =
        TextEditingController(text: data.conversation);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(99, 136, 137, 1),
        title: Center(
          child: Text(
            'Update Form',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  'Edit conversation',
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
                  validator: (value) {
                    if (value!.isEmpty) return 'กรุณากรอกหัวเรื่อง';
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  maxLines: 3,
                  controller: conversationController,
                  decoration: InputDecoration(
                    hintText: 'Start a new conversation',
                    icon: Icon(Icons.description),
                  ),
                  //ตรวจสอบการกรอกข้อมูลใน textfield
                  validator: (value) {
                    if (value!.isEmpty) return 'Please add a conversation';
                    if (value!.length < 6)
                      return 'Too short, length more than 6';
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Map input = {
                      'id': data.id,
                      'title': titleController.text,
                      'conversation': conversationController.text
                    };
                    if (formKey.currentState!.validate()) {
                      update(input);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void update(Map input) async {
    TopicModel data = TopicModel(
        id: input['id'],
        title: input['title'],
        conversation: input['conversation']);
    await db.updataData(data);
  }
}
