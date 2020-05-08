import 'package:savemynation/constant.dart';
import 'package:savemynation/main.dart';
import 'package:savemynation/shared.dart';
import 'package:savemynation/widgets/my_header.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final String url, name, email, professional, state, street, district, mobnum;
  UserProfilePage(this.url, this.name, this.email, this.professional,
      this.state, this.street, this.district, this.mobnum);

  Widget _buildProfileImage(double ht, double wt) {
    return Center(
      child: Container(
        width: wt / 3,
        height: wt / 3,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: kActiveShadowColor,
            width: 5,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName(double wt) {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Poppins',
      color: Colors.white,
      fontSize: wt / 12,
      fontWeight: FontWeight.w800,
    );

    return Text(
      name,
      style: _nameTextStyle,
    );
  }

  Widget leftWidget(TextStyle _style, String txt) {
    return Text(
      txt,
      textAlign: TextAlign.center,
      style: _style,
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      letterSpacing: 1,
      color: Colors.white70,
      fontSize: 20.0,
    );

    return Container(

      padding: EdgeInsets.all(8.0),
      child: Text(
        email,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.4,
      height: 2.5,
      color: Colors.white,
      margin: EdgeInsets.only(top: 14.0),
    );
  }

  Widget _buildDetails(BuildContext context, double ht, double wt) {
    TextStyle detailsTextStyle = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Colors.white,
      fontSize: wt / 20.5,
    );

    TextStyle detailsLeftTextStyle = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Colors.white,
      fontSize: wt / 20.5,
    );
    var i = street.length;
    var l;
    if (i > 18) {
      l = ht / 28;
    } else {
      l = ht / 90;
    }
    return Container(

      padding: EdgeInsets.only(left: ht / 28, top: ht / 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              leftWidget(detailsLeftTextStyle, 'Mobile Number')
            ],
          ),
          SizedBox(width: wt / 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                leftWidget(detailsTextStyle, mobnum), 
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double ht = screenSize.height;
    double wt = screenSize.width;
    return MaterialApp(
      title: 'Save My Nation',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            body1: TextStyle(color: kBodyTextColor),
          ),
        primaryColor: kPrimaryColor,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: ht,
            width: double.infinity,
            decoration: bd,
            child: SafeArea(
              bottom: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: screenSize.width/ 10),
                  _buildProfileImage(screenSize.height, screenSize.width),
                  SizedBox(height: ht / 60),
                  _buildFullName(screenSize.width),
                  SizedBox(height: ht / 180),
                  _buildBio(context),
                  SizedBox(height: ht / 150),
                  _buildSeparator(screenSize),
                  SizedBox(height: wt / 20),
                  _buildDetails(context, ht, screenSize.width),
                  SizedBox(height: wt / 7),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: PreventCard(image: 'assets/cor.png',title: "Prepare, Don't Panic!",text:'Wash your hands. Use a tissue for coughs. Avoid touching your face.'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
