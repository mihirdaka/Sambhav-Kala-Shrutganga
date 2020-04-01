import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import '../sexy_tile.dart';
import '../crud.dart';
import 'package:image_cropper/image_cropper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Edit_record(title: 'Flutter Demo Home Page'),
    );
  }
}

class Edit_record extends StatefulWidget {
  Edit_record({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _Edit_recordState createState() => _Edit_recordState();
}

class _Edit_recordState extends State<Edit_record> {
  bool isconnected = true;
  crudMethods crudObj = new crudMethods();
  var userData;

  TextEditingController _myPhoneField = TextEditingController();
  TextEditingController _myNameField = TextEditingController();
  TextEditingController _myIDField = TextEditingController();
  TextEditingController _myStudyField = TextEditingController();
  TextEditingController _mySageField = TextEditingController();

  String _email, _password, _name, _phone, _sage, _sid, _study;
  File _image;
  String _photourl =
      "https://firebasestorage.googleapis.com/v0/b/test-8b852.appspot.com/o/user.png?alt=media&token=fc2e9d77-c9c9-4621-b781-44371cb4c4ff";

  saveUserData() {
    crudObj.updateeditData({
      'Sid': this._sid.toUpperCase(),
      'Name': this._name,
      'Study': this._study,
      'Phone': this._phone,
      'password': this._phone,
      'Age': this._sage,
      'PhotoUrl': this._photourl,
      //'//TotalCart' : [],
      //'Uid' : _uid*/
    }).then((result) {
      //Navigator.of(context).pushReplacementNamed('/HomePage');
      MessageBox('Done', 'User updated', 'Ok');
    }).catchError((e) {
      // showError(e);
      MessageBox('Error', e, 'Try Again');
    });
  }

  void MessageBox(String title, String des, String action) {
    Navigator.of(context).pop();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          content: Text(des),
          //container
          actions: <Widget>[
            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(action))
          ],
        );
      },
    );
  }
 Future<Null> _cropImage(File imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Cropper',
      )
    );
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        //state = AppState.cropped;
         String fileName = this._sid.toUpperCase();

        uploadImage(_image, fileName);
        //_onLoading();
      });
    }
  }
  void _onLoading() {
    saveUserData();

    showCupertinoDialog<dynamic>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text('Loading'),
            content: Container(
              margin: EdgeInsets.all(20),
              child: CupertinoActivityIndicator(
                animating: true,
                radius: 30,
              ),
            )));
  }
  

  Future _checkid() async {
    if (_myIDField.text.isNotEmpty) {
      print('in');
      print(_sid);
      final snapShot = await Firestore.instance
          .collection('Student')
          .document(_sid.toUpperCase())
          .get();
      String snap = snapShot.toString();
      print(snap);
      print(snapShot);
      if (snapShot == null || !snapShot.exists) {
        MessageBox('Error', 'Id Does Not Exist ', 'Try again');
      } else {
        print(_sid);
        crudObj.getStudentdata(this._sid.toUpperCase()).then((docs) {
          setState(() {
            userData = docs.documents[0].data;
            //print(userData)
            this._study = userData['Study'];
            this._name = userData['Name'];
            this._phone = userData['Phone'];
            this._sage = userData['Age'];
            this._photourl = userData['PhotoUrl'];
            _myStudyField.text = _study;
            _myNameField.text = _name;
            _myPhoneField.text = _phone;
            _mySageField.text = _sage;
            print(_study);
            this.isconnected = false;
            if(_photourl==null){
              this._photourl="https://firebasestorage.googleapis.com/v0/b/test-8b852.appspot.com/o/no_image.png?alt=media&token=7342b461-6a43-4edf-a08a-6c7be7084051";
            }
          });
        });
      }
    } else {
      MessageBox('Error', 'Enter ID', 'Try again');
    }
  }
    Future <void> _optionsDialogBox(){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Take a Picture",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                    ),
                    onTap: opencamera,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  GestureDetector(
                    child: Text("Open a Picture",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                    ),
                    onTap: opengallery,
                  )
                ],
              ),
            ),
        );
      }
    );
  }




  Future opencamera() async {
    var image  = await ImagePicker.pickImage(source : ImageSource.camera,maxHeight: 300.0,
                    maxWidth: 300.0);

    setState(() {
      _image = image;
    });
   _cropImage(image);

  }
  Future opengallery() async {
    var picture  = await ImagePicker.pickImage(source : ImageSource.gallery,maxHeight: 300.0,
                    maxWidth: 300.0);

    setState(() {
      _image = picture;
    });
       _cropImage(picture);

  }




  void uploadImage(File file, String fileName) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('Student_Images/$fileName');
    storageReference.putFile(file).onComplete.then((firebaseFile) async {
      var downloadUrl = await firebaseFile.ref.getDownloadURL();

      setState(() {
        _photourl = downloadUrl;
      });
      crudObj.updateStuData({
        'Sid': this._sid,
        'PhotoUrl': this._photourl,
        //'//TotalCart' : [],

        //'Uid' : _uid*/
      }).then((result) {
        MessageBox('Success', 'Photo Updated Successfully', 'Ok');

        //Navigator.of(context).pushReplacementNamed('/HomePage');
      }).catchError((e) {
        // showError(e);
        MessageBox('Error', e, 'Try Again');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
 //name of each individual tile

    return Scaffold(
        // backgroundColor: invertInvertColorsStrong(context),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _onLoading(),
          elevation: 10,
          label: Text('Update'),
          icon: Icon(Icons.update),

          //child: IconButton(icon: Icon(Icons.scanner), onPressed: null),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Text('Edit Record'),
          //previousPageTitle: 'Admin',
          backgroundColor: Color.fromRGBO(143, 148, 251, 6),

          actions: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Image.asset(
                'images/logo.png',
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 15,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: Container(
                                  //     width: 250,
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),

                                  child: TextField(
                                    controller: _myIDField,
                                    onChanged: (value) {
                                      setState(() {
                                        this._sid = value;
                                      });
                                    },
                                    style: TextStyle(color: Colors.black87),
                                    cursorColor: Colors.black26,
                                    decoration: InputDecoration(
                                        labelText: 'Student ID',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                    enableSuggestions: true,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 25, 0),

                                //height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Colors.blue,
                                    elevation: 100,
                                    onPressed: () {
                                      _checkid();
                                    },
                                    child: Text('Search')),

                                /*Center(
	                            child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15),),
                                         )*/
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 15,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,

                          children: <Widget>[
                            Container(
                              //padding: EdgeInsets.all(30),
                              margin: EdgeInsets.fromLTRB(25, 20, 25, 0),

                              //width: 200,
                              child: isconnected
                                  ? Container(
                                      height: 150,
                                      child: Image.asset('images/user.png'),
                                    )
                                  : GestureDetector(
                                    onTap: _optionsDialogBox,
                                     child: Container(
                                        height: 200,
                                        child: AspectRatio(
                                          aspectRatio: 1.0,
                                          child: new Container(
                                            decoration: new BoxDecoration(
                                                image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              alignment:
                                                  FractionalOffset.topCenter,
                                              image: new NetworkImage(
                                                  _photourl),
                                            )),
                                          ),
                                        )),
                                  ),
                            ),
                            Center(
                              child: Text('Tap to update'),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(25, 20, 25, 0),
                              child: TextField(
                                controller: _myNameField,
                                onChanged: (value) {
                                  setState(() {
                                    _name = value;
                                  });
                                },
                                style: TextStyle(color: Colors.black87),
                                cursorColor: Colors.black26,
                                enableSuggestions: true,
                                decoration: InputDecoration(
                                    labelText: 'Student Name',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(25, 20, 25, 0),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _phone = value;
                                  });
                                },
                                keyboardType: TextInputType.phone,
                                style: TextStyle(color: Colors.black87),
                                cursorColor: Colors.black26,
                                controller: _myPhoneField,
                                enableSuggestions: true,
                                decoration: InputDecoration(
                                    labelText: 'Mobile No',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(25, 20, 25, 0),
                              child: TextField(
                                controller: _myStudyField,
                                onChanged: (value) {
                                  setState(() {
                                    _study = value;
                                  });
                                },
                                style: TextStyle(color: Colors.black87),
                                cursorColor: Colors.black26,

                                enableSuggestions: true,
                                //clearButtonMode: OverlayVisibilityMode.editing,
                                decoration: InputDecoration(
                                    labelText: 'Study',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(25, 20, 25, 20),
                              child: TextField(
                                controller: _mySageField,
                                onChanged: (value) {
                                  setState(() {
                                    _sage = value;
                                  });
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.black87),
                                cursorColor: Colors.black26,
                                enableSuggestions: true,
                                decoration: InputDecoration(
                                    labelText: 'Student Age',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                            ),

                            /*CupertinoButton.filled(
                                       child: Text('Upload Image & Add'),
                                        

                                      
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10)
                                      ), 
                                      onPressed: () {
                                        pickImage();
                                        
                                       
                                     
                                      }
                                     ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
