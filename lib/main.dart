import 'package:crowdate/pages/home.dart';
import 'package:crowdate/viewmodel/eventlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(
    ChangeNotifierProvider(
      create: (_) => EventListViewModel(),
      child: const CrowDate()
    )
  );
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
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
