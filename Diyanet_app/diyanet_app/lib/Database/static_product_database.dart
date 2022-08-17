// import 'package:diyanet_app/Models/product_model.dart';
// import 'package:diyanet_app/Models/static_table_product_model.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class StaticProductDatabase {

//   static final StaticProductDatabase instance = StaticProductDatabase._init();


//   static Database? _database;


//   StaticProductDatabase._init();


//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await _initDB('staticProducts.db');
//     return _database!;
//   }


//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }


//   Future _createDB(Database db, int version) async {
//     final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//     final textType = 'TEXT NOT NULL';
//     final boolType = 'BOOLEAN NOT NULL';
//     final integerType = 'INTEGER NOT NULL';


//     await db.execute('''
// CREATE TABLE $tableStaticProduct ( 
//   ${StaticProductField.productId} $idType, 
//   ${StaticProductField.productName} $textType,
//   ${StaticProductField.productOperationMethod} $textType,
//   ${StaticProductField.productMaintainer} $textType,
//   ${StaticProductField.productMaintainerInstitution} $textType,
//   ${StaticProductField.productDoneTimes} $textType,
//   ${StaticProductField.productMaintainerNote} $textType,
//   ${StaticProductField.productMaintenanceType} $textType
  
//   )
// ''');
//   }


//    Future<StaticProduct> create(StaticProduct product) async {
//     final db = await instance.database;

//     // final json = note.toJson();
//     // final columns =
//     //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
//     // final values =
//     //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
//     // final id = await db
//     //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

//     final id = await db.insert(tableStaticProduct, product.toJson());
//     return product.copy(productId: id);
//   }

//    Future<StaticProduct> readProduct(int id) async {
//     final db = await instance.database;

//     final maps = await db.query(
//       tableStaticProduct,
//       columns: StaticProductField.values,
//       where: '${StaticProductField.productId} = ?',
//       whereArgs: [id],
//     );

//     if (maps.isNotEmpty) {
//       return StaticProduct.fromJson(maps.first);
//     } else {
//       throw Exception('ID $id not found');
//     }
//   }


//   Future<List<StaticProduct>> readAllProduct() async {
//     final db = await instance.database;

//     //final orderBy = '${UserFields.time} ASC';
//     // final result =
//     //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

//     final result = await db.query(tableStaticProduct);//,orderby);

//     return result.map((json) => StaticProduct.fromJson(json)).toList();
//   }


//    Future<int> update(StaticProduct product,int? id) async {
//     final db = await instance.database;

//     return db.update(
//       tableStaticProduct,
//       product.toJson(),
//       where: '${StaticProductField.productId} = ?',
//       whereArgs: [product.productId],
//     );
//   }

//    Future<int> delete(int id) async {
//     final db = await instance.database;

//     return await db.delete(
//       tableStaticProduct,
//       where: '${StaticProductField.productId} = ?',
//       whereArgs: [id],
//     );
//   }


// }
