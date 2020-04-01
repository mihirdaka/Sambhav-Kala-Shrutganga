import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'package:flutter/material.dart';
import '../sexy_tile.dart';
import '../crud.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: check_Teacher_Attendance(title: 'Flutter Demo Home Page'),
      
    );
  }
}

class check_Teacher_Attendance extends StatefulWidget {
  check_Teacher_Attendance({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _check_Teacher_AttendanceState createState() => _check_Teacher_AttendanceState();
}

class _check_Teacher_AttendanceState extends State<check_Teacher_Attendance> {

    bool isconnected=true;
   crudMethods crudObj = new crudMethods();
  var userData;
  
  int attendanceval =0;
  var att;
  bool isgot= false;
  TextEditingController _myPhoneField = TextEditingController();
  TextEditingController _myNameField = TextEditingController();
  TextEditingController _myIDField = TextEditingController();
  TextEditingController _myStudyField = TextEditingController();
  TextEditingController _mySageField = TextEditingController();

  String _email,_password,_name,_phone,_sage,_sid,_study;
  String _photourl = "https://firebasestorage.googleapis.com/v0/b/test-8b852.appspot.com/o/user.png?alt=media&token=fc2e9d77-c9c9-4621-b781-44371cb4c4ff";



  void MessageBox(String title,String des,String action){
     showCupertinoDialog<dynamic>(
                                    context: context,
                                    builder: (BuildContext context) => CupertinoAlertDialog(

                                      title: Text(title),
                                      content: Text(des),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                            child:  Text(action),
                                            onPressed: (){

                                               Navigator.pop(context,action); 
                                            }
                                         )
                                      ],
                                      

                                    )
                                  );

  }

Future _checkid() async{
   if(_myIDField.text.isNotEmpty){
     print('in');
     print(_sid);
                final snapShot = await Firestore.instance
                  .collection('Teacher.Attendance')
                  .document(_sid.toUpperCase())
                  .get();
                  String snap = snapShot.toString();
                  print(snap);
                  print(snapShot);
                  if (snapShot == null || !snapShot.exists) {
                    MessageBox('Error', 'Id Does Not Exist ', 'Try again');
                  }else{
                    print(_sid);
                        crudObj.getTeacherAttendancedata(this._sid.toUpperCase()).then((docs){
                          setState(() {
                            userData = docs.documents[0].data;
                            //print(userData);
                            //var attendance = userData['Attendance'];
                            print(userData['Attendance']);
                             att = userData['Attendance'];
                            isgot=true;
                            print(attendanceval);
                          });
                        });
                  }
   }else{
     MessageBox('Error', 'Enter ID', 'Try again');
   }
}

Widget _myListView(BuildContext context) {

      return  ListView.builder(
        //reverse: true,
            itemCount: att.length,
            itemBuilder: (context, index) {
              return Card( //                           <-- Card widget
                elevation: 5,
                child: ListTile(
                  leading: Icon(Icons.present_to_all),
                  title: Text(att[att.length-index-1]),
                ),
              );
            },
      );
    }
  

  @override
  Widget build(BuildContext context) {
 double height = MediaQuery.of(context).size.height;
    return Scaffold(
     // backgroundColor: invertInvertColorsStrong(context),
      
      appBar: AppBar(
      
      title:
      Text('Teacher Attendance Record'),
            backgroundColor: Color.fromRGBO(143, 148, 251, 6),

       actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Image.asset('images/logo.png',),
              
              
            )
            
        ],
      

     
    ),
    backgroundColor: Colors.white,
    body: Container(
      margin: EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  ),
       elevation: 15,
       child: SingleChildScrollView(

      child: Container(
       // width: MediaQuery.of(context).size.height,
        child: Column(
             
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               Container(
              margin: EdgeInsets.fromLTRB(25, 20, 25, 0),
                 
                 child:TextField(
                   controller: _myIDField,
                            onChanged: (value){
                                      setState(() {
                                            this._sid = value; 
                                            });
                                          },
                                          style: TextStyle(
                                            color: Colors.black87
                                          ),
                                          cursorColor: Colors.black26,
                                           decoration: InputDecoration(
                                              labelText: 'Teacher ID',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5.0)
                                              )
                                            ),
                                                        
                                          
                                         
                                          enableSuggestions: true,
                                          
                                         ),
               ),
               Container(
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),

	                        //height: 50,
	                        decoration: BoxDecoration(
	                          borderRadius: BorderRadius.circular(10),
	                          
                          
	                        ),
	                        child:
                             
                                MaterialButton(
                                   shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                  color: Colors.blue,
                                  elevation: 100,
                                  onPressed:() {
                                    _checkid();
                                  },
                                  child: Text('Search')
                                   
                                ),
                              
                               /*Center(
	                            child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15),),
                               )*/

               ),
               Divider(
                 color : Colors.black38
               ),
                Center(
                 
                    child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                             // crossAxisAlignment: CrossAxisAlignment.start,
                            
                              children: <Widget>[
                                Container(
                                  
                                  child: isgot
                                  ?Container(
                                    child: Column(
                                      children: <Widget>[
                                          Text('Total Days Present : ${att.length}',style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                          ),),
                                          SingleChildScrollView(
                                            //padding: const EdgeInsets.all(8.0),
                                              scrollDirection: Axis.vertical,
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 8),
                                              child: 
                                            _myListView(context),
                                            height: MediaQuery.of(context).size.height-300,
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                  :Text('')
                                ),
                                ])
,
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
