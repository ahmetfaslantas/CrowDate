import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image(
                            image: AssetImage("assets/icon/Icon-512.png"),
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      Text(
                        "Hi There,",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 36,
                            color: Colors.white),
                      ),
                      Text(
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
                        child: Text(
                          "Your Personal Event Finder App",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ),
                      ),
                      SignInButton(
                        Buttons.Google,
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
