
import 'package:flutter/material.dart';
import 'package:savemynation/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


var idInterior = new InputDecoration(
  labelStyle: TextStyle(color: kPrimaryColor),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: kPrimaryColor, width: 2)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Colors.black45, width: 2)),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Colors.red, width: 1.2)),
);
var idInterior1 = new InputDecoration(
  labelStyle: TextStyle(color: kPrimaryColor),
  contentPadding: EdgeInsets.symmetric(vertical: 5),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: kPrimaryColor, width: 2)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Colors.black45, width: 2)),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Colors.red, width: 1.2)),
);
var idInterior2 = new InputDecoration(
  labelStyle: TextStyle(color: kPrimaryColor),
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Colors.black45, width: 1.5)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Colors.white, width: 2)),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Colors.red, width: 1.2)),
);
var bd = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFF3383CD),
      Color(0xFF11249F),
    ],
  ),
);

Widget img() {
  return Padding(
    padding: const EdgeInsets.only(top: 100.0, left: 15, right: 15),
    child: Image.asset(
      'assets/images/onboarding2.png',
    ),
  );
}

RoundedRectangleBorder rrb = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(40.0)),
);

Text tNext = Text(
  'Next',
  style: TextStyle(
      fontSize: 16.0,
      fontFamily: "Poppins",
      color: Colors.white,
      fontWeight: FontWeight.w700),
);

Text tSubmit = Text(
  'Submit',
  style: TextStyle(
      fontSize: 16.0,
      color: Colors.white,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w700),
);

Widget headPadding(String head, double wt) {
  return Padding(
    padding: const EdgeInsets.only(left: 23, bottom: 8),
    child: Text(
      head,
      style: TextStyle(
          fontSize: wt / 25, color: kTitleTextColor, fontFamily: "Poppins",fontWeight: FontWeight.w700),
    ),
  );
}

Widget errorMsg(String err) {
  return Padding(
    padding: const EdgeInsets.only(left: 22),
    child: Text(
      err,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.red,
      ),
    ),
  );
}

