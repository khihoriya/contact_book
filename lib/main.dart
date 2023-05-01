import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/database.dart';
import 'package:logger/homepage.dart';
import 'package:logger/register.dart';
import 'package:logger/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(
    home: splash(),
  ));
}

class logger extends StatefulWidget {
  static SharedPreferences? preferences;

  @override
  State<logger> createState() => _loggerState();
}

class _loggerState extends State<logger> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String? nameerror;
  bool Islogin = false;
  Database? db1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fordatabase();
  }

  Future<void> fordatabase() async {
    logger.preferences = await SharedPreferences.getInstance();
    setState(() {
      Islogin = logger.preferences!.getBool("loginstatus") ?? false;
    });

    databaseclass().registeruser().then((value) {
      setState(() {
        db1 = value;
      });
    });

    if (Islogin) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return homepage(

          );
        },
      ));
    }
  }

  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/background.jpg"), fit: BoxFit.fill)),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Log in"),
          ),
          body: Container(
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/bg1.jpg"), fit: BoxFit.fill)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 60, right: 60),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "img/logo-removebg-preview (1).png"),
                                    fit: BoxFit.fill)),
                            height: 80,
                            width: 80,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Welcome There..!")],
                  )),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Log In Here!",
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: TextField(
                                controller: username,
                                decoration: InputDecoration(
                                    errorText: validate ? nameerror : null,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    suffixIcon: Icon(Icons.person),
                                    icon: Icon(Icons.arrow_circle_right),
                                    labelText: "Enter Username",
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 3)))),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: TextField(
                                controller: password,
                                decoration: InputDecoration(
                                    errorText: validate1 ? nameerror : null,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    suffixIcon: Icon(Icons.speaker_notes),
                                    icon: Icon(Icons.arrow_circle_right),
                                    labelText: "Enter Your Password",
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 3)))),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Remember Me",
                          style: TextStyle(
                              fontFamily: 'ff2',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Checkbox(
                          value: false,
                          onChanged: (value) {
                            setState(() {});
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          color: Colors.black,
                          child: InkWell(
                            onTap: () {

                              setState(() {
                                String inputname = username.text;
                                String inputname1 = password.text;
                                validate = false;
                                validate1 = false;
                                RegExp nameRegExp = RegExp('[a-zA-Z]');
                                RegExp passwodcheck = RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                //
                                // if (inputname.isEmpty) {
                                //   nameerror = "Enter Username";
                                //   validate = true;
                                // } else if (inputname1.isEmpty) {
                                //   nameerror = "Enter password";
                                //   validate1 = true;
                                // }else{


                              databaseclass().loginuser(inputname, inputname1, db1!).then((value) {
                                if (value.length == 1) {
                                  logger.preferences!.setBool("loginstatus", true);

                                  String name = value[0]['Firstname'];
                                  String number = value[0]['lastname'];
                                  String pass = value[0]['email'];
                                  String username = value[0]['username'];
                                  int idd = value[0]['id'];

                                  logger.preferences!.setString("name", name);
                                  logger.preferences!.setString("number", number);
                                  logger.preferences!.setString("pass", pass);
                                  logger.preferences!.setString("username", username);
                                  logger.preferences!.setInt("loginid",idd );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Login SuccessFully")));
                                  setState(() {

                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return homepage();

                                      },
                                    ));
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("User not found")));
                                }
                              });
                                // }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.orangeAccent,
                              ),
                              height: 35,
                              width: 120,
                              child: Center(
                                  child: Text(
                                "Log In..",
                                style: TextStyle(
                                    fontFamily: 'ff2',
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          color: Colors.black,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return register();
                                },
                              ));
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.orangeAccent,
                              ),
                              height: 35,
                              width: 120,
                              child: Center(
                                  child: Text(
                                "Register..",
                                style: TextStyle(
                                    fontFamily: 'ff2',
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }

  bool validate = false;
  bool validate1 = false;
}
