import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'sexy_tile.dart';
import 'package:tatvagyankendra/Admin/admin_home.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:tatvagyankendra/Student/Student_home.dart';
import 'package:tatvagyankendra/teacher/Teacher_home.dart';
//import 'teacher/Teacher_Login.dart';
import 'Animation/FadeAnimation.dart';
import 'crud.dart';
import 'crud.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  TabController _tabController;
  var userData;
  int _state=0;
  int _cIndex=0;
  String username=null,password=null,real_password;
  String a_username=null,a_password=null;

 crudMethods crudObj = new crudMethods();
  TextEditingController _myIDField = TextEditingController();
  TextEditingController _myPasswordField = TextEditingController();
   TextEditingController _myAIDField = TextEditingController();
  TextEditingController _myAPasswordField = TextEditingController();
  
 bool isload=false;
 //int _state=0;   







 Widget setUpButtonChildT() {
   //print(_state);
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



  void animateButtonT() {
    setState(() {
      _state = 1;
      print(_state);
    });

  GetData();
}


   //name of each individual tile
  
   
   Widget admin_login(){
     //print(index);
     return Container(
       child:Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text('Admin Login',style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(height: 30,),

                    FadeAnimation(1.8, Container(
                      
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        
                        color:Color.fromRGBO(246, 235, 255,1),

                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(213, 174, 245,.8),
                            blurRadius: 20.0,
                            offset: Offset(0, 10)
                          )
                        ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[100]))
                            ),

                            child: TextField(
                           decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                            )
                          ),
                          onChanged: (input) {
                            this.a_username=input;
                          },
                          controller: _myAIDField,
                        ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child:TextField(
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                            )
                          ),
                          onChanged: (input) {
                            this.a_password=input;
                          },
                          controller: _myAPasswordField,
          ),
                          )
                        ],
                      ),
                    )),
                    SizedBox(height: 40,),
                    FadeAnimation(2, Column(
                      children: <Widget>[
                       
                       Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ]
                            )
                      
                          ),
                          child:
                          SizedBox(
                            width: double.infinity,
                            child:
                            //setUpButtonChild() 
                            MaterialButton(
                              
                              elevation: 100,
                              onPressed:() {
                                 if(a_username=='admin5'&&a_password=='admin5'
                                    ||a_username=='admin1'&&a_password=='admin1'
                                    || a_username=='admin2'&&a_password=='admin2'
                                    || a_username=='admin3'&&a_password=='admin3'
                                    || a_username=='admin4'&&a_password=='admin4'
                                    || a_username=='svjtkpathshala@gmail.com'&&a_password=='9791085311'
                                  ){
                                    Navigator.push(context,  
                                    MaterialPageRoute(
                                    builder: (_) => Admin_Home()));
                                  }else{
                                    _showDialog('Error', 'Username or password is incorrect', 'Try Again!');
                                  }
                              },
                              child: Text('Login',style: TextStyle(color:Colors.white,
                              fontSize: 16.0,
                              
                              ),)
                               
                            ),
                          ) 
        
                        ),
                        
                      ],
                    )
     )])));
   }
   
   
   

 @override
  void initState() {
    //_tabController = new TabController(length: 2,);
    super.initState();
  }
  
  void GetData()async{
    if(username!=null&&password!=null){
      final snapShot = await Firestore.instance
                  .collection('Teacher')
                  .document(username.toUpperCase())
                  .get();
                  String snap = snapShot.toString();
                  print(snap);
                  print(snapShot);
                  if (snapShot == null || !snapShot.exists) {
                      _showDialog('Error', 'Teacher does not exist', 'Try Again');
                  }else{
                      crudObj.getTeacherdata(this.username.toUpperCase()).then((docs){
                          setState(() {
                            userData = docs.documents[0].data;
                            //print(userData)
                            real_password=userData['password'];
                            print(real_password);
                            this.validate();
                          });
                        });
                  }

    }else{
      print(username);
      _showDialog('Error', 'Enter username and password', 'Try Again');
    }
    }

  void _showDialog(String title,String content,String command) {
    // flutter defined function
    setState(() {
      this._state=0;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
  title: Text(title),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
  content:  Text(content),
  //container
  actions: <Widget>[
    MaterialButton(onPressed: (){
          Navigator.of(context).pop();
        },
            child: Text(command))

  ],
);
      },
    );
  }

    void validate()async{
     if(real_password==password){
                                   setState(() {
            this._state=0;
          });
                                    Navigator.push(context,  
                                    CupertinoPageRoute(
                                    builder: (_) => Teacher_Home(tid: this.username,)));
            }

            else{
             _showDialog('Error', 'Password is incorrect', 'Try Again');
  }
  }
  
  Widget callPages(int _page){
    switch (_cIndex) {
      case 0:
       return Container(
         child: SingleChildScrollView(
           child: teacher_login()
         )
       );
        break;
      case 1:
       return Container(
         child: SingleChildScrollView(
           child: admin_login()
         )
       );
        break;
      
      
    }
  }
   Widget teacher_login(){
     //print(index);
    return Container(
       child:Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text('Teacher Login',style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(height: 30,),

                    FadeAnimation(1.8, Container(
                      
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        
                        color:Color.fromRGBO(246, 235, 255,1),

                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(213, 174, 245,.8),
                            blurRadius: 20.0,
                            offset: Offset(0, 10)
                          )
                        ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[100]))
                            ),

                            child: TextField(
                           decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                            )
                          ),
                          onChanged: (input) {
                            setState(() {
                              this.username=input;
                            });
                          },
                          controller: _myIDField,
                        ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child:TextField(
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                            )
                          ),
                          onChanged: (input) {
                            setState(() {
                              this.password=input;
                            });
                          },
                          controller: _myPasswordField,
          ),
                          )
                        ],
                      ),
                    )),
                    SizedBox(height: 40,),
                    FadeAnimation(2, Column(
                      children: <Widget>[
                       
                       Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ]
                            )
                      
                          ),
                          child:
                          SizedBox(
                            width: double.infinity,
                            child:
                            //setUpButtonChild() 
                            MaterialButton(
                              
                              elevation: 100,
                              onPressed:() {
                                setState(() {
                                  if (_state == 0) {
                                    animateButtonT();
                                  }
                                });
                              },
                              child: setUpButtonChildT()
                               
                            ),
                          ) 
        
                        ),
                        
                      ],
                    )
     )])));
   }
   
   
  @override
  Widget build(BuildContext context) {

  
    return  Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _cIndex,
        items:  
        [
          BottomNavigationBarItem(icon: Icon(Icons.ondemand_video),title: Text('Teacher')),
          BottomNavigationBarItem(icon: Icon(Icons.ondemand_video),title: Text('Admin'))

        ],
        onTap: (index){
          setState(() {
            _cIndex = index;
          });
        
        },
        //controller: _tabController,
      ),
    appBar: AppBar(
      title: Text('Teacher/Admin'),
      backgroundColor: Color.fromRGBO(143, 148, 251, 6),

       actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Image.asset('images/logo.png',),
              
              
            )
            
        ],
      
    ),
    backgroundColor: Colors.white,
    body: callPages(_cIndex),
    
    
    
    
    
    
  /*  TabBarView(children: [
        SingleChildScrollView(
          child: teacher_login(),
        ),
        SingleChildScrollView(
          child: student_login()
        )
    ],//controller: _tabController */
      /* Container(
        
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
                              transitionOnUserGestures: true,
                         child: SexyTile(splashColor: Colors.red,),

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
                                    if (index == 0) {
                                        return Admin_Login();
                                      } else if (index == 1) {
                                        return Teacher_Login();
                                      } else if (index == 2) {
                                        return Student_Home();
                                      } else {
                                        return null;
                                      }
                                    }
                              
                            )
                            
                            )
                            ;
                            }
                          ),
                        ),)
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),*/
     
      );
  }
  }
