// ignore_for_file: camel_case_types, avoid_print, must_be_immutable, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:myapp/App.dart';
import 'package:myapp/screens/SingleApp.dart';

class related extends StatefulWidget {
  related({Key? key, required this.appid, required this.pid}) : super(key: key);
  String appid;
  String pid;

  @override
  State<related> createState() => _relatedState();
}

class _relatedState extends State<related> {
  Future gettypesdata() async {
    print(widget.pid);
    var res = await http.post(Uri.parse("http://192.168.4.241:5000/getrelated"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'appid': widget.appid,
          'refid': widget.pid
        });
    var rese = json.decode(res.body);

    List<App> apps = [];

    for (var u in rese) {
      if (u["NAME"].toString() == 'null' || u["NAME"].toString() == '(null)') {
        u["NAME"] = " ";
      }
      if (u["TRANS_NO"].toString() == 'null' ||
          u["TRANS_NO"].toString() == '(null)') {
        u["TRANS_NO"] = " ";
      }
      if (u["VALIDFROMDATE"].toString() == 'null' ||
          u["VALIDFROMDATE"].toString() == '(null)') {
        u["VALIDFROMDATE"] = "1111-11-11";
      }
      if (u["VALIDENDDATE"].toString() == 'null' ||
          u["VALIDENDDATE"].toString() == '(null)') {
        u["VALIDENDDATE"] = "1111-11-11";
        print(u["VALIDFROMDATE"]);
      }
      if (u["IDCARD"].toString() == 'null' ||
          u["IDCARD"].toString() == '(null)') {
        u["IDCARD"] = " ";
      }
      if (u["CHECKSTATUS_PERMIT_STATUS"].toString() == 'null' ||
          u["CHECKSTATUS_PERMIT_STATUS"].toString() == '(null)') {
        u["CHECKSTATUS_PERMIT_STATUS"] = " ";
      }
      if (u["CHECKSTATUS_PERMIT_STATUS"].toString() == 'In Treatment') {
        u["CHECKSTATUS_PERMIT_STATUS"] = "قيد العلاج";
      }
      if (u["CHECKSTATUS_PERMIT_STATUS"].toString() == 'Accepted') {
        u["CHECKSTATUS_PERMIT_STATUS"] = "جاهز";
      }
      if (u["CHECKSTATUS_PERMIT_STATUS"].toString() == 'Rejected') {
        u["CHECKSTATUS_PERMIT_STATUS"] = "مرفوض";
      }
      if (u["CHECKSTATUS_PERMIT_STATUS"].toString() == 'Canceled') {
        u["CHECKSTATUS_PERMIT_STATUS"] = "ملغي";
      }
      if (u["CHECKSTATUS_PERMIT_STATUS"].toString() == 'Closed') {
        u["CHECKSTATUS_PERMIT_STATUS"] = "مغلق";
      }
      if (u["PERMIT_TYPE_NAME"].toString() == 'null' ||
          u["PERMIT_TYPE_NAME"].toString() == '(null)') {
        u["PERMIT_TYPE_NAME"] = " ";
      }
      if (u["APP_REF_TRANS_NO"].toString() == 'null' ||
          u["APP_REF_TRANS_NO"].toString() == '(null)') {
        u["APP_REF_TRANS_NO"] = " ";
      }
      if (u["VALIDHOURS"].toString() == 'null' ||
          u["VALIDHOURS"].toString() == '(null)') {
        u["VALIDHOURS"] = " ";
      }
      if (u["OFFICE_CODE"].toString() == 'null' ||
          u["OFFICE_CODE"].toString() == '(null)') {
        u["OFFICE_CODE"] = " ";
      }
      if (u["APP_REF_IDCARD"].toString() == 'null' ||
          u["APP_REF_IDCARD"].toString() == '(null)') {
        u["APP_REF_IDCARD"] = " ";
      }
      if (u["REASON_DESC"].toString() == 'null' ||
          u["REASON_DESC"].toString() == '(null)') {
        u["REASON_DESC"] = " ";
      }
      if (u["REASON_NOTES"].toString() == 'null' ||
          u["REASON_NOTES"].toString() == '(null)') {
        u["REASON_NOTES"] = " ";
      }
      if (u["OFFICE_NAME"].toString() == 'null' ||
          u["OFFICE_NAME"].toString() == '(null)') {
        u["OFFICE_NAME"] = " ";
      }

      App app = App(
          u["NAME"],
          u["TRANS_NO"],
          DateTime.parse(u['VALIDFROMDATE'].toString()),
          DateTime.parse(u['VALIDENDDATE'].toString()),
          u["IDCARD"],
          u["CHECKSTATUS_PERMIT_STATUS"],
          u["PERMIT_TYPE_NAME"],
          u["VALIDHOURS"],
          u["OFFICE_CODE"],
          u["APP_REF_TRANS_NO"],
          u["APP_REF_IDCARD"],
          u["REASON_DESC"],
          u["REASON_NOTES"],
          u["ISRAELIPERMITREQID"],
          u["OFFICE_NAME"]);

      apps.add(app);
    }
    return apps;
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
          title: const Text("معاملات الرقم"),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: FutureBuilder(
                  future: gettypesdata(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.toString() == "[]") {
                        return Center(
                            child: Container(
                                child: const Text("لا يوجد مرافقين")));
                      }
                      final file = snapshot.data!;
                      return buildFiles(file);
                    } else {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Loading")
                          ]);
                    }
                  },
                ))));
  }

  Widget buildFiles(List<App> files) => ListView.builder(
      itemCount: files.length,
      itemBuilder: (BuildContext context, int index) {
        final stordfiles = files
          ..sort((item1, item2) => item2.from_date.compareTo(item1.from_date));
        final file = stordfiles[index];
        return Container(
            height: 120.0,
            margin: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            ),
            child: Stack(
              children: <Widget>[
                Container(
                    height: 124.0,
                    margin: const EdgeInsets.only(left: 46.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(143, 148, 251, 1),
                        Color.fromRGBO(143, 148, 251, .6),
                      ]),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleApp(
                                        name: file.name,
                                        appid: file.file_id,
                                        presonal_id: file.p_id,
                                        request_date: file.from_date,
                                        file_status: file.status,
                                        type: file.app_type,
                                        fromdate: file.from_date,
                                        todate: file.to_date,
                                        relatedid: file.file_id,
                                        validH: file.validhouers,
                                        statusofrelated: false,
                                        idref: file.id_ref,
                                        a_reason: file.Areason,
                                        h_reason: file.Hreason,
                                        iss: file.iss,
                                        officename: file.officename,
                                      )));
                        },
                        child: Container(
                          margin:
                              const EdgeInsets.fromLTRB(70.0, 12.0, 16.0, 0.0),
                          constraints: const BoxConstraints.expand(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(height: 4.0),
                              Expanded(
                                child: Text(
                                  file.name,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                              Container(height: 6.0),
                              Text(
                                file.app_type +
                                    "    " +
                                    DateFormat("yyyy-MM-dd")
                                        .format(file.from_date) +
                                    "    " +
                                    file.status,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  height: 2.0,
                                  width: 150.0,
                                  color: const Color(0xff00c6ff)),
                            ],
                          ),
                        ))),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: FractionalOffset.centerLeft,
                  child: const Image(
                    image: AssetImage("images/a.png"),
                    height: 92.0,
                    width: 92.0,
                  ),
                )
              ],
            ));
      });
}
