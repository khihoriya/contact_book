import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/database.dart';
import 'package:logger/homepage.dart';
import 'package:logger/main.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite/sqflite.dart';

class contactbook extends StatefulWidget {
  int userid;
   contactbook(int this.userid, {Key? key}) : super(key: key);



  @override
  State<contactbook> createState() => _contactbookState();
}

class _contactbookState extends State<contactbook> {

  TextEditingController nameee = TextEditingController();
  TextEditingController numberrr = TextEditingController();
  Database? db1;
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    fordatabase();
  }
  void fordatabase()
  {
    databaseclass().getcontactbook().then((value) {
      db1=value;
    });
  }
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        appBar: AppBar(
          title: const Text("Contact add"),
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
        body: Column(children: [SizedBox(height: 100,),Center(child: Container(child: Lottie.asset("lottie/47664-person.json"),)),Container(margin: EdgeInsets.all(20),
          child: TextField(
              controller: nameee,
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
              controller: numberrr,
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
                    int userid = logger.preferences!.getInt("loginid")??0;


                    databaseclass().insertcontact(nameee.text,numberrr.text,"${widget.userid}",db1!).then((value) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return homepage();
                      },));
                    });
                    // Fluttertoast.showToast(
                    //     msg: "Contact add successfully",
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.CENTER,
                    //     timeInSecForIosWeb: 1,
                    //     backgroundColor: Colors.red,
                    //     textColor: Colors.white,
                    //     fontSize: 16.0
                    // );


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
                    "Add COntact",
                    style: TextStyle(
                        fontFamily: 'ff2',
                        fontWeight: FontWeight.bold),
                  )),
          ),
             )]),
      ),
    );
  }
}
