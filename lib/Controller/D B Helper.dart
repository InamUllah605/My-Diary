import 'dart:io';
import 'package:path/path.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:my_diary/Controller/Widgets/Notes Model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {

  DBHelper._privateConstructor();
  static DBHelper instance=DBHelper._privateConstructor();
  Database? _database;

  //Database? _database;

  Future<Database?>get database
  async
  {
    if(_database!=null)
    {
      return _database;
    }
    else
    {
      _database=await initDatabase();
      return _database;
    }
  }
//getApplicationDocumentsDirectory();
  initDatabase()async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path= join(documentDirectory.path, "Note.db");
    return await openDatabase(path,version: 1,onCreate: _onCreate);
  }
  _onCreate(Database db,int version){

    db.execute(
        '''
      create table Note(
      id integer primary key,
      title text not null,
      message text not null
      )
      '''
    );
  }
  create(NotesModel note) async{
    var jsonvalue ={
      'title' :note.title,
      'message' :note.message,
    };
    var db= await instance.database;
    int? id=await db!.insert('Note',jsonvalue);
    if(id==null)
    {
      print('data did not saved');
    }
    else
    {
      print('data successfully saved');
    }
  }
  read() async{
    var db= await instance.database;

    return db?.query('Note');
  }
  delete(int id)async
  {
    var db= await instance.database;


    db?.delete('Note', where: 'id=?', whereArgs: [id]);

  }
  update(int id, NotesModel note)async
  {
    var jsonvalue ={
      'title' :note.title,
      'message' :note.message,
    };
    var db= await instance.database;
    db!.update('Note', jsonvalue,where: 'id=?',whereArgs: [id]);
  }
}