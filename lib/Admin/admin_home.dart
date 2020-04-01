import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tatvagyankendra/teacher/Update_Sutra.dart';
import '../sexy_tile.dart';
import 'Cr_Db.dart';
import 'check_Teacher_Attendance.dart';
import 'Add_teacher.dart';
import 'package:tatvagyankendra/Attendance/Teacher_Attendance.dart';
//import 'admin_login.dart';
import 'Post_message.dart';
import 'package:tatvagyankendra/Attendance/Attendance_Home.dart';
import 'Add_student.dart';
import 'Edit_Record.dart';
import 'Sort.dart';
import 'check_Attendance.dart';
import '../teacher/Update_Sutraoption.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Admin_Home(title: 'Flutter Demo Home Page'),
    );
  }
}

class Admin_Home extends StatefulWidget {
  Admin_Home({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _Admin_HomeState createState() => _Admin_HomeState();
}

class _Admin_HomeState extends State<Admin_Home> {
  @override
  Widget build(BuildContext context) {
    List<String> itemNames = [
      'Add Student',
      'Add Teacher',
      'Edit Student Record',
      'Check Student Attendance',
      'Check Teacher Attendance',
      'CR/DB Points',
      'Mark Attendance(Student)',
      'Mark Attendance(Teacher)',
      'Post Message',
      'Sort(Get Top Student)',
      'Update Gatha',
    ]; //name of each individual tile

    return Scaffold(
        // backgroundColor: invertInvertColorsStrong(context),

        appBar: AppBar(
          title: Text('Admin'),
          backgroundColor: Color.fromRGBO(143, 148, 251, 6),

          actions: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Image.asset(
                'images/logo.png',
              ),
            )
          ],

          //previousPageTitle: 'Home',
        ),
        backgroundColor: Colors.white,
        body: Container(
            child: GridView.builder(
                padding: EdgeInsets.all(10),
                itemCount: itemNames.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                      child: new Card(
                        elevation: 15.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: new Center(
                          //alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Container(child: new Text('${itemNames[index]}',softWrap: true,style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),)),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                         Navigator.push<dynamic>(context,
                                      MaterialPageRoute<dynamic>(
                                          builder: (BuildContext context) {
                                    if (index == 0) {
                                      return Add_student();
                                    } else if (index == 1) {
                                      return Add_Teacher();
                                    } else if (index == 2) {
                                      return Edit_record();
                                    } else if (index == 3) {
                                      return check_Attendance();
                                    } else if (index == 4) {
                                      return check_Teacher_Attendance();
                                    } else if (index == 5) {
                                      return Cr_Db();
                                    } else if (index == 6) {
                                      return Attendance_Home();
                                    } else if (index == 7) {
                                      return tAttendance_Home();
                                    } else if (index == 8) {
                                      return Post_message();
                                    } else if (index == 9) {
                                      return Attendance_sort();
                                    }else if(index==10){
                                      return Settings();
                                    }
                                  }));
                      });
                })));
  }
}
