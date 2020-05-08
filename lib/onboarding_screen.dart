import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savemynation/first_screen.dart';
import 'package:savemynation/shared.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
  final kTitleStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins',
    fontSize: 23.0,
    fontWeight: FontWeight.bold,

  );

  final kSubtitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 19.0,
  );

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double ht = queryData.size.height;
    double wt = queryData.size.width;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Center(
          child: SafeArea(
            child: Container(
              decoration: bd,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: wt/20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: ht/1.3,
                      child: PageView(
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(wt/21.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/onboarding0.png',
                                    ),
                                    height: wt/1.7,
                                    width: wt,
                                  ),
                                ),
                                SizedBox(height: wt/7.0),
                                Text(
                                  'Student Initiative Community',
                                  style: kTitleStyle,
                                ),
                                SizedBox(height: wt/15.0),
                                Text(

                                  'Save My Nation is a student community open source initiative to migrate the impact of COVID-19 using technology as a tool.',
                                  style: kSubtitleStyle,
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(wt/21.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/onboarding1.png',
                                    ),
                                    height: wt/1.7,
                                    width: wt,
                                  ),
                                ),
                                SizedBox(height: wt/7.0),
                                Text(
                                  'Live your life smarter with us!',
                                  style: kTitleStyle,
                                ),
                                SizedBox(height: wt/15.0),
                                Text(
                                  'We are creating platform for victims, government and volunteers and focus on major problems like migration, supply of material to affected victims.',
                                  style: kSubtitleStyle,
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                    _currentPage != _numPages
                        ? Expanded(
                            child: Align(
                              alignment: FractionalOffset.bottomRight,
                              child: FlatButton(
                                onPressed: () {
                                  if(_currentPage==1) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return FirstScreen();
                                        },
                                      ),
                                    );
                                  }
                                  else {
                                    _pageController.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  }

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Next',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                    SizedBox(width: wt/40.0),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Text(''),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      /*bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: wt/6,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  print('Get started');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return FirstScreen();
                      },
                    ),
                  );
                  },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: wt/40.0),
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Color(0xFF5B16D0),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),*/
    );
  }
}
