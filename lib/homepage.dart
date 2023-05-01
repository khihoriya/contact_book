import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:logger/database.dart';
import 'package:logger/main.dart';
import 'package:logger/updatecont.dart';
import 'package:sqflite/sqflite.dart';
import 'package:super_banners/super_banners.dart';

import 'contactbook.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int userid = 0;
  Database? ddb;
  List<Map> usercont = [];
  bool status = false;
  bool Issearch = false;
  List<Map> searchlist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forviewdata();
    setState(() {
      userid = logger.preferences!.getInt("loginid") ?? 0;
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Issearch
            ? AppBar(
                backgroundColor: Colors.black,
                title: TextField(
                  style: TextStyle(color: Colors.white),
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {


                      if (value.isNotEmpty) {
                        searchlist = [];
                        for (int u = 0; u < usercont.length; u++) {
                          String titlee = usercont[u]['name'];
                          String notess = usercont[u]['number'];
                          if (titlee
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              notess
                                  .toString()
                                  .toUpperCase()
                                  .contains(value.toUpperCase())) {
                            searchlist.add(usercont[u]);
                          }
                        }
                      }
                      else {
                        searchlist = usercont;
                      }
                    });
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              Issearch = false;
                              searchlist = usercont;
                            });
                          },
                          icon: Icon(Icons.close))),
                ),
              )
            : AppBar(
              actions: [ IconButton(
                  onPressed: () {
                    setState(() {
                      Issearch = true;
                    });
                  },
                  icon: Icon(Icons.search)),],
                title: const Text("Contacts"),
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
                backgroundColor: Colors.brown[400],
              ),
        backgroundColor: Colors.orangeAccent,
        body: status
            ? ListView.builder(
                itemCount:  Issearch?searchlist.length:usercont.length,
                itemBuilder: (context, index) {

                  Map map = Issearch ? searchlist[index] : usercont[index];
                  print("${map['name']}");
                  return AnimationLimiter(
                    key: ValueKey("${usercont.length}"),
                    child: AnimationConfiguration.staggeredList(
                        position: index,
                      child: ScaleAnimation(
                        duration: Duration(seconds: 1),
                        delay: Duration(seconds: 1),
                        child: Card(
                          margin: EdgeInsets.all(15),
                          elevation: 20,
                          child: ListTile(
                            trailing: PopupMenuButton(
                              onSelected: (value) {
                                if (value == 1) {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return updatecont(usercont[index]);
                                    },
                                  ));
                                }
                              },
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                      value: 1, child: Text("Update")),
                                  PopupMenuItem(
                                      value: 2,
                                      onTap: () {
                                        int idd = usercont[index]['id'];
                                        print("=====$idd");
                                        databaseclass().deletcontact(idd, ddb!).then((value) {
                                          forviewdata();
                                        });
                                      },
                                      child: Text("Delete"))
                                ];
                              },
                            ),

                            leading: CircleAvatar(
                                backgroundImage: AssetImage("img/audi.jpg")),
                            title: Text("${map['name']}"),
                            subtitle: Text("${map['number']}"),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //       Navigator.push(context, MaterialPageRoute(
        //         builder: (context) {
        //           return contactbook(userid);
        //         },
        //       ));
        //     },
        //     child: Icon(Icons.add)),
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          backgroundColor: Colors.blueAccent,
          items: <Widget>[
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return contactbook(userid);
                },
              ));
            }, icon: Icon(Icons.add)),
            IconButton(onPressed: () {
              logger.preferences!.setBool("loginstatus", false);
              Navigator.pushReplacement(context, MaterialPageRoute(

                builder: (context) {
                  return logger();
                },
              ));
            }, icon: Icon(Icons.logout))

          ],
          onTap: (index) {
            //Handle button tap
          },
        ),
      ),
    );
  }

  void forviewdata() {
    databaseclass().getcontactbook().then((value) {
      ddb = value;
      setState(() {});
      databaseclass()
          .viewcontract(logger.preferences!.getInt("loginid") ?? 0, ddb!)
          .then((value1) {
        setState(() {
          usercont = value1;
          searchlist=value1;
          status = true;
        });
      });
    });
  }
}

// ElevatedButton(onPressed: () {
// setState(() {
// logger.preferences!.setBool("loginstatus", false);
// });
// Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
// return logger();
// },));
// }, child: Text("Logout")),
