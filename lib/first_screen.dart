import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:savemynation/Intro1.dart';
import 'package:savemynation/constant.dart';
import 'package:savemynation/loading.dart';
import 'package:savemynation/main.dart';
import 'package:savemynation/shared.dart';
import 'package:savemynation/sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:imei_plugin/imei_plugin.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _platformImei = 'Unknown';
  var sessionToken;
  var toastText;
  bool _validateM = false;
  String uniqueId = "Unknown";
  String mobnum;
  String firebaseToken;
  double latitude, longitude;
  final Location location = Location();
  bool _serviceEnabled;
  bool loading = false;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  void getLocation() async {
    print('called');
   /* _serviceEnabled = await location.serviceEnabled();
    print(_serviceEnabled);
    if (!_serviceEnabled ) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    } */
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    latitude = _locationData.latitude;
    longitude = _locationData.longitude;
  }

  Future<http.Response> postRequest() async {
    Map data = {
      'name': name,
      'mobile': mobnum,
      'email': email,
      'profileUrl': imageUrl,
      'firebaseToken': firebaseToken,
      'imei': uniqueId,
      'homeLatitude': latitude.toString(),
      'homeLongitude': longitude.toString(),
    };
    //encode Map to JSON
    //String body = json.encode(data);
    var sendResponse = await http.post(
        'https://tailermade.com/savemynation/api/v2/savemynation/registeruser',
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: data,
        encoding: Encoding.getByName("gzip"));
    print('result');
    //print(sendResponse.body);
    sessionToken = json.decode(sendResponse.body)['sessionToken'];
    print(sessionToken);
    toastText = json.decode(sendResponse.body)['messages'];
    print(toastText);
    //List<String> dttags = reBody != null ? List.from(reBody) : null;
    setState(() {
      print(sendResponse.body);
      //dtData = dttags;
    });
    return sendResponse;
  }
  SharedPreferences imeiPrefs;
  String storedIMEI;
  Future<void> initPlatformState() async {
    String platformImei;
    String idunique;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      /*platformImei =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true); */
      idunique = await ImeiPlugin.getId();
      print(platformImei);
      imeiPrefs = await SharedPreferences.getInstance();
      storedIMEI = imeiPrefs.getString('imei');

    } catch (e) {
      print(e);
      platformImei = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      print(idunique);
      _platformImei = platformImei;
      uniqueId = idunique;
      print('uniqy id');
      imeiPrefs.setString('imei', idunique);
      print(storedIMEI);

      print(uniqueId);
    });
  }

  @override
  void initState() {
    super.initState();
    //this.initPlatformState();

    initPlatformState();
    getLocation();
    setState(() {
      if (name == null) {
        print('no');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    firebaseCloudMessaging() async {
      String token = await _firebaseMessaging.getToken();
      var g = FieldValue.serverTimestamp();
      firebaseToken = token;
    }


    if (name == null) {
      print('no');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
    MediaQueryData queryData = MediaQuery.of(context);
    double wt = queryData.size.width;
    return loading
        ? LoadingIntro()
        : new Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: queryData.size.height,
                decoration: bd,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(height: wt/20),
                      Container(
                        child:Image(
                          image: AssetImage(
                            'assets/images/onboarding0.png',
                          ),
                          height: queryData.size.height/3,
                          width: wt,
                        ),
                      ),
                      SizedBox(height: wt/3),

                      Text(
                        'Hello $name !',
                        style: TextStyle(
                            fontSize: wt / 12,
                            fontFamily: "Poppins",
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: wt/18),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          cursorColor: Colors.pink,
                          autovalidate: true,
                          onChanged: (value) {
                            //_validateM = false;
                            // print(value);

                            _validateM = false;
                            mobnum = value;
                          },
                          style: TextStyle(color: Colors.white),

                          decoration:InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            //contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.white, width: 1.8)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.red, width: 1.2)),
                              labelText: 'Mobile Number',
                              errorText:
                              _validateM ? 'Invalid Mobile Number' : null),
                          ),

                      ),
                      SizedBox(
                        height: wt / 10,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          await firebaseCloudMessaging();
                          var i = 0;
                          setState(() {
                            //print(_permissionGranted);
                            if (mobnum == null || mobnum.length != 10) {
                              _validateM = true;
                              i = 1;
                            }
                          });
                          if (_permissionGranted != PermissionStatus.granted) {
                            getLocation();                          
                            if (_permissionGranted ==
                                PermissionStatus.deniedForever) {
                              Fluttertoast.showToast(
                                  msg: 'This app requires Location services. Kindly enable it in settings.',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.red,
                                  fontSize: wt / 28);
                            }
                          } else {
                            if (i == 0) {
                              setState(() {
                                loading = true;
                              });
                              if (mobnum != null &&
                                  name != null &&
                                  email != null &&
                                  firebaseToken != null &&
                                  uniqueId != null &&
                                  latitude.toString() != null &&
                                  longitude.toString() != null) {
                                if (mobnum.contains('.') || mobnum.contains(
                                    '-') || mobnum.contains(',') ||
                                    mobnum.contains(' ')) {
                                  setState(() {
                                    loading = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg:
                                      "Mobile Number should not contains special characteristics",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: kPrimaryColor,
                                      textColor: Colors.white,
                                      fontSize: wt / 25);
                                }
                                else {
                                  await postRequest().whenComplete(() async {
                                    SharedPreferences storePrefs =
                                    await SharedPreferences.getInstance();
                                    String deviceTokenShared =
                                    storePrefs.getString('sessionToken');
                                    String emailShared =
                                    storePrefs.getString('emailShared');
                                    storePrefs.setString(
                                        'sessionToken', sessionToken);
                                    storePrefs.setString('emailShared', email);
                                    SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                    prefs.setBool('first_time', false);
                                    print('bool value changed');

                                    SharedPreferences profilePrefs =
                                    await SharedPreferences.getInstance();
                                    profilePrefs.setString('userName', name);
                                    profilePrefs.setString('userMobile', mobnum);
                                    profilePrefs.setString('userEmail', email);
                                    profilePrefs.setString(
                                        'userImageUrl', imageUrl);

                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                  );
                                }
                              }

                            }
                          }
                        },
                        color: kPrimaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 30),
                          child: Text(
                            'Next',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),

                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
