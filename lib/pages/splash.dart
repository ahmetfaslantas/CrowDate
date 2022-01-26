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
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(image: AssetImage("assets/icon/icon.png",), width: 150, height: 150,),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("CrowDate", style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
}