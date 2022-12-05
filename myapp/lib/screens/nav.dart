// ignore_for_file: camel_case_types, unused_local_variable, prefer_const_constructors, must_be_immutable

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/InfoPage.dart';
import 'package:myapp/screens/SearchPage.dart';
import 'package:myapp/screens/UesrProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class nav extends StatefulWidget {
  String useroffice;
  String username;
  String pk;
  nav(
      {Key? key,
      required this.username,
      required this.pk,
      required this.useroffice})
      : super(key: key);

  @override
  State<nav> createState() => _navState();
}

class _navState extends State<nav> {
  Future getemail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
  }

  int selectedpage = 1;
  late final _pageOption = [
    UsersProfile(
        adminpk: widget.pk,
        adminoffice: widget.useroffice,
        adminname: widget.username),
    Search(per: widget.pk, office: widget.useroffice, name: widget.username),
    const InfoPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOption[selectedpage],
      bottomNavigationBar: ConvexAppBar(
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(143, 148, 251, 1),
          Color.fromRGBO(143, 148, 251, .6),
        ]),
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          TabItem(
            icon: Icons.person,
            title: "الملف الشخصي",
          ),
          TabItem(icon: Icons.home, title: "الرئيسيه"),
          TabItem(icon: Icons.info, title: "معلومات"),
        ],
        initialActiveIndex: selectedpage,
        onTap: (int index) {
          setState(() {
            selectedpage = index;
          });
        },
      ),
    );
  }
}
