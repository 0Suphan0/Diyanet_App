import 'package:diyanet_app/Models/user_and_product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserAndProductDatabase {
  static final UserAndProductDatabase instance = UserAndProductDatabase._init();

  static Database? _database;

  UserAndProductDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('usersAndProducts.db');
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
CREATE TABLE $tableUserAndProduct ( 
  ${UserAndProductField.tableId} $idType, 
  ${UserAndProductField.userId} $integerType,
  ${UserAndProductField.productId} $integerType,
  ${UserAndProductField.productName} $textType,
  ${UserAndProductField.productOperationMethod} $textType,
  ${UserAndProductField.productMaintainer} $textType,
  ${UserAndProductField.productMaintainerInstitution} $textType,
  ${UserAndProductField.productDoneTimes} $textType,
  ${UserAndProductField.productMaintainerNote} $textType,
  ${UserAndProductField.productMaintenanceType} $textType,
  ${UserAndProductField.isTaskDone} $integerType
  
  
  )
''');
  }

  Future<UserAndProduct> create(UserAndProduct userAndProduct) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableUserAndProduct, userAndProduct.toJson());
    return userAndProduct.copy(tableId: id);
  }

  Future<UserAndProduct> readUserAndProduct(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUserAndProduct,
      columns: UserAndProductField.values,
      where: '${UserAndProductField.tableId} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserAndProduct.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<UserAndProduct>> readAllUserAndProduct() async {
    final db = await instance.database;

    //final orderBy = '${UserFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableUserAndProduct); //,orderby);

    return result.map((json) => UserAndProduct.fromJson(json)).toList();
  }

  Future<List<Map<String, Object?>>> update(
      UserAndProduct userAndProduct, int boolValue) async {
    final db = await instance.database;

    final result = await db.rawQuery(
        ''' UPDATE $tableUserAndProduct SET isTaskDone = ? WHERE _tableId = ? ''',
        [boolValue, userAndProduct.tableId]);
    return result;
    // return db.update(
    //   tableUserAndProduct,
    //   userAndProduct.toJson(),
    //   where: '${UserAndProductField.tableId} = ?',
    //   whereArgs: [id],
    // );

    // UPDATE my_table
    // SET name = ?, age = ?
    // WHERE _id = ?
    // ''',
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUserAndProduct,
      where: '${UserAndProductField.tableId} = ?',
      whereArgs: [id],
    );
  }
}
