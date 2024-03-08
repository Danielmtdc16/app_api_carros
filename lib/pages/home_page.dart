import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Carros'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: Text('Olá, mundo'),
      ),
    );
  }


}


