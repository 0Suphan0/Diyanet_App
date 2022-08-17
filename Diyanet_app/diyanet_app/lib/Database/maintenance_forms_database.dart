import 'package:diyanet_app/Models/maintenance_form_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MaintenanceFormDatabase {

  static final MaintenanceFormDatabase instance = MaintenanceFormDatabase._init();


  static Database? _database;


  MaintenanceFormDatabase._init();


  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('forms.db');
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
CREATE TABLE $tableMaintenanceForm ( 
  ${MaintenanceFormField.formId} $idType, 
  ${MaintenanceFormField.formProductName} $textType,
  ${MaintenanceFormField.formMaintenanceDate} $textType,
  ${MaintenanceFormField.formMaintenancePassingTime} $textType,
  ${MaintenanceFormField.formExplanation} $textType,
  ${MaintenanceFormField.formPreventionAndSuggestion} $textType,
  ${MaintenanceFormField.formImprovementAreas} $textType,
  ${MaintenanceFormField.formResult} $textType,
  ${MaintenanceFormField.formMaintenanceResponsible} $textType,
  ${MaintenanceFormField.formPersonOfCheck} $textType
  
  )
''');
  }


   Future<MaintenanceForm> create(MaintenanceForm maintenanceForm) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableMaintenanceForm, maintenanceForm.toJson());
    return maintenanceForm.copy(formId: id);
  }

   Future<MaintenanceForm> readForm(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMaintenanceForm,
      columns: MaintenanceFormField.values,
      where: '${MaintenanceFormField.formId} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return MaintenanceForm.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }


  Future<List<MaintenanceForm>> readAllForms() async {
    final db = await instance.database;

    //final orderBy = '${UserFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableMaintenanceForm);//,orderby);

    return result.map((json) => MaintenanceForm.fromJson(json)).toList();
  }


   Future<int> update(MaintenanceForm maintenanceForm,int? id) async {
    final db = await instance.database;

    return db.update(
      tableMaintenanceForm,
      maintenanceForm.toJson(),
      where: '${MaintenanceFormField.formId} = ?',
      whereArgs: [maintenanceForm.formId],
    );
  }

   Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableMaintenanceForm,
      where: '${MaintenanceFormField.formId} = ?',
      whereArgs: [id],
    );
  }


}
