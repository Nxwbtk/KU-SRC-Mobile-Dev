import 'package:labsql/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _database;

  Future<Database> initDb() async {
    _database ??= await createDb();
    return _database!;
  }

  Future<Database> createDb() async {
    final path = await getDatabasesPath();
    var db = await openDatabase(join(path, 'topic.db'), version: 1,
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE topic(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            title TEXT,
            conversation TEXT)
            ''');
    });
    return db;
  }
    //--------- ฟังก์ชันสำหรับเพิ่มข้อมูลในฐานข้อมูล ---------
  Future insertData(TopicModel model) async {
    var db = await initDb();
    var result = await db.insert('topic', model.toMap());
    return result;
  }

  //--------- ฟังก์ชันสำหรับดึงข้อมูลจากฐานข้อมูลทั้งหมด ---------
  Future<List<TopicModel>> getAllData() async {
    var db = await initDb();
    List<Map<String, dynamic>> result = await db.query('topic');
    return List.generate(
      result.length,
      (index) => TopicModel(
          id: result[index]['id'],
          title: result[index]['title'],
          conversation: result[index]['conversation']),
    );
  }

  //--------- ฟังก์ชันสำหรับแก้ไข/อัพเดทข้อมูลในฐานข้อมูล ---------
  Future updataData(TopicModel model) async {
    var db = await initDb();
    // print('++++ ${model.id}');
    var result = await db.update(
      'topic',
      model.toMap(),
      where: 'id=?',
      whereArgs: [model.id],
    );
    return result;
  }

  //--------- ฟังก์ชันสำหรับลบข้อมูลตาม id ที่ระบุใน whereArgs ---------
  Future deleteData(TopicModel model) async {
    var db = await initDb();
    // print('++++ ${model.id}');
    var result = db.delete(
      'topic',
      where: 'id=?',
      whereArgs: [model.id],
    );
    return result;
  }
}
