import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'Update_Sutraoption.dart';

import '../crud.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Sutra(title: 'Flutter Demo Home Page'),
      
    );
  }
}

class Sutra extends StatefulWidget {
  Sutra({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SutraState createState() => _SutraState();
}

class _SutraState extends State<Sutra> {
    int sutralen=0;
    var username;

    //String selectedSutra='18 Pap stanak';
    bool isconnected=true;
   crudMethods crudObj = new crudMethods();
  var userData;
  List<String> Sutra=<String>[
    'NAVKAR',
    'PANCHIDIYA',
    'ICHAMI',
    'ICHKAR',
    'ABHUTIYO',
    'IRIYAVAHIYAM',
    'TASS UTRAI',
    'ANNATH',
    'LOGGAS',
    'KAREMI BANTHE',
    'SAMIYA VAYJUTO',
    'JAGCHINTAMANI',
    'JAN KINCHI',
    'NAMORATH',
    'JAVANTI CHAIYAIM',
    'JAVANT KEVI SAHU',
    'UVSAGHARAM',
    'JAY VIYARAY',
    'ARIHANT CHAIYANAM',
    'KALANKANDAM',
    'SANSARDAWA',
    'PUKHARVARDHIVADHE',
    'SIDHANAM BUDHANAM',
    'VAIYAVACHGARANAM',
    'BHAGWANAM',
    'SAVASAMI DEVSIYA',
    'ICHAMI THAMI',
    'NANAMI',
    'VANDANA',
    'SAT LAKH',
    '18 PAP STANAK',
    'VANDITU',
    'AIAYRIA UVAJAYA',
    'NAMOSTU VARDHMANAYA',
    'VISHAL LOCHAN',
    'SUADEVYA',
    'JISE KITHE',
    'KAMALDAL',
    'GYANADI',
    'YASHA KHESTRA',
    'ADHAIJESU',
    'VARKANAK',
    'LAGHU SHANTI',
    'CHOUKASHAY',
    'BHARESHAR',
    'MANAH JINANAM',
    'SAKAL TIRTH',
    'SAKLARTH',
    'SANTIKARAM',
    'BADI SHANTI',
    'TIJAYPAHUT',
    'NAMIUN',
    'AJITH SHANTI',
    'ATICHAR',
    'BHAKTAMAR',
    'KALYANMANDIR',
    'JIV VICHAR',
    'NAVTATVA',
    'DANDAK',
    'LAGHU SANGRAHNI',
    'CHAITYAVANDAN BHASYA',
    'GURU VANDAN BHASYA',
    'PACHKHAN BHASYA',
    'KRAMAGRANTH-1',
    'KRAMAGRANTH-2',
    'KRAMAGRANTH-3',
    'KRAMAGRANTH-4',
    'KRAMAGRANTH-5',
    'KRAMAGRANTH-6',
    'VAIRAGYA SATAK',
    'INDRIYAPRAJAY SATAK',
    'SAMBODHSAPTATI',
    'VITRAG STOTRA',
    'TATVARTH SUTRA',
    'GYANSAR SUTRA',
    'PANCHSUTRA',
    'OTHER',
  ];
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





Future _checkid() async{
   if(_myIDField.text.isNotEmpty){
     print('in');
     print(_sid);
                final snapShot = await Firestore.instance
                  .collection('Sutra')
                  .document(_sid.toUpperCase())
                  .get();
                  String snap = snapShot.toString();
                  print(snap);
                  print(snapShot);
                  if (snapShot == null || !snapShot.exists) {
                    MessageBox('Error', 'Id Does Not Have Any Sutra. Add Sutra ', 'Try again');
                  }else{
                    print(_sid);
                        crudObj.getSutradata(this._sid.toUpperCase()).then((docs){
                          setState(() {
                            userData = docs.documents[0].data;
                            //print(userData);
                            //var attendance = userData['Attendance'];
                            print(userData['Sutra']);
                             att = userData['Sutra'];
                             this.sutralen=att.length-1;
                             print(sutralen);
                           
                            //print(attendanceval);
                          });
                        });
                        crudObj.getStudentdata(this._sid.toUpperCase()).then((docs){
                          setState(() {
                            username = docs.documents[0].data;
                            //print(userData);
                            //var attendance = userData['Attendance'];
                            print(username);
                            isgot=true;
                            //print(attendanceval);
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
                  title: Text('${Sutra[att[sutralen-index]['Sutrano']]} : ${att[sutralen-index]['Gatha'].toString()}'),
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
           Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(
                                 builder: (BuildContext context){
                                    return Settings();
                                    }
                              
           ));
          //_ShowDialog();
        },
        elevation: 10,
        label : Text('Update Sutra'),
        //icon: Icon(Icons.file_upload),
      
        //child: IconButton(icon: Icon(Icons.scanner), onPressed: null),
      
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
      
      title:
      Text('Sutra View/Update'),
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
                                        Text('Student Name : ${username['Name']}',style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                          ),),
                                          Text('Sutra Count : ${att.length}',style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                          ),),
                                         
                                             SingleChildScrollView(
                                              child: Center(
                                                 child: Container(
                                                   margin: EdgeInsets.all(10),
                                                  child: _myListView(context),
                                                height: MediaQuery.of(context).size.height-350,
                                            ),
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
