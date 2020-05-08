import 'dart:async';


import 'package:savemynation/first_screen.dart';
import 'package:savemynation/loading.dart';
import 'package:savemynation/onboarding_screen.dart';
import 'package:savemynation/shared.dart';
import 'package:savemynation/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //bool loading = true;
  getSignIn() async {
    print('sign in starts request');

    await signInWithGoogle().whenComplete(() async {
print('finsh');

    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return OnboardingScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    //getSignIn();

  }

  @override
  Widget build(BuildContext context) {
    getSignIn();
    MediaQueryData queryData = MediaQuery.of(context);
    double ht = queryData.size.height;
    return MaterialApp(
      title: 'Save My Nation',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Container(
                  height: ht,
                  width: queryData.size.width,
                  decoration: bd,
                  child: Column(
                    children: <Widget>[
                      Container(height: ht / 2, child: Padding(
                        padding: const EdgeInsets.only(top:80, left: 5, right: 5),
                        child: Image.asset(
                          'assets/images/onboarding2.png',
                          height: queryData.size.width,
                          width: queryData.size.width,
                        ),
                      )),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 5,
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.width / 20,
                      ),
                      Container(
                        child: Text(
                          'Welcome to Save My Nation',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
