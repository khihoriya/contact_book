import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class databaseclass {
  Future<Database> registeruser() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE register (id INTEGER PRIMARY KEY, Firstname text,lastname text,email text,username text,password text)');
    });
    return database;
  }
  Future<Database> getcontactbook() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo1.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE contacbook (id INTEGER PRIMARY KEY,name text,number text,USERID text)');
        });
    return database;
  }



  Future<List<Map>> loginuser(
      String username, String password, Database database) async {
    String loginuser =
        "Select * from register where username='$username' and password='$password'";
    List<Map> list = await database.rawQuery(loginuser);

    return list;
  }





  Future<List<Map>> insertuserdata(String inputname, String inputname1, String inputname2, String inputname3, String inputname4, Database database) async {
    String cheaksql = "select * from register where username ='$inputname3'  or  password  = '$inputname4'";

    List<Map>  list =await  database.rawQuery(cheaksql);
    return list;
  }

  Future<void> insertvaliduser(String inputname, String inputname1, String inputname2, String inputname3, String inputname4, Database database) async {
    String insert =
        "insert into register (Firstname,lastname,email,username,password)  values('$inputname','$inputname1','$inputname2','$inputname3','$inputname4')";
    int aa = await database.rawInsert(insert);

  }

  Future<void> insertcontact(String text, String text2, String s,Database database) async {
    String insertcon = "insert into contacbook(name,number,USERID) values('$text','$text2','$s')";
int res=  await  database.rawInsert(insertcon);
print("====%$res");
  }

  Future<List<Map>> viewcontract(int i, Database database) async {
    String viewcontact = "select * from contacbook where USERID='$i'";
    List<Map> listt = await database.rawQuery(viewcontact);
    return listt;
  }

  Future<void> deletcontact(int idd, Database database) async {
    print("===$idd");
    String deletecont = "Delete from contacbook where id='$idd'";
   int aaa = await database.rawDelete(deletecont);
  }

  Future<void> updatecon(String newname, String newnum, int iddd,Database database) async {
    String updatecon = "update contacbook set name='$newname',number='$newnum' where ID='$iddd'";
    int aa = await database.rawUpdate(updatecon);

  }


}
