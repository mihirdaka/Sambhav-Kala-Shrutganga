import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import '../crud.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Update_Sutra(title: 'Flutter Demo Home Page'),
      
    );
  }
}

class Update_Sutra extends StatefulWidget {
  Update_Sutra({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _Update_SutraState createState() => _Update_SutraState();
}

class _Update_SutraState extends State<Update_Sutra> {
    int sutralen=0;
    int sutraindex=0;
    int gatha=null;
    String selectedSutra='Navkar';
    bool isconnected=true;
   crudMethods crudObj = new crudMethods();
  var userData;
  List Sutra=[
      'Navkar',
      'Panchidiya',	
      'Ichami',	
      'Ichkar',	
      'Abhutiyo',		
      'Iriyavahiyam',
      'Tass Utrai',
      'Annath',
      'Loggas',
      'Karemi Banthe',
      'Samiya Vay',
      'Jag Chintamani',
      'Jan Kinchi',
      'Namothan',
      'Javanti Chaiyaim',
      'Javant Kevi Sahu',
      'Uvsagharam',
      'Jay Viyaray',
      'Arihant Chaiyanam',
      'Kalankandam',
      'Sansardawanal',
      'Pukharvardhivadhe',
      'Sidhanam',
      'Vaiyavachgaranam',
      'Bhagwanan',
      'Savasami Devsiya',
      'Ichami Thami',
      'Nanami',
      'Vandana',
      'Sath Lakh',
      '18 Pap stanak',
      'Vanditu',
      'Aiayria uvajaya',
      'Namostu Vardhmanaya',
      'Vishal Lochan',
      'Suadevya',
      'Jise Kithe',
      'Kamaldal',
      'Gyanadi',
      'Yasha Khestra',
      'Adhaijesu',
      'Varkanak',
      'Shanti',
      'Choukashay',
      'Bhareshar',
      'Manah Jinanam',
      'Sakal Tirth',
      'Saklarth',
      'Santikaram',
      'Badi Shanti',
      'Tijaypahut',
      'Namiun',
      'Ajith shanti',
      'Atichar',
      'Bhaktamar',
      'Kalyanmandir',
	
  ];
  int attendanceval =0;
  var att;
  bool isgot= false;
  
  TextEditingController _myIDField = TextEditingController();
  TextEditingController _myGathaField = TextEditingController();
  TextEditingController _mySageField = TextEditingController();

  String _email,_password,_name,_phone,_sage,_sid,_study;
  String _photourl = "https://firebasestorage.googleapis.com/v0/b/test-8b852.appspot.com/o/user.png?alt=media&token=fc2e9d77-c9c9-4621-b781-44371cb4c4ff";





Future _checkid() async{
   if(_myIDField.text.isNotEmpty){
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
                  }else{
                    print(_sid);
                    setState(() {
                            isgot=true;

                    });
                            //print(attendanceval); 
                  }
   }else{
     MessageBox('Error', 'Enter ID', 'Try again');
   }
}

 Future updateSutra()async{
   if(this._myIDField.text==null){
     MessageBox('Error', 'Enter Student ID', 'Try Again');
   }else{
     if(this.gatha==null||this.gatha==0){
       MessageBox('Error', 'Enter Correct Gatha', 'Try Again');
     }else{
       //update
       for(int i =0 ;i<Sutra.length;i++){
         if(Sutra[i]==selectedSutra){
           setState(() {
             this.sutraindex=i;
             print(i);
           });
         }
       }
        var now = new DateTime.now();
      var formatter = new DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(now);
      print(formattedDate);
        final snapShot = await Firestore.instance
                  .collection('Sutra')
                  .document(_myIDField.text.toUpperCase())
                  .get();
                  String snap = snapShot.toString();
                  print(snap);
                  print(snapShot);
                  if (snapShot == null || !snapShot.exists) {
                    //create doc
                    print('not exist');
                            crudObj.addSutraData({
                                  'Sid' : this._myIDField.text.toUpperCase(),
                                  //'Namawali' : coin,
                                  'Sutra' : [{
                                    'Date' : formattedDate,
                                    'Gatha' : int.parse(_myGathaField.text),
                                    'Sutrano' : sutraindex
                                  }]
                                      
                                }).then((result){
                                  MessageBox('Done', 'Updeated Successfully', 'Ok');
                                                                  }
                                  );
                                          //_showCoinDialog(coinearned);

                               
                        }else{
                          //update doc
                          print('in');
                           crudObj.updateSutraData({
                                  'Sid' : this._myIDField.text.toUpperCase(),
                                  //'Namawali' : coin,
                                  'Sutra' : [{
                                    'Date' : formattedDate,
                                    'Gatha' : int.parse(_myGathaField.text),
                                    'Sutrano' : sutraindex
                                  }]
                                      
                                }).then((result){
                                  MessageBox('Done', 'Updeated Successfully', 'Ok');
                                                                  }
                                  );
                                  }


                                     //    formatdata(userData);
                              //var update;
                          
                         
     }
   }
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
 double height = MediaQuery.of(context).size.height;
    return Scaffold(
     // backgroundColor: invertInvertColorsStrong(context),
       floatingActionButton: FloatingActionButton.extended(
        onPressed:(){
         updateSutra();
        },
        elevation: 10,
        label : Text('Update'),
        icon: Icon(Icons.file_upload),
      
        //child: IconButton(icon: Icon(Icons.scanner), onPressed: null),
      
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
      
      title:
      Text('Sutra Update'),
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
                                              labelText: 'Student ID',
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
                                          Text('Update Sutra & Gatha',style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                          ),),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  child: Text('Select Sutra : '),
                                                ),
                                                Container(
                                         child:   DropdownButton<String>(
                              value: selectedSutra,
                              items: Sutra.map((value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (String Value) {
                                setState(() {
                                  this.selectedSutra=Value;
                                  print(selectedSutra);
                                });
                              },
      )
                                                ),
                                              ],
                                            ),
                                          ),
                                         
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                                                  child:   TextField(
                                                controller: _myGathaField,
                                                keyboardType: TextInputType.number,
                                                          onChanged: (value){
                                                                    setState(() {
                                                                          this.gatha = int.parse(value); 
                                                                          });
                                                                        },
                                                                        style: TextStyle(
                                                                          color: Colors.black87
                                                                        ),
                                                                        cursorColor: Colors.black26,
                                                                        decoration: InputDecoration(
                                                                        
                                                                            labelText: 'Gatha NO',
                                                                            border: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(5.0)
                                                                            )
                                                                          ),
                                                        
                                          
                                         
                                          enableSuggestions: true,
                                          
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
