import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tatvagyankendra/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'Preview.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Post_message extends StatefulWidget {
  @override
  _Post_messageState createState() => _Post_messageState();
}

class _Post_messageState extends State<Post_message> {
   crudMethods crudObj = new crudMethods();
  String title,message,_photourl='https://firebasestorage.googleapis.com/v0/b/test-8b852.appspot.com/o/Alert_Image%2Fno_image.png?alt=media&token=d02df8d3-2c32-4196-a5b0-d5ef640aeaaf';
  TextEditingController titlefield = TextEditingController();
  TextEditingController messagefield = TextEditingController();
  
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

  Future postmessage()async{
    crudObj.postmessage({
      'Title' : this.title.toUpperCase(),
      'Message' : this.message,
      'Timestamp' : DateTime.now(),
      'Image' :_photourl
      }).then((result){
      //Navigator.of(context).pushReplacementNamed('/HomePage');
     
      print('Done');
      //MessageBox('Success', 'Message posted', 'Ok');
      }).catchError((e){
     // showError(e);
     // MessageBox('Error', e, 'Try Again');
      }
      );
  }
    Future updatepostmessage()async{
    crudObj.upddatepostmessage({
      'Title' : this.title.toUpperCase(),
      //'Message' : this.message,
      'Timestamp' : DateTime.now(),
      'Image' :_photourl
      }).then((result){
      //Navigator.of(context).pushReplacementNamed('/HomePage');
     
      print('Done');
      MessageBox('Success', 'Message posted', 'Ok');
      }).catchError((e){
     // showError(e);
     // MessageBox('Error', e, 'Try Again');
      }
      );
  }
  Future pickImage() async{
    File file = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1334.0,
      maxWidth: 800.0
    );
    String fileName = Path.basename(file.path);
    Navigator.push(context,  
                         MaterialPageRoute(
                            builder: (_) => Preview(file,this.title,this.message)));
    //uploadImage(file,fileName);
  }
  void uploadImage(File file,String fileName) async{
    StorageReference storageReference = FirebaseStorage.instance.ref().child('Alert_Image/$fileName');
    storageReference.putFile(file).onComplete.then((firebaseFile) async{
      var downloadUrl = await firebaseFile.ref.getDownloadURL();

      setState((){
        _photourl = downloadUrl;
        updatepostmessage();
      //MessageBox('Success', 'Message posted', 'Ok');
        
      });
    }) ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Messsage'),
              backgroundColor: Color.fromRGBO(143, 148, 251, 6),

       actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Image.asset('images/logo.png',),
              
              
            )
            
        ],
      

      ),
        floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
         // postmessage();
          pickImage();
        },
        elevation: 10,
        label : Text('Select & Preview'),
        icon: Icon(Icons.message),
      
        //child: IconButton(icon: Icon(Icons.scanner), onPressed: null),
      
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
      
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
                                         controller: titlefield,
                                         onChanged: (value){
                                          setState(() {
                                          title = value; 
                                          });
                                        },
                                        style: TextStyle(
                                          color: Colors.black87
                                        ),
                                        cursorColor: Colors.black26,
                                       
                                        enableSuggestions: true,
                                        decoration: InputDecoration(
                                          labelText: 'Title',
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
                                         controller: messagefield,
                                        onChanged: (value){
                                          setState(() {
                                          message = value; 
                                          });
                                        },
                                       style: TextStyle(
                                          color: Colors.black87
                                        ),
                                        cursorColor: Colors.black26,
                                       keyboardType: TextInputType.multiline,
                                       maxLines: null,
                                        enableSuggestions: true,
                                        //minLines: 4,
                                        decoration: InputDecoration(
                                          labelText: 'Message',
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