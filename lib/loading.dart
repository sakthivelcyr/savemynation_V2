import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitDualRing(
          lineWidth: 5,
          color: Colors.black,
          size: 50,
        ),
      ),
    );
  }
}

class LoadingIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF3383CD),
            Color(0xFF11249F),
          ],
        ),
      ),
      child: Center(
        child: SpinKitDualRing(
          lineWidth: 5,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
