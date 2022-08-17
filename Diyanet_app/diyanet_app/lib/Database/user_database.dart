import 'package:diyanet_app/Models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabase {

  static final UserDatabase instance = UserDatabase._init();


  static Database? _database;


  UserDatabase._init();


  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('users.db');
    return _database!;
  }


  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }


  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';


    await db.execute('''
CREATE TABLE $tableUsers ( 
  ${UserFields.userId} $idType, 
  ${UserFields.userName} $textType,
  ${UserFields.userLastName} $textType,
  ${UserFields.userEmail} $textType,
  ${UserFields.userPassword} $textType
  
  
  )
''');
  }


   Future<User> create(User user) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableUsers, user.toJson());
    return user.copy(userId: id);
  }

   Future<User> readUser(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUsers,
      columns: UserFields.values,
      where: '${UserFields.userId} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }


  Future<List<User>> readAllUsers() async {
    final db = await instance.database;

    //final orderBy = '${UserFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableUsers);//,orderby);

    return result.map((json) => User.fromJson(json)).toList();
  }


   Future<int> update(User user) async {
    final db = await instance.database;

    return db.update(
      tableUsers,
      user.toJson(),
      where: '${UserFields.userId} = ?',
      whereArgs: [user.userId],
    );
  }

   Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUsers,
      where: '${UserFields.userId} = ?',
      whereArgs: [id],
    );
  }


}
