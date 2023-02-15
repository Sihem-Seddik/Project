import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../model/contact.model.dart';

abstract class ContactDatabase{
  static Database? _db;
  static int get _version=>1;
  static Future<void>getdb()async{
    if(_db==null) await initDB();
  }
  static Future<void> initDB() async{
    String databasePath=await getDatabasesPath();
    String _path=join(databasePath,'voyage.db');
    _db=await openDatabase(_path,version: _version,onCreate: _onCreate);

  }
  //creation de la table contact
  static _onCreate(Database db,int version) async{
    String sql='CREATE TABLE  contact(id INTEGER PRIMARY KEY AUTOINCREMENT,nom STRING, tel STRING)';
    await db.execute(sql);
  }
  static Future<List<Map<String,dynamic>>> recuperer()async{
    await getdb();
    return _db!.query(Contact.table);
  }
  // methode d'insertion d'un contact
static Future<int> inserer (Contact contact) async{
    await getdb();
    return _db!.insert(Contact.table,contact.toJson());

}
//methode de modification d'un contact
static Future<int>modifier(Contact contact) async{
    await getdb();
    return _db!.update(Contact.table, contact.toJson(),where: 'id =?',whereArgs:[contact.id]);
}
//Methode de supression d'un contact
static Future<int> supprimer(Contact contact) async{
    await getdb();
    return _db!.delete(Contact.table,where: 'id=?',whereArgs: [contact.id]);
}
}