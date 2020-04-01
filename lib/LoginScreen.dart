import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_flutter_app_icons.dart';

import 'package:url_launcher/url_launcher.dart';

import 'Animation/FadeAnimation.dart';
import 'crud.dart';

import 'Settings.dart';

import 'Student/Student_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _myIDField = TextEditingController();
  TextEditingController _myPasswordField = TextEditingController();
  String username = null, password = null;
  crudMethods crudObj = new crudMethods();
  bool isload = false;
  int _state = 0;

  var userData;
  String real_password = null;
  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

  @override
  void initState() {
    //_tabController = new TabController(length: 2,);

// Find the Scaffold in the widget tree and use it to show a SnackBar.

    super.initState();
  }

  void GetData() async {
    if (username == null) {
      //print('object');
      //_showDialog();
      _showDialog('Error', 'Username Cant be Null', 'Try Again!');
    } else if (username != null) {
      //print('object');
      final snapShot = await Firestore.instance
          .collection('Student')
          .document(username.toUpperCase())
          .get();
      String snap = snapShot.toString();
      print(snap);
      print(snapShot);
      if (snapShot == null || !snapShot.exists) {
        _showDialog('Error', 'Username does not exist', 'Try Again!');
      } else {
        crudObj.getStudentdata(this.username.toUpperCase()).then((docs) {
          setState(() {
            userData = docs.documents[0].data;
            //print(userData)
            this.real_password = userData['Phone'];
            print(real_password);
            this.validate();
          });
        });
      }
    }
  }

  _launchURL() async {
    const url =
        'https://www.justdial.com/Mumbai/Rng-Digital-Solutions-Pvt-Ltd-Malad-East/022PXX22-XX22-191209174141-W3V6_BZDET';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchmail() async {
    await launch(
        "mailto:dakamihir@gmail.com?subject=Application%20Related&body=Hy,\bI Want To know More About Application Development");
  }

  _launchcall() async {
    await launch("tel:+91 76660 2936");
  }

  void validate() async {
    if (password != null) {
      print(password);
      if (real_password == password) {
        //Navigator.of(context).pop();
        setState(() {
          this._state = 0;
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => Student_Home(title: username)));
      } else {
        _showDialog('Error', 'Password is incorrect', 'Try Again');
      }
    } else {
      //_showDialog();
      _showDialog('Error', 'Enter Password', 'Try Again!');
    }
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return Center(
        child: new Text(
          "Login",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void _showDialog(String title, String content, String command) {
    // flutter defined function
    setState(() {
      this._state = 0;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          content: Text(content),
          //container
          actions: <Widget>[
            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(command))
          ],
        );
      },
    );
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    GetData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //Scaffold.of(context).showSnackBar(snackBar),

        backgroundColor: Colors.white,
        body: SingleChildScrollView(
                  child: Container(
            //height: MediaQuery.of(context).size.height,
                    child: Column(
              children: <Widget>[
             Container(
                    //height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/background.png'),
                                  fit: BoxFit.fill)),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 30,
                                width: 80,
                                height: 200,
                                child: FadeAnimation(
                                    1,
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/light-1.png'))),
                                    )),
                              ),
                              Positioned(
                                left: 140,
                                width: 80,
                                height: 150,
                                child: FadeAnimation(
                                    1.3,
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/light-2.png'))),
                                    )),
                              ),
                              Positioned(
                                right: 40,
                                top: 40,
                                width: 80,
                                height: 150,
                                child: FadeAnimation(
                                    1.5,
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/clock.png'))),
                                    )),
                              ),
                              Positioned(
                                child: FadeAnimation(
                                    1.6,
                                    Container(
                                      margin: EdgeInsets.only(top: 50),
                                      child: Center(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                        Stack(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 00, 0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                                  child: FadeAnimation(
                                      1.8,
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color.fromRGBO(
                                                      143, 148, 251, .2),
                                                  blurRadius: 20.0,
                                                  offset: Offset(0, 10))
                                            ]),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color:
                                                              Colors.grey[100]))),
                                              child: TextField(
                                                controller: _myIDField,
                                                onChanged: (value) {
                                                  setState(() {
                                                    username = value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Username",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[400])),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: _myPasswordField,
                                                onChanged: (value) {
                                                  setState(() {
                                                    password = value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Password",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[400])),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                                  child: FadeAnimation(
                                      2,
                                      Column(
                                        children: <Widget>[
                                          Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient: LinearGradient(colors: [
                                                    Color.fromRGBO(
                                                        143, 148, 251, 1),
                                                    Color.fromRGBO(
                                                        143, 148, 251, .6),
                                                  ])),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child:
                                                    //setUpButtonChild()
                                                    MaterialButton(
                                                        elevation: 100,
                                                        onPressed: () {
                                                          setState(() {
                                                            if (_state == 0) {
                                                              animateButton();
                                                            }
                                                          });
                                                        },
                                                        child: setUpButtonChild()),
                                              )
                                              /*Center(
	                              child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15),),
                                             )*/

                                              ),
                                          Container(
                                            child: Text(
                                              "Admin",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                FadeAnimation(
                                    1.5,
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (_) => Settings()));
                                        },
                                        child: Text(
                                          "Admin Login",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  Color.fromRGBO(143, 148, 251, 1)),
                                        ))),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                
                 Container(
                                    child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(
                          height: 20,
                          width: MediaQuery.of(context).size.width,
                          color: Color.fromRGBO(143, 148, 251, .7),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                _launchURL();
                              },
                              child: Text(
                                'Powered By RNG Digital Solutions',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                 ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
