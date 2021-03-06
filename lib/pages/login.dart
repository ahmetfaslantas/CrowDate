import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowdate/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: Center(
        child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            curve: Curves.ease,
            duration: const Duration(seconds: 2),
            builder: (BuildContext context, double opacity, Widget? child) {
              return Opacity(
                opacity: opacity,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      8, MediaQuery.of(context).size.height / 5, 8, 8),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            8, 8, 8, MediaQuery.of(context).size.height / 32),
                        child: const Image(
                          image: AssetImage("assets/icon/icon.png"),
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const Text(
                        "Hi There,",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 36,
                            color: Colors.white),
                      ),
                      const Text(
                        "I'm CrowDate",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 36,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            8,
                            MediaQuery.of(context).size.height / 32,
                            8,
                            MediaQuery.of(context).size.height / 32),
                        child: const Text(
                          "Your Personal Event Finder App",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ),
                      ),
                      SignInButton(
                        Buttons.Google,
                        onPressed: () async {
                          await signInWithGoogle();

                          if (FirebaseAuth.instance.currentUser != null) {
                            String uid = FirebaseAuth.instance.currentUser!.uid;
                            DocumentReference ref = FirebaseFirestore.instance.collection("users").doc(uid);
                            DocumentSnapshot snapshot = await ref.get();
                            if (!snapshot.exists) {
                              Map<String, dynamic> empty = {};
                              ref.set(empty);
                            }
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (Route<dynamic> route) => false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sign in failed!")));
                          }
                        },
                      ),
                      ElevatedButton(
                        child: const Text("Sign in Anonymously"),
                        onPressed: () async {
                          await FirebaseAuth.instance.signInAnonymously();
                          
                          if (FirebaseAuth.instance.currentUser != null) {
                            String uid = FirebaseAuth.instance.currentUser!.uid;
                            DocumentReference ref = FirebaseFirestore.instance.collection("users").doc(uid);
                            DocumentSnapshot snapshot = await ref.get();
                            if (!snapshot.exists) {
                              Map<String, dynamic> empty = {};
                              ref.set(empty);
                            }
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (Route<dynamic> route) => false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sign in failed!")));
                          }
                        },
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
