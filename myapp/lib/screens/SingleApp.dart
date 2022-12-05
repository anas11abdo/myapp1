// ignore_for_file: deprecated_member_use, avoid_print, must_be_immutable, non_constant_identifier_names, unused_field, file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/screens/display.dart';
import 'package:myapp/screens/nopdf.dart';
import 'package:myapp/screens/related.dart';
import 'package:http/http.dart' as http;

class SingleApp extends StatefulWidget {
  SingleApp(
      {Key? key,
      required this.name,
      required this.appid,
      required this.presonal_id,
      required this.request_date,
      required this.file_status,
      required this.fromdate,
      required this.todate,
      required this.type,
      required this.relatedid,
      required this.validH,
      required this.statusofrelated,
      required this.idref,
      required this.a_reason,
      required this.h_reason,
      required this.iss,
      required this.officename})
      : super(key: key);
  String name;
  String appid;
  String presonal_id;
  DateTime request_date;
  String file_status;
  String type;
  DateTime fromdate;
  DateTime todate;
  String relatedid;
  String validH;
  bool statusofrelated;
  String idref;
  String a_reason;
  String h_reason;
  String iss;
  String officename;

  @override
  State<StatefulWidget> createState() {
    return _SingleAppState();
  }
}

class _SingleAppState extends State<SingleApp> {
  final _formKey = GlobalKey<FormState>();

  Future GetPdf() async {
    String base;
    String url = "http://172.20.0.17:9999/GACAWSPDF/webresources/pdf/" +
        widget.presonal_id +
        "/" +
        widget.iss +
        "/shear123/";
    var res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
    );
    var rese = json.decode(res.body);
    if (rese["file"].toString() == '[]' ||
        rese["file"].toString() == "null" ||
        rese["file"].toString() == "(null)") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Nop()));
    } else {
      base = rese["file"].toString();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => dis(
                    base64: base,
                    name: widget.name,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'عرض تفاصيل المعاملة',
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 105, 64, 133),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
            width: 400,
            height: 330,
            padding: const EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color.fromARGB(255, 140, 181, 243),
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Expanded(child:
                    Text(
                       widget.name,
                      maxLines : 2,
                      style: const TextStyle(fontSize: 20),
                    ),),
                    const SizedBox(height: 10),
                    Text("ID : " + widget.presonal_id,
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text("Type : " + widget.type,
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text(
                        "From date : " +
                            DateFormat("yyyy-MM-dd").format(widget.fromdate),
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text(
                        "To date : " +
                            DateFormat("yyyy-MM-dd").format(widget.todate),
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text("Office : " + widget.officename,
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text("Status : " + widget.file_status,
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                  ]),
            )),
        Container(
            width: 400,
            height: 150,
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        child: Text(
                          widget.a_reason,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Text(widget.h_reason,
                          style: const TextStyle(fontSize: 15))
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  )),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color.fromARGB(255, 140, 181, 243),
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
            )),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () async {
              GetPdf();
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
                  child: Text('تحميل PDF'),
                )),
          ),
          const SizedBox(width: 30.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => related(
                          appid: widget.appid, pid: widget.presonal_id)));
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
                  child: Text('عرض المرافقين'),
                )),
          ),
        ])
      ])),
    );
  }
}
