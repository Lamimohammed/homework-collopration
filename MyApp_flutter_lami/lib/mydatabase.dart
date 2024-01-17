import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MySqlDb{

static Database? _db;

Future<Database?> get db async{

if (_db == null) {
  _db=await intialDb();
  return _db;
  
}
else{
  return _db;
}
}


intialDb() async{
  String databasepath=await getDatabasesPath();
  String path =join(databasepath,'MYDATABASE.db');
Database mydb=await openDatabase(path,onCreate: _onCreate,version: 1,onUpgrade: _onUpgrade);
return mydb;
}
_onUpgrade(Database db,int oldversion,int newversion)async{
  
  print("onUpgrade");
//await db.execute("ALTER TABLE custaccont ADD COLUMN manytype TEXT");
}

_onCreate(Database db,int version)async{
Batch batch=db.batch();

batch.execute('''
CREATE TABLE "customer" (
  "custno" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT ,
  "custname" TEXT NOT NULL  ,
  "custphone" TEXT 
)
''');

batch.execute('''
CREATE TABLE "account" (
  "accno" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT ,
  "custno" INTEGER ,
  "many" INTEGER ,
  "date" text,
  "notes" text
)
''');
await batch.commit();
//print("create database");
}

 readData(String sql)async{
  Database? mydb = await db;
  List<Map> response =await mydb!.rawQuery(sql);
 //  print("readdata ${response}");
  return response;
 }


 selectdata(String sql)async{
  Database? mydb = await db;
  List<Map> response =await mydb!.rawQuery(sql);
  return response;
 }

 insertData(String sql)async{
  Database? mydb = await db;
  int response =await mydb!.rawInsert(sql);
  //print("insertdata ${response}");
  return response;
 }
 
 updateData(String sql)async{
  Database? mydb = await db;
  int response =await mydb!.rawUpdate(sql);
  // print("updatedata ${response}");
  return response;
 }
 
 deleteData(String sql)async{
  Database? mydb = await db;
  int response =await mydb!.rawDelete(sql);
  // print("deletedata ${response}");
  return response;
 }

}