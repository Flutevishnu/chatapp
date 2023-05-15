import 'package:flutter/material.dart';
import 'package:testdemo/all%20pages/mainpage.dart';
import 'package:testdemo/all%20pages/profile_page.dart';

class Team_chat extends StatefulWidget {
  const Team_chat({Key? key}) : super(key: key);

  @override
  State<Team_chat> createState() => _Team_chatState();
}

class _Team_chatState extends State<Team_chat> {
  void goto_profile(){
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => profile_page(),
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          leading: SizedBox(),

          title: Text(
            "KLN IRP",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: "settings",
                    child: Row(
                      children: [
                        Text("Settings"),
                        SizedBox(width: 20),
                        Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                      ],
                    )),
                PopupMenuItem(
                  value: "profile",
                    child: Row(
                      children: [
                        Text("Profile"),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.person, color: Colors.black),
                      ],
                    ))
              ],
              onSelected: (String value){
                if(value == "profile"){
                  goto_profile();
                }
              },
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(width: 5,),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Information",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50))),
                      elevation: 5,
                      splashFactory: InkRipple.splashFactory,
                      shadowColor: Colors.blue,
                      alignment: Alignment.center,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton(onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => MainPage(),
                        transitionDuration: Duration(milliseconds: 500),
                        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                      ),
                    );

                  },
                    child: Text(
                      "Chats",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(50))),
                        elevation: 5,
                        splashFactory: InkRipple.splashFactory,
                        shadowColor: Colors.blue,
                        alignment: Alignment.center,
                        backgroundColor: Colors.white


                    ),),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                          "Teams",
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          elevation: 5,
                          splashFactory: InkRipple.splashFactory,
                          shadowColor: Colors.blue,
                          alignment: Alignment.center,
                          backgroundColor: Colors.grey
                      )),

                  // SizedBox(width: 5,),
                ],
              ),
              SizedBox(height: 30,),
              Expanded(
                  child: ListView.builder(
                      itemCount: 5,

                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                          ),
                          title: Text("Team ${index + 1}"),
                          subtitle: Text("This a $index in IRP"),
                          onTap: () {},
                        );

                      }

                  ))
            ],
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
