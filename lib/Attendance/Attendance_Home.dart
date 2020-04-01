import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../sexy_tile.dart';
import '../crud.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:cloud_firestore/cloud_firestore.dart';
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
      home: Attendance_Home(tid: this.tid),
    );
  }
}

class Attendance_Home extends StatefulWidget {

 
  Attendance_Home({Key key, this.tid}) : super(key: key);

  
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String tid;
  

  @override
  _Attendance_HomeState createState() => _Attendance_HomeState(this.tid);
}

class _Attendance_HomeState extends State<Attendance_Home> {
 var tid;
 String barcode;
 _Attendance_HomeState(this.tid);
 crudMethods crudObj = new crudMethods();

var userData;
var username;
var name;
  @override
  

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

  Future scan() async{
          String barcode = await scanner.scan();
          setState(() => this.barcode = barcode);
          addAttendance();
  }
  addAttendance()async{
          final snapShot = await Firestore.instance
                  .collection('Student')
                  .document(barcode.toUpperCase())
                  .get();
                  String snap = snapShot.toString();
                  print(snap);
                  print(snapShot);
                  if (snapShot == null || !snapShot.exists) {
                    // Document with id == docId doesn't exist.
                       MessageBox('Error', 'Student Id Does Not Exist', 'Try Again'); 
                  }else{
                        DateTime now = new DateTime.now();
                        DateTime date = new DateTime(now.year, now.month, now.day);
                          //print(DateTime.now());
                          print(date);
                          crudObj.attendanceData(barcode.toUpperCase(),{
                            
                            'Attendance' : date,
                            
                            //'Uid' : _uid*/
                          }).then((result){
                            //Navigator.of(context).pushReplacementNamed('/HomePage');
                             MessageBox('Success', 'Student Marked As Present', 'OK'); 

                            }).catchError((e){
                          // showError(e);
                            MessageBox('Error', e, 'Try Again');
                            }
                            );
                        
                  }   
         //print(barcode);
    }

  @override
  Widget build(BuildContext context) {
    //f each individual tile

    return Scaffold(
     // backgroundColor: invertInvertColorsStrong(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>scan(),
        elevation: 10,
        label : Text('Scan'),
        icon: Icon(Icons.scanner),
      
        //child: IconButton(icon: Icon(Icons.scanner), onPressed: null),
      
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
      title:
      Text('Attendance'),
      
     
    ),
    
    backgroundColor: Colors.white,
    body:  Container(
      margin: EdgeInsets.all(30),
      child: Card(
        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  ),
       elevation: 15,
       child: Column(
         
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Container(
          margin: EdgeInsets.fromLTRB(25, 20, 25, 0),
             
             child:TextField(
                                      
                                       onChanged: (value){
                                        setState(() {
                                        barcode = value; 
                                        });
                                      },
                                      style: TextStyle(
                                        color: Colors.black87
                                      ),
                                      cursorColor: Colors.black26,
                                       decoration: InputDecoration(
                                          labelText: 'Student ID',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0)
                                          )
                                        ),
                                                    
                                      
                                     
                                      enableSuggestions: true,
                                      
                                     ),
           ),
           Container(
              margin: EdgeInsets.fromLTRB(25, 20, 25, 0),

	                        height: 50,
	                        decoration: BoxDecoration(
	                          borderRadius: BorderRadius.circular(10),
	                          
                      
	                        ),
	                        child:
                          SizedBox(
                            width: double.infinity,
                            child:
                            //setUpButtonChild() 
                            MaterialButton(
                               shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                              color: Colors.blue,
                              elevation: 100,
                              onPressed:() {
                                addAttendance();
                              },
                              child: Text('Add')
                               
                            ),
                          ) 
                           /*Center(
	                            child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15),),
                           )*/
                        
	                          
	                      
                    
	                      
           )
         ],
       ),
      ),
     ),
     
    );
  }
}
