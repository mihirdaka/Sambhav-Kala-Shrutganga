import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:tatvagyankendra/Student/Alerts.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import '../sexy_tile.dart';
import '../crud.dart';





class OtherGatha extends StatefulWidget {
  String _sid;
  OtherGatha(this._sid);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String sid;

  @override
  _OtherGathaState createState() => _OtherGathaState(_sid);
}

class _OtherGathaState extends State<OtherGatha> {
    String _sid;
    _OtherGathaState(this._sid);
    int sutralen=0;
    String selectedSutra='Navkar';
    bool isconnected=true;
   crudMethods crudObj = new crudMethods();
  var userData;
  List<String> Sutra=<String>[
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
  TextEditingController _myPhoneField = TextEditingController();
  TextEditingController _myNameField = TextEditingController();
  TextEditingController _myIDField = TextEditingController();
  TextEditingController _myStudyField = TextEditingController();
  TextEditingController _mySageField = TextEditingController();

  String _email,_password,_name,_phone,_sage,_study;
  String _photourl = "https://firebasestorage.googleapis.com/v0/b/test-8b852.appspot.com/o/user.png?alt=media&token=fc2e9d77-c9c9-4621-b781-44371cb4c4ff";


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(_sid);
    _checkid();
  }



Future _checkid() async{
    print('in');
  
     print('in');
     print(_sid);
                final snapShot = await Firestore.instance
                  .collection('Stavan')
                  .document(_sid.toUpperCase())
                  .get();
                  String snap = snapShot.toString();
                  print(snap);
                  print(snapShot);
                  if (snapShot == null || !snapShot.exists) {
                    MessageBox('Error', 'Gatha History Not Found Please Update', 'Go Back');
                  }else{
                    print(_sid);
                        crudObj.getStavandata(this._sid.toUpperCase()).then((docs){
                          setState(() {
                            userData = docs.documents[0].data;
                            //print(userData);
                            //var attendance = userData['Attendance'];
                            print(userData['Stavan']);
                             att = userData['Stavan'];
                             this.sutralen=att.length-1;
                             print(sutralen);
                            isgot=true;
                            //print(attendanceval);
                          });
                        });
                  }
   
}

List other = [
  'ST',
  'TH',
  'CH'
];
List<Color> colorval=[
  Colors.red,
  Colors.blue,
  Colors.green
];
Widget _myListView(BuildContext context) {

      return  ListView.builder(
        //reverse: true,
            itemCount: att.length,
            itemBuilder: (context, index) {
      
              return Card( //                           <-- Card widget
                color: colorval[att[sutralen-index]['Type']],
                elevation: 5,
                child: ListTile(
                  
                  leading:Text(other[att[sutralen-index]['Type']]),
                  title: Text('${att[sutralen-index]['Stavan']} : ${att[sutralen-index]['Gatha']}'),
                  trailing: Text('${att[sutralen-index]['Date']}'),
                ),
              );
            },
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
       
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
      
      title:
      Text('Kavya History'),
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
                                          Text('Kavya Count : ${sutralen+1}',style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                          ),),
                                         
                                             SingleChildScrollView(
                                              child: Center(
                                                 child: Container(
                                                   margin: EdgeInsets.all(10),
                                                  child: _myListView(context),
                                                height: MediaQuery.of(context).size.height-200,
                                            ),
                                               ),
                                             ),
                                          
                                      ],
                                    ),
                                  )
                                  :Center(child: Text('Loading..'))
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
