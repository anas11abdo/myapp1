// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, avoid_unnecessary_containers, deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/screens/nav.dart';
import 'package:myapp/users.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  User user = User('', '', '', '');
  String url = "http://192.168.4.241:5000/login";

  Future login() async {
    var res = await http.post(Uri.parse(url), headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    }, body: <String, String>{
      'username': user.name,
      'password': user.password
    });
    var rese = json.decode(res.body);
    var username;
    var useroffice;
    var pk;
    if (rese.toString() == '[]') {
      username = "[]";
    } else {
      username = rese[0]['UNAME'].toString();
      useroffice = rese[0]['USEROFFICE'].toString();
      pk = rese[0]['PERMIT_TYPE'].toString();
    }

    if (username == user.name) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('name', username);
      preferences.setString('office', useroffice);
      preferences.setString('pk', pk);

      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => nav(
                    pk: pk,
                    useroffice: useroffice,
                    username: username,
                  )));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("تسجيل الدخول غير صحيح"),
          content: const Text(
              "لا يوجد مستخدم بكلمة السر او اسم المستخدم المدخل الرجاء التحقق منهم"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Container(
                color: const Color.fromARGB(255, 104, 181, 243),
                padding: const EdgeInsets.all(14),
                child: const Text(
                  "حسنا",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/PP.jpg'),
                          fit: BoxFit.fill)),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                // ignore: prefer_const_literals_to_create_immutables
                                boxShadow: [
                                  const BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey))),
                                  child: TextFormField(
                                    controller:
                                        TextEditingController(text: user.name),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "اسم المستخدم",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                    onChanged: (value) {
                                      user.name = value;
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: TextEditingController(
                                        text: user.password),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "كلمة السر",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                    onChanged: (value) {
                                      user.password = value;
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            //textColor: Colors.white,
                            //padding: const EdgeInsets.all(0.0),
                            child: Container(
                              
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  gradient:
                                      const LinearGradient(colors: <Color>[
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ]),
                                ),
                                padding: const EdgeInsets.all(0),
                                child: const Center(
                                  child: Text('تسجيل دخول'),
                                )),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
