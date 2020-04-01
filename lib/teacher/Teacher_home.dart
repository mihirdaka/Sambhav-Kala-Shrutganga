import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../sexy_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Student/Alerts.dart';
import 'Sutra.dart';
import '../crud.dart';
import '../Admin/Cr_Db.dart';
import 'package:tatvagyankendra/Attendance/Attendance_Home.dart';
import 'Stavan.dart';

void main() => runApp(MyApp(String));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
    var tid;
    MyApp(this.tid);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      
      debugShowCheckedModeBanner: false,
      home: Teacher_Home(tid: this.tid),
    );
  }
}

class Teacher_Home extends StatefulWidget {
 
  Teacher_Home({Key key, this.tid}) : super(key: key);

  
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String tid;

  @override
  _Teacher_HomeState createState() => _Teacher_HomeState(this.tid);
}

class _Teacher_HomeState extends State<Teacher_Home> {
 var tid;
  String barcode;

 _Teacher_HomeState(this.tid);
 crudMethods crudObj = new crudMethods();

var userData;
var username;
var name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(tid);
   
    }
  
  addAttendance()async{
          
                        DateTime now = new DateTime.now();
                        DateTime date = new DateTime(now.year, now.month, now.day);
                          //print(DateTime.now());
                          print(date);
                          crudObj.teacherattendanceData({
                            
                            'Attendance' : date,
                            'Tid' : tid.toUpperCase()
                            //'Uid' : _uid*/
                          }).then((result){
                            //Navigator.of(context).pushReplacementNamed('/HomePage');
                             MessageBox('Success', 'You Are Marked As Present', 'OK'); 

                            }).catchError((e){
                          // showError(e);
                            //MessageBox('Error', e, 'Try Again');
                            }
                            );
                        
                  
         //print(barcode);
    }
    void MessageBox(String title,String des,String action){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
  title: Text(title),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
  content:  Text(des),
  //container
  actions: <Widget>[
    MaterialButton(onPressed: (){
          Navigator.of(context).pop();
        },
            child: Text(action))

  ],
);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    List<String> itemNames = [
      'Update/View Sutra',
      'Attendance',
      'Updates',
      'View Kavya History',
      'CR/DB Coins'
    ]; //name of each individual tile

    return Scaffold(
     // backgroundColor: invfertInvertColorsStrong(context),
       appBar: AppBar(
      title:
      Text('Teacher'),
    
     
    ),
    //floatingActionButton: FloatingActionButton(onPressed: null
   floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>addAttendance(),
        elevation: 10,
        label : Text('Mark Yourself Present'),
        //icon: Icon(Icons.camera_alt),
      
        //child: IconButton(icon: Icon(Icons.scanner), onPressed: null),
      
      ),
       //extendBody: true,
       extendBodyBehindAppBar: false,
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    backgroundColor: Colors.white,
    body:  Container(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 2.5,
                children: List.generate(
                  itemNames.length,
                  (index) {
                    return Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Hero(
                          tag:
                              'tile$index', 
                          child: SexyTile(),

                        ),
                        
                        Container(
                          
                         // alignment: MainAxisAlignment.center,
                          margin: EdgeInsets.all(15.0),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Hero(
                                    
                                    tag: 'title$index',
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        '${itemNames[index]}',
                                         style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              splashColor: Colors.red,
                              borderRadius: BorderRadius.circular(15.0),
                              onTap: (){
                               Navigator.push<dynamic>(context, CupertinoPageRoute<dynamic>(
                                 builder: (BuildContext context){
                                    if (index == 1) {
                                        return Attendance_Home();
                                      }
                                     else if(index ==0){
                                        return Sutra();
                                      }else if (index==2) {
                                          return Updates_Page();
                                      }else if(index==3){
                                        return Stavan();
                                      }else if(index==4){
                                        return Cr_Db();
                                      }
                                    
                                    }
                              
                            )
                            
                            );
                            }
                              
                               
                        ),
                        )
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
     
    );
  }
}
