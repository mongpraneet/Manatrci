import 'package:ohrci/models/sqlite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatebase = 'ohrci.db';
  final String nameTable = 'orderTable';
  int version = 1;

  final String column_id = 'id';
  final String column_idShop = 'idShop';
  final String column_nameShop = 'nameShop';
  final String column_idProduct = 'idProduct';
  final String column_nameProduct = 'nameProduct';
  final String column_price = 'price';
  final String column_amountString = 'amountString';
  final String column_sumString = 'sumString';

  SQLiteHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatebase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $nameTable ($column_id INTEGER PRIMARY KEY, $column_idShop TEXT, $column_nameShop TEXT, $column_idProduct TEXT, $column_nameProduct TEXT, $column_price TEXT, $column_amountString TEXT, $column_sumString TEXT)'),
        version: version);
  }

  Future<Database> connectedDatebase() async {
    return await openDatabase(join(await getDatabasesPath(), nameDatebase));
  }

  Future<Null> insertDateToSQLite(SqliteModel sqliteModel) async {
    Database database = await connectedDatebase();
    try {
      database
          .insert(
        nameTable,
        sqliteModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      )
          .then((value) {
        print('Insert Sqlite Sucess');
      });
    } catch (e) {
      print('e insertdata ==> ${e.toString()}');
    }
  }

  Future<List<SqliteModel>> readerDataFromSQLite() async {
    Database database = await connectedDatebase();
    List<SqliteModel> sqliteModels = List();

    List<Map<String, dynamic>> listMaps = await database.query(nameTable);

    for (var map in listMaps) {
      SqliteModel model = SqliteModel.fromJson(map);
      sqliteModels.add(model);
    }
    return sqliteModels;
  }


}
