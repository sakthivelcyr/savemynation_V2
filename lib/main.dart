import 'dart:async';
import 'package:savemynation/Intro1.dart';
import 'package:savemynation/constant.dart';
import 'package:savemynation/firebasenoti.dart';
import 'package:savemynation/grocery.dart';
import 'package:savemynation/intercity.dart';
import 'package:savemynation/interstate.dart';
import 'package:savemynation/profile_page.dart';
import 'package:savemynation/shared.dart';
import 'package:savemynation/support_us.dart';
import 'package:savemynation/tnpassWV.dart';
import 'package:savemynation/volunteer.dart';
import 'package:savemynation/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  //SystemChrome.setEnabledSystemUIOverlays([]);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Save My Nation',
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomePage': (BuildContext context) => new HomeScreen(), //Homepage
      '/WelcomePage': (BuildContext context) => new Login(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');
    String deviceTokenShared = prefs.getString('sessionToken');
    String emailShared = prefs.getString('emailShared');
    var _duration = new Duration(seconds: 2);
    if (firstTime != null && !firstTime) {
      // Not first time

      return new Timer(_duration, navigationPageHome);
    } else {
      // First time

      return new Timer(_duration, navigationPageWel);
    }
  }

  void navigationPageHome() {
    Navigator.of(context).pushReplacementNamed('/HomePage');
  }

  void navigationPageWel() {
    Navigator.of(context).pushReplacementNamed('/WelcomePage');
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double wt = screenSize.width;
    TextStyle ts = TextStyle(
      fontSize: wt / 10,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      letterSpacing: 1,
    );
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: bd,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child:Image(
                      image: AssetImage(
                        'assets/icons/icon.png',
                      ),
                      height: MediaQuery.of(context).size.width/3,

                    ),

                  ),
                  SizedBox(height: MediaQuery.of(context).size.width/10,),
                  Text(
                    'Save My Nation',
                    style: ts,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Save My Nation',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            body1: TextStyle(color: kBodyTextColor),
          )),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;
  bool isReplay = false;
  bool fCard = false;

  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
    new FirebaseNotifications().setUpFirebase();

  }


  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  String selectedValue = 'hi';
  String searchStatusMobile;
  String _text;
  var f = 0;
  _displayDialog(BuildContext context) async {
    bool _validateM = false;
    _text = '';
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            title: Text('Enter Phone Number'),
            content: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _text = value;
              },
              decoration: InputDecoration(
                hintText: "Phone Number",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.black, width: 1.5)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.red, width: 1.2)),
                errorText: _validateM ? 'Invalid Phone Number' : null,
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Done'),
                onPressed: () {
                  setState(() {
                    print(_text.toString());
                    if (_text.toString().length != 10 ||
                        _text.toString() == null) {
                      setState(() {
                        _validateM = true;
                        Fluttertoast.showToast(
                            msg: 'Invalid Mobile Number',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 14);
                      });
                    } else {
                      searchStatusMobile = _text.toString();

                      Fluttertoast.showToast(
                          msg: searchStatusMobile,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 14);
                      f = 1;
                      Navigator.of(context).pop();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  Widget getWidget(double ht, double wt, LinearGradient lg, int i, String tit) {
    return InkWell(
      onTap: () {
        print(i);
        if (i == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InterState()),
          );
        }
        if (i == 2)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InterCity()),
          );
        if (i == 3)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Grocery()),
          );
        if (i == 4)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SupportUs()),
          );
        if (i == 5)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Volunteer()),
          );
        if (i == 6)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyWebView(
              title: "TN ePass",
              selectedUrl: "https://tnepass.tnega.org/",
            )),
          );
      },
      child: Container(
        height: wt / 4.2,
        width: wt / 4.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black87, width: 1.5),
          //gradient: lg,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getIcon(i, ht, wt),
            SizedBox(height:wt/100),
            Text(tit,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: wt / 35,
                    fontFamily: 'Poppins')),
          ],
        ),
        //color: Colors.orange,
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            elevation: 5,
            contentPadding: EdgeInsets.all(20),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
              SizedBox(width: 16),
            ],
          ),
        ) ??
        false;
  }

  Widget getIcon(int i, double ht, double wt) {
    if (i == 1)
      return Image.asset(
        'assets/v2.png',
        height: wt / 16,
        color: Colors.black,
        width: wt / 16,
      );
    if (i == 2)
      return Image.asset(
        'assets/i1.png',
        height: wt / 12,
        color: Colors.black87,
        width: wt / 12,
      );
    if (i == 3)
      return Image.asset(
        'assets/i3.png',
        height: wt / 14,
        color: Colors.black87,
        width: wt / 14,
      );
    if (i == 4)
      return Image.asset(
        'assets/i4.png',
        height: wt / 14,
        color: Colors.black,
        width: wt / 14,
      );
    if (i == 5)
      return Image.asset(
        'assets/i7.png',
        height: wt / 12,
        color: Colors.black87,
        width: wt / 12,
      );
    if (i == 6)
      return Image.asset(
        'assets/pass.png',
        height: wt / 10,
        color: Colors.black87,
        width: wt / 10,
      );
  }

  LinearGradient lg1 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.green[700], Colors.green[400], Colors.green[700]],
  );

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double ht = queryData.size.height;
    double wt = queryData.size.width;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: <Widget>[
              MyHeader(
                image: "assets/icons/Drcorona.svg",
                textTop: "All you need",
                textBottom: "is stay at home.",
                offset: offset,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Dashboard\n",
                                style: kTitleTextstyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 30,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              getWidget(ht, wt, lg1, 6, 'TN ePass'),
                              getWidget(ht, wt, lg1, 1, 'Inter State Travel Assistant'),
                              getWidget(ht, wt, lg1, 2, 'Inter City Travel Assistant'),

                            ],
                          ),
                          SizedBox(
                            height: wt / 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              getWidget(ht, wt, lg1, 3, 'Grocery/Food/Medical'),
                              getWidget(ht, wt, lg1, 4, 'Support Us'),
                              getWidget(ht, wt, lg1, 5, 'Volunteer'),

                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: wt / 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Your Profile",
                          style: kTitleTextstyle,
                        ),
                        InkWell(
                          onTap: () async {
                            SharedPreferences profilePrefs =
                                await SharedPreferences.getInstance();
                            String name = profilePrefs.getString('userName');
                            String mobile =
                                profilePrefs.getString('userMobile');
                            String email = profilePrefs.getString('userEmail');
                            String url = profilePrefs.getString('userImageUrl');
                            print(url);
                            SharedPreferences storePrefs =
                                await SharedPreferences.getInstance();
                            String session =
                                storePrefs.getString("sessionToken");
                            print(session);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfilePage(
                                        url,
                                        name,
                                        email,
                                        'professional',
                                        'state',
                                        'street',
                                        'district',
                                        mobile)));
                          },
                          child: Text(
                            "See details",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: wt / 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PreventCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.width/2.5,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width/2.5,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
            Image.asset(image,width: MediaQuery.of(context).size.width/2.5,height: MediaQuery.of(context).size.width,alignment: Alignment.center,),
            Positioned(
              left: 110,
              top: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                height: 136,
                width: MediaQuery.of(context).size.width/1.7 ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right:10.0),
                        child: Text(
                          text,
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

