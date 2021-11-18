import 'package:flutter/material.dart';

void main() {
  runApp(const CrowDate());
}

class CrowDate extends StatelessWidget {
  const CrowDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrowDate',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'CrowDate'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(),
    );
  }
}
