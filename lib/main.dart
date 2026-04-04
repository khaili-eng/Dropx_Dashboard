

import 'package:flutter/material.dart';


void main() {
 


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  

  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Admin Dashboard"),
        ),
        body: const Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}
