// ignore_for_file: deprecated_member_use, avoid_print, must_be_immutable, avoid_unnecessary_containers, file_names

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:myapp/per_user.dart';
import 'package:myapp/screens/personapps.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  Search(
      {Key? key, required this.name, required this.per, required this.office})
      : super(key: key);
  String office;
  String name;
  String per;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  PerUser perUser = PerUser(prs_id: '');
  Future getper() async {
    String url = "http://192.168.4.241:5000/getpermits";
    var res = await http.post(Uri.parse(url), headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    }, body: <String, String>{
      'user1': widget.name,
    });
    var rese = json.decode(res.body);
    List firstall = [];
    for (var u in rese) {
      firstall.add(u["TYPES"]);
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PersonApps(
                  id: perUser.prs_id.toString(),
                  name: widget.name,
                  office: widget.office,
                  permit: widget.per,
                  permitlist: firstall,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, .6),
              ]),
            ),
          ),
          shadowColor: Colors.blue,
          title: const Text(
            'استفسار عن معاملات',
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 105, 64, 133),
        ),
        body: SingleChildScrollView(
          
            child: Column(children: [
          Container(
              child: Column(children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: TextEditingController(text: perUser.prs_id),
                decoration: const InputDecoration(
                  labelText: ' الرجاء ادخال رقم هوية',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                onChanged: (value) {
                  perUser.prs_id = value;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                getper();
              },
              // textColor: Colors.white,
              // padding: const EdgeInsets.all(0.0),
              child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: const LinearGradient(colors: <Color>[
                      Color.fromRGBO(143, 148, 251, 1),
                      Color.fromRGBO(143, 148, 251, .6),
                    ]),
                  ),
                  padding: const EdgeInsets.all(0),
                  child: const Center(
                    child: Text('عرض معاملات الرقم'),
                  )),
            ),
            const SizedBox(height:10),
            Container(
              height: 400,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/PP.jpg'), fit: BoxFit.fill)),
            )
          ]))
        ])));
  }
}
