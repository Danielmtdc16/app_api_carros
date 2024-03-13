import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_api_carros/models/Car.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), "cars.db"),
      version: 1,
      onCreate: _onCreate,
    );
  }
  _onCreate(db, version) async {
    await db.execute(_purchaseHistory);
    await db.execute(_user);
  }

  String get _purchaseHistory => '''
    CREATE TABLE purchaseHistory (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      dataCompra INT,
      foiEnviado INT,
      nomeCarro TEXT,
      valorCarro REAL,
      anoCarro INT, 
      combustivelCarro TEXT,
      numPortasCarro INT,
      corCarro TEXT,
      nomeUser TEXT,
      cpfUser TEXT
    );
   ''';

  String get _user => '''
    CREATE TABLE user (
      cpfUser PRIMARY KEY,
      nomeUser TEXT
    );
  ''';

  Future<Map<String, dynamic>?> getAllUsers() async {
    final Database db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('user', limit: 1);

    return maps.isNotEmpty ? maps.first : null;

  }

  Future<int> insertPurchase(String nomeUser, String cpfUser, Car car) async {
    final Database db = await instance.database;

    final Map<String, dynamic>? user = await getAllUsers();

    if (user == null) {
      await _insertUser(nomeUser, cpfUser);
    }

    print(await getAllUsers());
    try {
      await db.insert(
        'purchaseHistory',
        {
          'dataCompra': DateTime.now().millisecondsSinceEpoch,
          'foiEnviado': 0,
          'nomeCarro': car.nomeModelo,
          'valorCarro': car.valor,
          'anoCarro': car.ano,
          'combustivelCarro': car.combustivel,
          'numPortasCarro': car.numPortas,
          'corCarro': car.cor,
          'nomeUser': nomeUser,
          'cpfUser': cpfUser,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return 1;
    } catch (e) {
      return 0;
    }

  }

  Future<List<Map<String, dynamic>>> getAllPurchases() async {
    final Database db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('purchaseHistory');

    return maps;
  }

  Future<void> updatePurchase(List<Map<String, dynamic>> purchases, int numUpdated) async {
    final Database db = await DB.instance.database;

    await db.transaction(
      (txn) async {
        for (var purchase in purchases) {
          await txn.update(
            'purchaseHistory',
            {
              'foiEnviado': numUpdated,
            },
            where: 'id = ?',
            whereArgs: [purchase['id']]
          );
        }
      }
    );
  }

  Future<void> _insertUser(String nomeUser, String cpfUser) async {
    final Database db = await instance.database;

    await db.insert(
        'user',
        {
          'cpfUser': cpfUser,
          'nomeUser': nomeUser,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
  
  Future<void> deleteAllPurchases() async {
    final Database db = await DB.instance.database;
    
    await db.delete('purchaseHistory');
  }
}