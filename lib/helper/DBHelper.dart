import 'dart:io';
import 'package:digital_wallet/models/User.dart';
import 'package:digital_wallet/models/creditcard_model.dart';
import 'package:digital_wallet/models/stats.dart';
import 'package:digital_wallet/ui/publicCards.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHlper {
  static Database _db;
  static const String USERNAME = 'username';
  static const String PASSWORD = 'password';
  static const String TABLE = 'users';
  static const String TABLE_CC = 'CreditCards';
  static const String TABLE_PC = 'PublicCards';
  static const String TABLE_STAT = 'Statistic';
  static const String DB_NAME = 'stouche.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }

  //-------Create Table
  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($USERNAME varchar(55) NOT NULL PRIMARY KEY,$PASSWORD varchar(255) NOT NULL)");
    //---Credit Cards
    await db.execute(
        "CREATE TABLE $TABLE_CC ($USERNAME varchar(55) NOT NULL,cardNumber varchar(55) NOT NULL,cardHolderName varchar(55),expiryDate varchar(55)" +
            ",cvvCode varchar(55),colorIndex int , PRIMARY KEY($USERNAME,cardHolderName,cardNumber))");
    //---Public Cards
    await db.execute(
        "CREATE TABLE $TABLE_PC ($USERNAME varchar(55) NOT NULL,name varchar(55),prenom varchar(55),birthDate varchar(55)" +
            ",nationality varchar(55),img varchar,type varchar(55),PRIMARY KEY($USERNAME,name,type,prenom))");
    // ---STATISTICS
    await db.execute(
        "CREATE TABLE $TABLE_STAT ($USERNAME varchar(55) NOT NULL,description varchar(255) NOT NULL ,time varchar(55) NOT NULL , code int not null)");
  }

  //-------Insert User into table
  Future<User> insert(User user) async {
    var dbClient = await db;
    int id = await dbClient.insert(TABLE, user.toMap());
    print("User N $id");
    return user;
  }

  //-------Get user
  Future<List<User>> getUser(String username, String pass) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT * FROM $TABLE where ($USERNAME = '$username') and ($PASSWORD = '$pass')");
    List<User> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(User.fromMap(maps[i]));
      }
    }
    return employees;
  }

  //----------DROP ALL
  drop() async {
    // var dbClient = await db;

    // await dbClient.rawDelete("DROP TABLE $TABLE_CC");
    //  await dbClient.execute(
    //     "CREATE TABLE $TABLE_CC ($USERNAME varchar(55) NOT NULL,cardNumber varchar(55) NOT NULL,cardHolderName varchar(55),expiryDate varchar(55)" +
    //         ",cvvCode varchar(55),colorIndex int , PRIMARY KEY($USERNAME,cardHolderName,cardNumber))");

    // await dbClient.execute(
    //     "CREATE TABLE $TABLE_PC ($USERNAME varchar(55) NOT NULL,name varchar(55),prenom varchar(55),birthDate varchar(55)" +
    //         ",nationality varchar(55),img varchar,type varchar(55),PRIMARY KEY($USERNAME,name,type,prenom))");
    // await dbClient.execute(
    //     "CREATE TABLE $TABLE_CC ($USERNAME varchar(55) NOT NULL,cardNumber varchar(55) NOT NULL,cardHolderName varchar(55),expiryDate varchar(55)" +
    //         ",cvvCode varchar(55),colorIndex int , PRIMARY KEY($USERNAME,cardHolderName))");
    //---Public Cards
    // await dbClient.execute(
    //     "CREATE TABLE $TABLE_PC ($USERNAME varchar(55) NOT NULL,name varchar(55),prenom varchar(55),birthDate varchar(55)" +
    //         ",nationality varchar(55),img varchar,type varchar(55))");
  }

  //-------Delete from table
  Future<int> delete(String username) async {
    var dbClient = await db;
    return await dbClient
        .delete(TABLE, where: '$USERNAME = ?', whereArgs: [username]);
  }

  //update user
  Future<int> update(User user) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, user.toMap(),
        where: '$USERNAME = ?', whereArgs: [user.usrename]);
  }

  //-------------------Others Table Handler

  Future<List<CreditCard>> getCC(String username) async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .rawQuery("SELECT * FROM $TABLE_CC where $USERNAME = '$username'");
    List<CreditCard> creditCards = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        creditCards.add(CreditCard.fromMap(maps[i]));
      }
    }
    return creditCards;
  }

  Future<CreditCard> insertCC(CreditCard card) async {
    try {
      var dbClient = await db;
      int id = await dbClient.insert(TABLE_CC, card.toMap());
      print("Card N° $id");
      return card;
    } catch (ex) {}
  }

  Future<int> deleteCC(CreditCard card) async {
    var dbClient = await db;
    return await dbClient.rawDelete(
        "DELETE FROM $TABLE_CC WHERE ($USERNAME = '${card.username}') and (cardHolderName = '${card.cardHolderName}')");
  }

  //************************************************************/
  Future<List<Cards>> getPC(String username) async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .rawQuery("SELECT * FROM $TABLE_PC where $USERNAME = '$username'");
    List<Cards> cardsList = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        cardsList.add(Cards.fromMap(maps[i]));
      }
    }
    return cardsList;
  }

  Future<Cards> insertPC(Cards card) async {
    var dbClient = await db;
    int id = await dbClient.insert(TABLE_PC, card.toMap());
    print("Public Card N° $id");
    return card;
  }

  Future<int> deletePC(Cards card) async {
    var dbClient = await db;
    return await dbClient.rawDelete(
        "DELETE FROM $TABLE_PC WHERE ($USERNAME = '${card.userName}') and (name = '${card.name}') and (type = '${card.type}') and (prenom = '${card.prenom}')");
  }
  //-------------------------------------

  //********************************************************************/

  Future<Stats> insertSTAT(Stats statistic) async {
    var dbClient = await db;
    int id = await dbClient.insert(TABLE_STAT, statistic.toMap());
    print("Stats N° $id");
    return statistic;
  }

  Future<List<Stats>> getStats(String username) async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .rawQuery("SELECT * FROM $TABLE_STAT where $USERNAME = '$username'");
    List<Stats> statistics = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        statistics.add(Stats.fromMap(maps[i]));
      }
    }
    return statistics;
  }

  Future<int> deleteStats(String username) async {
    var dbClient = await db;
    return await dbClient
        .rawDelete("DELETE FROM $TABLE_STAT WHERE ($USERNAME = '$username')");
  }

  //********************************************************************/

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
