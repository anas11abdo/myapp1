// ignore_for_file: file_names, must_be_immutable, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:myapp/screens/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersProfile extends StatefulWidget {
  String adminname;
  String adminoffice;
  String adminpk;
  UsersProfile(
      {Key? key,
      required this.adminpk,
      required this.adminoffice,
      required this.adminname})
      : super(key: key);

  @override
  State<UsersProfile> createState() => _UsersProfileState();
}

class _UsersProfileState extends State<UsersProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              backgroundColor: Colors.black,
              radius: 80.0,
              child: CircleAvatar(
                backgroundImage: AssetImage('images/PP.jpg'),
                radius: 78,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.adminname.toUpperCase(),
              style: const TextStyle(
                fontSize: 30.0,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 140, 76, 245),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'User infromation'.toUpperCase(),
              style: const TextStyle(
                fontSize: 20.0,
                fontFamily: 'SourceSansPro',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
              ),
            ),
            const SizedBox(
              height: 20.0,
              width: 150,
              child: Divider(
                color: Colors.black,
              ),
            ),
            InkWell(
                child: Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.stop_screen_share,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Permit Number : "+widget.adminpk,
                      style: const TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 20,
                          color: Color.fromARGB(255, 140, 76, 245)),
                    ),
                  ),
                ),
                onTap: () {}),
            InkWell(
              child: Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.desktop_mac,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Office Number : "+widget.adminoffice,
                    style: const TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 20,
                        color: Color.fromARGB(255, 140, 76, 245)),
                  ),
                ),
              ),
              onTap: () {},
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                logout(context);
              },
              // textColor: Colors.white,
              // padding: const EdgeInsets.all(0.0),
              child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: const LinearGradient(colors: <Color>[
                      Color.fromRGBO(143, 148, 251, 1),
                      Color.fromRGBO(143, 148, 251, .6),
                    ]),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Center(
                    child: Text('تسجيل خروج'),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    // preferences.remove('email');
    // preferences.remove('phone');
    // preferences.remove('name');
    Navigator.pop(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
    print("logged out");
  }
}
