import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import '../sexy_tile.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import '../crud.dart';
import 'dart:async';
import 'dart:typed_data';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Add_Teacher(title: 'Flutter Demo Home Page'),
    );
  }
}

class Add_Teacher extends StatefulWidget {
  Add_Teacher({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _Add_TeacherState createState() => _Add_TeacherState();
}

class _Add_TeacherState extends State<Add_Teacher> {

   String barcode = '';
  Uint8List bytes = Uint8List(200);

   crudMethods crudObj = new crudMethods();

  TextEditingController _myPhoneField = TextEditingController();
  TextEditingController _myNameField = TextEditingController();
  TextEditingController _myIDField = TextEditingController();
  TextEditingController _myStudyField = TextEditingController();
  TextEditingController _mySageField = TextEditingController();

  String _email,_password,_name,_phone,_sage,_sid,_study;
  String _photourl = "https://firebasestorage.googleapis.com/v0/b/eatit01.appspot.com/o/assets%2Fadd_Person.png?alt=media&token=60b12ef1-0e44-4b85-86f2-650055946950";



saveUserData(){  
    crudObj.addteacherimage({
      'Tid' : this._sid.toUpperCase(),
      
      'PhotoUrl' : this._photourl,
      //'//TotalCart' : [],
      //'Uid' : _uid*/
    }).then((result){
      //Navigator.of(context).pushReplacementNamed('/HomePage');
      Navigator.pop(context);
      Navigator.pop(context);

      MessageBox('Success', 'Teacher Added Successfully', 'Ok');
      }).catchError((e){
     // showError(e);
      MessageBox('Error', e, 'Try Again');
      }
      );
  }
  saveUserData1(){  
    crudObj.addteacherData({
      'Tid' : this._sid.toUpperCase(),
      'Name' : this._name,
      'Phone' : this._phone,
      'password' : this._password,
      //'Age' : this._sage,
      //'PhotoUrl' : this._photourl,
      //'//TotalCart' : [],
      //'Uid' : _uid*/
    }).then((result){
      //Navigator.of(context).pushReplacementNamed('/HomePage');
     
      }).catchError((e){
     // showError(e);
      MessageBox('Error', e, 'Try Again');
      }
      );
  }

void _onLoading(File file,String fileName)  {
  uploadImage(file, fileName);
  uploadQR();

 showCupertinoDialog<dynamic>(
   
                                    context: context,
                                    
                                    builder: (BuildContext context) => CupertinoAlertDialog(
                                      
                                      title: Text('Loading'),
                                      
                                      content: Container(
                                        margin: EdgeInsets.all(20),
                                        
                                        child:CupertinoActivityIndicator(animating: true,radius: 30,),
                                      )
                                      

            )
            );

  
  
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





Future pickImage() async{

    if(_myPhoneField.text.length==10){

        if(!_myNameField.text.isEmpty){
          if(_myIDField.text.isNotEmpty){
            
              if(_mySageField.text.isNotEmpty){
                final snapShot = await Firestore.instance
                  .collection('Teacher')
                  .document(_sid.toUpperCase())
                  .get();
                  String snap = snapShot.toString();
                  print(snap);
                  print(snapShot);
                  if (snapShot == null || !snapShot.exists) {
                    // Document with id == docId doesn't exist.
                    //saveUserData();
                    saveUserData1();
                      File file = await ImagePicker.pickImage(
                        source: ImageSource.camera,
                        maxHeight: 300.0,
                        maxWidth: 300.0
                      );
                      String fileName = this._sid.toUpperCase();
                                    
                        // this.setState(() => this.bytes = result);
                        _onLoading(file, fileName);
                  }else{
                       MessageBox('Error', 'Teacher Id Already Exist', 'Try Again'); 
                  }
                  


              }else{  
                MessageBox('Error', 'Enter Valid Password', 'Try Again');

              }
           
          }else{
            MessageBox('Error', 'Enter Valid Id', 'Try Again');

          }
        }else{
          MessageBox('Error', 'Enter Valid Name', 'Try Again');
        }
        
    }else{
      MessageBox('Error', 'Enter Valid Mobile Number', 'Try Again');
    }
  }
  void uploadImage(File file,String fileName) async{
    
    StorageReference storageReference = FirebaseStorage.instance.ref().child('Teacher_Images/$fileName');
    storageReference.putFile(file).onComplete.then((firebaseFile) async{
      var downloadUrl = await firebaseFile.ref.getDownloadURL();

      setState((){
        _photourl = downloadUrl;
        saveUserData();
       /* crudObj.updateTeacherData({
      'Tid' : this._sid.toUpperCase(),
      'PhotoUrl' : this._photourl,
      'password' : this._password
      //'//TotalCart' : [],
      
      //'Uid' : _uid
    }).then((result){
      Navigator.pop(context);
      MessageBox('Success', 'Teacher Added Successfully', 'Ok');
  
      //Navigator.of(context).pushReplacementNamed('/HomePage');
      }).catchError((e){
     // showError(e);
      MessageBox('Error', e, 'Try Again');
      }
      );
      */
      });
      

    }) ;
  }




 void uploadQR() async{
    String fileName=_sid.toUpperCase();
    Uint8List result = await scanner.generateBarCode(fileName);
    StorageReference storageReference = FirebaseStorage.instance.ref().child('Teacher_QR/$fileName');
    storageReference.putData(result).onComplete.then((firebaseFile) async{
      var downloadUrl = await firebaseFile.ref.getDownloadURL();
    }) ;
  }



  @override
  Widget build(BuildContext context) {
   //me of each individual tile

    return Scaffold(
     // backgroundColor: invertInvertColorsStrong(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>pickImage(),
        elevation: 10,
        label : Text('Add'),
        icon: Icon(Icons.camera_alt),
      
        //child: IconButton(icon: Icon(Icons.scanner), onPressed: null),
      
      ),
       //extendBody: true,
       extendBodyBehindAppBar: false,
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
       
      title:
      Text('Add Teacher'),
            backgroundColor: Color.fromRGBO(143, 148, 251, 6),

       actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Image.asset('images/logo.png',),
              
              
            )
            
        ],
      

      
     
    ),
    backgroundColor: Colors.white,
    body:  Container(
      
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      //padding: EdgeInsets.fromLTRB(0, 60, 0, 60),
      
      
     child: Card(
       //height: 500,
       shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  ),
       elevation: 15,
       child: SingleChildScrollView(
         padding: const EdgeInsets.all(8.0),
         scrollDirection: Axis.vertical,
                child: Center(
                  child: Column(
           children: <Widget>[
             Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                       // crossAxisAlignment: CrossAxisAlignment.start,
                      
                        children: <Widget>[
                        
                           
                                   Container(
                                       //padding: EdgeInsets.all(30),
                                 margin: EdgeInsets.fromLTRB(25, 20, 25, 0),

                                       child: 
                                       TextField(
                                         controller: _myIDField,
                                         onChanged: (value){
                                          setState(() {
                                          _sid = value; 
                                          });
                                        },
                                        style: TextStyle(
                                          color: Colors.black87
                                        ),
                                        cursorColor: Colors.black26,
                                       
                                        enableSuggestions: true,
                                        decoration: InputDecoration(
                                          labelText: 'Teacher ID',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0)
                                          )
                                        ),
                                       ),
                                     ),
                                      
                              
                                   Container(
                                       margin: EdgeInsets.fromLTRB(25, 20, 25, 0),
                                     
                                       child: 
                                       TextField(
                                         controller: _myNameField,
                                        onChanged: (value){
                                          setState(() {
                                          _name = value; 
                                          });
                                        },
                                       style: TextStyle(
                                          color: Colors.black87
                                        ),
                                        cursorColor: Colors.black26,
                                       
                                        enableSuggestions: true,
                                        decoration: InputDecoration(
                                          labelText: 'Teacher Name',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0)
                                          )
                                        ),
                                       ),
                                     ),
                              
                                   Container(
                                       margin: EdgeInsets.fromLTRB(25, 20, 25, 0),
                                      
                                       child: 
                                       TextField(
                                         onChanged: (value){
                                          setState(() {
                                          _phone = value; 
                                          });
                                        },
                                         keyboardType: TextInputType.phone,
                                        style: TextStyle(
                                          color: Colors.black87
                                        ),
                                        cursorColor: Colors.black26,
                                        controller: _myPhoneField,
                                       
                                        enableSuggestions: true,
                                        decoration: InputDecoration(
                                          labelText: 'Mobile No',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0)
                                          )
                                        ),
                                       ),
                                     ),
                                      
                              
                                   Container(
                                       margin: EdgeInsets.fromLTRB(25, 20, 25, 20),
                                       
                                       child: 
                                       TextField(
                                         controller: _mySageField,
                                         onChanged: (value){
                                          setState(() {
                                          _password = value; 
                                          });
                                        },
                                         keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          color: Colors.black87
                                        ),
                                        cursorColor: Colors.black26,
                                        
                                        enableSuggestions: true,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0)
                                          )
                                        ),
                                       ),
                                     ),
                             
                              
                             
                                
                          
                          ],
                        
                      ),
             ),
           ],
         ),
                ),
       ),
     ),
     
    )
    );
  }
}
