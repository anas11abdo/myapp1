import 'package:flutter/material.dart';

class Nop extends StatefulWidget {
  const Nop({Key? key}) : super(key: key);

  @override
  State<Nop> createState() => _NopState();
}

class _NopState extends State<Nop> {
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
            'لا يوجد PDF',
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 105, 64, 133),
        ),
        body: const Center(
          child: Text("لا يمتلك هذا الشخص نسخة PDF"),
        ));
  }
}
