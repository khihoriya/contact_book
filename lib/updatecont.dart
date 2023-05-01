import 'package:flutter/material.dart';
import 'package:logger/database.dart';
import 'package:sqflite/sqflite.dart';

import 'homepage.dart';

class updatecont extends StatefulWidget {
  Map usercont;
  updatecont(Map this.usercont);

  
  
  @override
  State<updatecont> createState() => _updatecontState();
}

class _updatecontState extends State<updatecont> {
  TextEditingController upnamee= TextEditingController();
  TextEditingController uppass= TextEditingController();
  Database ?db;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.usercont);
    fordatabse();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return homepage();
            },));
          }, icon: Icon(Icons.arrow_back_sharp)),
          title: const Text("Update"),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 0.00,
          backgroundColor: Colors.orangeAccent[400],
        ),
        backgroundColor: Colors.white,
        body: Column(children: [Container(margin: EdgeInsets.all(20),
          child: TextField(
             controller: upnamee,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  suffixIcon: Icon(Icons.paste_sharp),
                  icon: Icon(Icons.arrow_circle_right),
                  labelText: "Enter name",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3)))),
        ),
          Container(margin: EdgeInsets.all(20),
            child: TextField(
              controller: uppass,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    suffixIcon: Icon(Icons.paste_sharp),
                    icon: Icon(Icons.arrow_circle_right),
                    labelText: "Enter Number",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3)))),
          ),InkWell(onTap: () {

                      String newname=upnamee.text;
                      String newnum=uppass.text;
                      int iddd = widget.usercont['id'];

                      print("===$iddd");
                      databaseclass().updatecon(newname,newnum,iddd,db!).then((value) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return homepage();
                        },));
                      });

          },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.brown,
              ),
              height: 35,
              width: 120,
              child: Center(
                  child: Text(
                    "Update Contact",
                    style: TextStyle(
                        fontFamily: 'ff2',
                        fontWeight: FontWeight.bold),
                  )),
            ),
          )]),
      ),
    );
  }

  void fordatabse() {
    databaseclass().getcontactbook().then((value){
      setState(() {
        db=value;
      });
    });
  }
}
