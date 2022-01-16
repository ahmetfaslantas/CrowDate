import 'package:crowdate/pages/home.dart';
import 'package:crowdate/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) => {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()))
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()))
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: const Image(image: AssetImage("assets/icon/Icon-512.png"),), // TODO: Replace with a better logo.
    );
  }
}