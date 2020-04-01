import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;


class Preview extends StatefulWidget {
  File file;
  String title,message;
  Preview(this.file,this.title,this.message);
  @override
  _PreviewState createState() => _PreviewState(this.file,this.title,this.message);
}

class _PreviewState extends State<Preview> {
  File file;
  String title,message,_photourl='https://firebasestorage.googleapis.com/v0/b/test-8b852.appspot.com/o/Alert_Image%2Fno_image.png?alt=media&token=d02df8d3-2c32-4196-a5b0-d5ef640aeaaf';

  _PreviewState(this.file,this.title,this.message);
   crudMethods crudObj = new crudMethods();
   
            
        
  
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
          Navigator.of(context).pop();

        },
            child: Text(action))

  ],
);
      },
    );
  }
   void uploadImage(File file) async{
    String fileName = Path.basename(file.path);

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
   void _onLoading(File file) {
     postmessage();
    uploadImage(file);
  

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
        //String fileName = Path.basename(file.path);
          
          _onLoading(file);
          //pickImage();
        },
        elevation: 10,
        label : Text('Upload'),
        icon: Icon(Icons.cloud_upload),
      
        //child: IconButton(icon: Icon(Icons.scanner), onPressed: null),
      
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        
      body: SingleChildScrollView(
              child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Center(
                
                child: Card(
                                        //margin: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                              elevation: 15,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width-20,
                                                //height: MediaQuery.of(context).size.height/3,
                                                child: Image.file(
                                                  file,
                                                  fit: BoxFit.fitHeight,
                                                  scale:0.5,
                                                  semanticLabel: 'Update Image',
                                                
                                                  
                                                ),
                                              ),
                                               Container(
                                          child: Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                        Divider(),
                                        Text(message)

                                            ],
                                          ),
                                        ),
                                       
                                      ),
              ),
            ],
          ),
        ),
      )
    );
  }
}