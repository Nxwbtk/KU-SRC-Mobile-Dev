import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:labsql/createprofilepage.dart';
import 'package:labsql/database.dart';
import 'package:labsql/model.dart';
import 'package:labsql/updateform.dart';

AppDatabase db = AppDatabase();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          ).then((_) => {
            setState(() {
              db.getAllData();
            })
          });
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<TopicModel>>(
        future: db.getAllData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                TopicModel item = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    showDetail(item);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(item.title),
                    subtitle: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(item.conversation),
                        ],
                      ),
                    ),
                    trailing: Container(
                      width: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => updateForm(), settings: RouteSettings(arguments: item))).then((_) => {
                                  setState(() {
                                    db.getAllData();
                                  })
                                });
                              },
                              icon: Icon(Icons.edit, color: Colors.green),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    //---- เรียกฟังก์ชันชื่อ deleteDialog ด้านล่าง ----
                                    deleteDialog(item);
                                    setState(() {
                                      db.getAllData();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }

  //-------------- ฟังก์ชันแสดง popup เพื่อยืนยันการลบข้อมูล --------------
  deleteDialog(TopicModel model) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // backgroundColor: Color.fromRGBO(249, 239, 219, 1),
            backgroundColor: Colors.white,
            title: Text('Are you sure to delete?'),
            actions: [
              TextButton(
                  onPressed: () {
                    db.deleteData(model);
                    setState(() {
                      db.getAllData();
                    });
                    Navigator.pop(context);
                  },
                  //----- ปุ่ม Delete -----
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
              //----- ข้อความคำว่า Cancle -----
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancle',
                    style: TextStyle(color: Colors.green),
                  ))
            ],
          );
        });
  }

  //-------------- ฟังก์ชันแสดง popup เพื่อแสดงรายละเอียดข้อมูล --------------
  showDetail(TopicModel model) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(249, 239, 219, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            title: Container(
                height: 200,
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      '${model.title}',
                      style: TextStyle(fontSize: 25),
                    )),
                    Text('${model.conversation}',
                        style: TextStyle(fontSize: 15)),
                  ],
                )),
          );
        });
  }
}

//------------- Search page -------------
class search extends StatelessWidget {
  const search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Text('Search')],
        ),
      ),
    );
  }
}
