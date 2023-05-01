import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/database.dart';
import 'package:logger/main.dart';
import 'package:sqflite/sqflite.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool validate = false;
  bool validate1 = false;
  bool validate2 = false;
  bool validate3 = false;
  bool validate4 = false;
  String? nameerror;
  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fordatabase();
  }

  void fordatabase(){
  databaseclass().registeruser().then((value) {
      setState(() {
        db=value;
      });
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Register Form",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )))
          ],
        ),
        Expanded(
            child: Row(
          children: [
            Expanded(
                child: Container(
              margin: EdgeInsets.all(20),
              color: Colors.brown,
              child: Column(children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Text("Enter First Name",style: TextStyle(fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            controller: firstname,
                              decoration: InputDecoration(
                                errorText: validate ? nameerror :null,
                                filled: true,
                                fillColor: Colors.grey,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  suffixIcon: Icon(Icons.paste_sharp),
                                  icon: Icon(Icons.arrow_circle_right),
                                  labelText: "First name",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 3)))),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Text("Enter Last Name",style: TextStyle(fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                              controller: lastname,
                              decoration: InputDecoration(
                                  errorText: validate1 ? nameerror :null,
                                  filled: true,
                                  fillColor: Colors.grey,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  suffixIcon: Icon(Icons.paste_sharp),
                                  icon: Icon(Icons.arrow_circle_right),
                                  labelText: "Last name",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 3)))),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Text("Email",style: TextStyle(fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                              controller: email,
                              decoration: InputDecoration(
                                  errorText: validate2 ? nameerror :null,
                                  filled: true,
                                  fillColor: Colors.grey,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  suffixIcon: Icon(Icons.paste_sharp),
                                  icon: Icon(Icons.arrow_circle_right),
                                  labelText: "Enter Email",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 3)))),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Text("UserName",style: TextStyle(fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                              controller: username,
                              decoration: InputDecoration(
                                  errorText: validate3 ? nameerror :null,
                                  filled: true,
                                  fillColor: Colors.grey,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  suffixIcon: Icon(Icons.paste_sharp),
                                  icon: Icon(Icons.arrow_circle_right),
                                  labelText: "Enter username",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 3)))),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Text("Password",style: TextStyle(fontWeight: FontWeight.bold),))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                              controller: password,
                              decoration: InputDecoration(
                                  errorText: validate4 ? nameerror :null,
                                  filled: true,
                                  fillColor: Colors.grey,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  suffixIcon: Icon(Icons.paste_sharp),
                                  icon: Icon(Icons.arrow_circle_right),
                                  labelText: "Enter Password",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 3)))),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(onTap: () {
                          String inputname = firstname.text;
                          String inputname1 = lastname.text;
                          String inputname2 = email.text;
                          String inputname3 = username.text;
                          String inputname4 = password.text;

                          setState(() {
                            validate = false;
                            validate1 = false;
                            validate2 = false;
                            validate3 = false;
                            validate4 = false;
                            RegExp nameRegExp = RegExp('[a-zA-Z]');
                            RegExp emailcheck = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            RegExp passwordcheck = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                            if (inputname.isEmpty) {
                              nameerror = "Fill the firstname";
                              validate = true;
                            } else if (!nameRegExp.hasMatch(inputname)) {
                              nameerror = "Enter valid name";
                              validate = true;
                            } else if (inputname1.isEmpty) {
                              nameerror = "Fill the Last name";
                              validate1 = true;
                            } else if (!nameRegExp.hasMatch(inputname1)) {
                              nameerror = "Enter valid name";
                              validate1 = true;
                            } else if (inputname2.isEmpty) {
                              nameerror = "Enter Email";
                              validate2 = true;
                            } else if (!emailcheck.hasMatch(inputname2)) {
                              nameerror = "Enter valid email";
                              validate2 = true;
                            }
                            else if (inputname3.isEmpty) {
                              nameerror = "Enter username";
                              validate3 = true;
                            }
                            else if (!nameRegExp.hasMatch(inputname3)) {
                              nameerror = "Enter valid email";
                              validate3 = true;
                            }
                            else if (inputname4.isEmpty) {
                              nameerror = "Enter password";
                              validate4 = true;
                            }
                            else if(!passwordcheck.hasMatch(inputname4))
                            {
                              nameerror = "Enter valid password";
                              validate4 = true;
                            }
                            else
                              {
                                  databaseclass().insertuserdata(inputname,inputname1,inputname2,inputname3,inputname4,db!).then((value) {
                                    print("=====$value");
                                    if(value.length==0)
                                      {
                                        databaseclass().insertvaliduser(inputname,inputname1,inputname2,inputname3,inputname4,db!).then((value) {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                            return logger();
                                          },));
                                        });
                                      }
                                    else
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(content: Text("Aleredy Exist")));
                                      }
                                  });
                              }
                          });



                        },
                          child: Container(
                            margin: EdgeInsets.only(top: 10,bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.orangeAccent,
                            ),
                            height: 35,
                            width: 120,
                            child: Center(
                                child: Text(
                              "Register",
                              style: TextStyle(
                                  fontFamily: 'ff2', fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        InkWell(onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return logger();
                          },));
                        },
                          child: Container(
                            margin: EdgeInsets.only(top: 10,bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.orangeAccent,
                            ),
                            height: 35,
                            width: 120,
                            child: Center(
                                child: Text(
                                  "Back..",
                                  style: TextStyle(
                                      fontFamily: 'ff2', fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ]),
            ))
          ],
        ))
      ]),
    );
  }
}
