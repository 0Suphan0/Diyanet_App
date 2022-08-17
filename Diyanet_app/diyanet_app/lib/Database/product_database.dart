import 'package:diyanet_app/Models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductDatabase {

  static final ProductDatabase instance = ProductDatabase._init();


  static Database? _database;


  ProductDatabase._init();


  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('products.db');
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
CREATE TABLE $tableProduct ( 
  ${ProductFields.productId} $idType, 
  ${ProductFields.productName} $textType,
  ${ProductFields.productOperationMethod} $textType,
  ${ProductFields.productMaintainer} $textType,
  ${ProductFields.productMaintainerInstitution} $textType,
  ${ProductFields.productDoneTimes} $textType,
  ${ProductFields.productMaintainerNote} $textType,
  ${ProductFields.productMaintenanceType} $textType
  
  )
''');
  }


   Future<Product> create(Product product) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableProduct, product.toJson());
    return product.copy(productId: id);
  }

   Future<Product> readProduct(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableProduct,
      columns: ProductFields.values,
      where: '${ProductFields.productId} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Product.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }


  Future<List<Product>> readAllProduct() async {
    final db = await instance.database;

    //final orderBy = '${UserFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableProduct);//,orderby);

    return result.map((json) => Product.fromJson(json)).toList();
  }


   Future<int> update(Product product,int? id) async {
    final db = await instance.database;

    return db.update(
      tableProduct,
      product.toJson(),
      where: '${ProductFields.productId} = ?',
      whereArgs: [product.productId],
    );
  }

   Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableProduct,
      where: '${ProductFields.productId} = ?',
      whereArgs: [id],
    );
  }


}
