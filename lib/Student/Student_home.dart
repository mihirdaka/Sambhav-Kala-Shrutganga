import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../sexy_tile.dart';
import 'qr.dart';
import 'Namawali.dart';
import 'History.dart';
import '../crud.dart';
import 'Alerts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'othergatha.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'Sutra.dart';
//void main() => runApp(MyApp());

class Student_Home extends StatefulWidget {
  Student_Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Student_HomeState createState() => _Student_HomeState(title);
}

class _Student_HomeState extends State<Student_Home> {
  String title;
  _Student_HomeState(this.title);
  AnimationController controller;

  Animation animation;

  double beginAnim = 0.0;
  double endAnim = 1.0;

  crudMethods crudObj = new crudMethods();
  String username = 'user';
  String study = 'Null';
  String age = '0';
  var user;
  String photourl =
      'https://firebasestorage.googleapis.com/v0/b/test-8b852.appspot.com/o/user.png?alt=media&token=37cc99f4-c243-4fcb-9f31-4ebb4df718bf';
  String percent = '0';
  var att;
  int count;
  var attendanceval;
  var userData;
  double per = 0.0;
  double aper = 0.0;

  int coins = 0;
  int points = 0;

  @override
  void initState() {
    print(title);

    // TODO: implement initState
    super.initState();
    updateData();
  }

  updateData() {
    crudObj.getStudentdata(this.title.toUpperCase()).then((docs) {
      setState(() {
        print(title);
        userData = docs.documents[0].data;
        print(userData);
        this.coins = userData['Coins'];
        this.points = userData['Points'];
        this.photourl = userData['PhotoUrl'];
        this.user = userData;
        this.username = user['Name'];
        this.study = user['Study'];
        this.age = user['Age'];
        if (photourl == null) {
          setState(() {
            this.photourl =
                'https://firebasestorage.googleapis.com/v0/b/test-8b852.appspot.com/o/user.png?alt=media&token=37cc99f4-c243-4fcb-9f31-4ebb4df718bf';
          });
        }

        //print(userData)
        //this.real_password = userData['password'];
        //print(real_password);
        //this.validate();
      });
    });

    crudObj.getAttendancedata(this.title.toUpperCase()).then((docs) {
      setState(() {
        userData = docs.documents[0].data;
        //print(userData);
        //var attendance = userData['Attendance'];
        print(userData['Attendance']);
        att = userData['Attendance'];
        this.aper = att.length / 130;
        //isgot=true;
        attendanceval = att.length;

        print(attendanceval);
      });
    });
    crudObj.getSutradata(this.title.toUpperCase()).then((docs) {
      setState(() {
        userData = docs.documents[0].data;
        this.count = userData['Count'];
        this.per = count / 72;
        // percent=per*100.toString();
        print(per);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 2.0,
            backgroundColor: Colors.white,
            title: Text('Dashboard',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 30.0)),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: updateData,
                iconSize: 30,
                color: Colors.red,
              )
            ],
            leading: IconButton(
              icon: Icon(Icons.scanner),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => QR(title)));
              },
              iconSize: 30,
              color: Colors.red,
            )),
        body: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
            _buildTile(
              Container(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              heightFactor: 1,
                              child: Image.network(photourl),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             
                      
                                    Flexible(
                                        child: Container(
                               

                                            child: Text('$username',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700)))),
                                 
                              
                              Text('Study : ${study}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      )),
                              Text('Age : ${age}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      )),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),

              // {redirecttonamawali(context)}
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Text('Sutra Completed'),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: LinearPercentIndicator(
                              //width: 140.0,
                              lineHeight: 15.0,
                              percent: per,
                              //center: Text('${per*100.toStringAsFixed(2)}'),
                              //trailing: Icon(Icons.mood),
                              animation: true,
                              animationDuration: 3000,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              backgroundColor: Colors.blueGrey,
                              progressColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Text(
                          '$count/72',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan),
                        ),
                      )
                    ]),
              ),
              // {redirecttonamawali(context)}
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Coins Earned',
                              style: TextStyle(color: Colors.blueAccent)),
                          Text(coins.toString(),
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 34.0))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Points Earned',
                              style: TextStyle(color: Colors.blueAccent)),
                          Text(points.toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 34.0))
                        ],
                      ),
                      Material(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(24.0),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(Icons.timeline,
                                color: Colors.white, size: 30.0),
                          )))
                    ]),
              ),
              // {redirecttonamawali(context)}
            ),
            _buildTile(
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Namawali(title, coins)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Material(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(24.0),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.library_books,
                                    color: Colors.white, size: 30.0),
                              ))),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Niyamawali',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30.0)),
                              Text('Today',
                                  style: TextStyle(color: Colors.blueAccent)),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),

              // {redirecttonamawali(context)}
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: CircularPercentIndicator(
                          radius: MediaQuery.of(context).size.height / 6,
                          lineWidth: 13.0,
                          animation: true,
                          animationDuration: 3000,
                          percent: aper,
                          center: new Text(
                            "${attendanceval}/130",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          footer: new Text(
                            "Attendance",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17.0),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.purple,
                        ),
                      ),
                    ]),
              ),
              // {redirecttonamawali(context)}
            ),
            _buildTile(InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Updates_Page()));
                },
                child: Stack(children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Material(
                                color: Colors.amber,
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.notifications,
                                      color: Colors.white, size: 30.0),
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                            Text('Alerts',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.0)),
                            Text('All ',
                                style: TextStyle(color: Colors.black45)),
                          ]),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: new Container(
                      padding: EdgeInsets.all(2),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 15,
                        minHeight: 10,
                      ),
                      child: Text(
                        'Updates',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ]))),
            _buildTile(
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Coin_History(title, coins)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Material(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(24.0),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.history,
                                    color: Colors.white, size: 30.0),
                              ))),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Coin History',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.0)),

                              // Text('Today', style: TextStyle(color: Colors.blueAccent)),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),

              // {redirecttonamawali(context)}
            ),
            _buildTile(
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Sutra(title)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Sutra History',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.0)),

                              // Text('Today', style: TextStyle(color: Colors.blueAccent)),
                            ],
                          ),
                          Material(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(24.0),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.history,
                                    color: Colors.white, size: 30.0),
                              ))),
                        ]),
                  ),
                ),
              ),

              // {redirecttonamawali(context)}
            ),
            _buildTile(
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => OtherGatha(title)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Kavya History',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.0)),

                              // Text('Today', style: TextStyle(color: Colors.blueAccent)),
                            ],
                          ),
                          Material(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(24.0),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.history,
                                    color: Colors.white, size: 30.0),
                              ))),
                        ]),
                  ),
                ),
              ),

              // {redirecttonamawali(context)}
            ),
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 150.0),
            StaggeredTile.extent(2, 80.0),
            StaggeredTile.extent(2, 110.0),
            StaggeredTile.extent(2, 120.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(2, 110.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
          ],
        ));
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap
                : () {
                    print('Not set yet');
                  },
            child: child));
  }
}
