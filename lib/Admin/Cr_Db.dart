import 'package:flutter/material.dart';
import '../crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cr_Db extends StatefulWidget {
  @override
  _Cr_DbState createState() => _Cr_DbState();
}

class _Cr_DbState extends State<Cr_Db> {
    bool isconnected=true;
   crudMethods crudObj = new crudMethods();
  var userData;

  
  TextEditingController _myIDField = TextEditingController();
  TextEditingController _myCoinField = TextEditingController();
  TextEditingController _myreasonField = TextEditingController();


  String _sid;
  int coins,updatecoin,finalcoin;


  Future _VerifyCoin(){
      print(coins-int.parse(_myCoinField.text));
      setState(() {
        updatecoin=int.parse(_myCoinField.text);
      });
      if(updatecoin>coins){
        //error
        MessageBox('Error', 'insufficient Coins To Debit', 'Try Again');
      }else{
        //updatecoin
        updatecoinval(1);
      }
      
  }
  Map data={

  };
  Future updatecoinhistory(int action)async{
    final snapShot = await Firestore.instance
                  .collection('CR.DB')
                  .document(_sid.toUpperCase())
                  .get();
                  String snap = snapShot.toString();
                  print(snap);
                  print(snapShot);
                  if (snapShot == null || !snapShot.exists) {
                    //create doc
                    print('not exist');
                            crudObj.addCRDBHistoryData({
                                  'Sid' : this._sid.toUpperCase(),
                                  //'Namawali' : coin,
                                  'History' : [
                                    {
                                      'CR/DB' : action,
                                      'Coins' : int.parse(_myCoinField.text),
                                      'Reason' : this._myreasonField.text,

                                    }
                                  ]
                                  
                                }).then((result){
                                    MessageBox('Done', 'Updated Coins : $finalcoin', 'Ok');
                                  

                                  }).catchError((e){
                                  }
                                  );
                        }else{
                          //update doc
                          print('in');
                           crudObj.updateCRDBData({
                                  'Sid' : this._sid.toUpperCase(),
                                  //'Namawali' : coin,
                                  'History' : [
                                    {
                                      'CR/DB' : action,
                                      'Coins' : int.parse(_myCoinField.text),
                                      'Reason' : this._myreasonField.text,

                                    }
                                  ]
                                  
                                }).then((result){
                                    MessageBox('Done', 'Updated Coins : $finalcoin', 'Ok');
                                  

                                  }).catchError((e){
                                  
                            
                          });}
  }
  Future updatecoinval(int action){
      //print(coins-int.parse(_myCoinField.text));
      if(int.parse(_myCoinField.text)!=null)
      {
            if(action ==0){
              //credit
              setState(() {
                this.finalcoin = coins+int.parse(_myCoinField.text);
              });
            }else{
              //debit
              this.finalcoin= coins-int.parse(_myCoinField.text);
            }
             crudObj.updateCoinCRDBData({
                  'Sid' : this._sid.toUpperCase(),
                  'Coins' : this.finalcoin
                }).then((result){
                  //Navigator.of(context).pushReplacementNamed('/HomePage');
                  updatecoinhistory(action);
                  }).catchError((e){
                // showError(e);
                  MessageBox('Error', e, 'Try Again');
                  }
      );
      }else{
        MessageBox('Error', 'Enter Valid Coins', 'Try Again');
      }

      
      
  }
  
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
                        crudObj.getStudentdata(this._sid.toUpperCase()).then((docs){
                          setState(() {
                            userData = docs.documents[0].data;
                            //print(userData)
                            
                              this.coins = userData['Coins'];
                            //print(_study);
                            this.isconnected=false;
                            
                          });
                        });
                  }
   }else{
     MessageBox('Error', 'Enter ID', 'Try again');
   }
}
 void MessageBox(String title,String des,String action){
          Navigator.of(context).pop();

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
    return Scaffold(
      appBar: AppBar(
        title: Text('CR/DB Points'),
              backgroundColor: Color.fromRGBO(143, 148, 251, 6),

       actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Image.asset('images/logo.png',),
              
              
            )
            
        ],
      

      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child:
            Card(
                     shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10.0),
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
                                   
                                   width: 250,
                                   height: 50,
                                child: Container(
                                //     width: 250,
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                   
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
                                 ),
                               Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 25, 0),

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

                            
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),),
          
          
           Container(
             child: SingleChildScrollView(
                          child: Center(
                      
                        child: Card(
                                    margin: EdgeInsets.all(10),
                                 shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                      elevation: 15,
                                        child: SingleChildScrollView(

                                      child: Center( 
                                        child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             // crossAxisAlignment: CrossAxisAlignment.start,
                            
                              children: <Widget>[
                              
                                 
                                         
                                         Container(
                                             //padding: EdgeInsets.all(30),
                                               margin: EdgeInsets.fromLTRB(25, 20, 25, 0),
                                             
                                            //width: 200,
                                             child:  isconnected?Container(
                                             // height: 150,
                                              
                                              child: Text('Coins : ',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20
                                              ),),
                                            
                                          
                                            ):Container(
                                              
                                              //height: 150,
                                              
                                              child: Text('Coins : ${coins.toString()}',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20
                                              ),)
                                            
                                            ),
                                             
                                           ),
                                           
                                   Center(
                                            
                                      child:
                                    Container(
                                    //     width: 250,
                                  margin: EdgeInsets.all(30),
                                       
                                       child:TextFormField(
                                       keyboardType: TextInputType.number,

                                         controller: _myCoinField,
                                         
                                                  onChanged: (value){
                                                            setState(() {
                                                                 //this.updatecoin= value; 
                                                                  });
                                                                },
                                                              
                                                                style: TextStyle(
                                                                  color: Colors.black87
                                                                ),
                                                                cursorColor: Colors.black26,
                                                                 decoration: InputDecoration(
                                                                   
                                                                    labelText: 'Coins',
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(5.0)
                                                                    )
                                                                  ),
                                                                              
                                                                
                                                               
                                                                enableSuggestions: true,
                                                               ),
                                   ),
                                  
                                
                                  
                              ),
                                Center(
                                            
                                      child:
                                    Container(
                                    //     width: 250,
                                  margin: EdgeInsets.all(30),
                                       
                                       child:TextFormField(
                                       keyboardType: TextInputType.text,
                                       maxLines: 5,

                                         controller: _myreasonField,
                                         
                                                  onChanged: (value){
                                                            setState(() {
                                                                 //this.updatecoin= value; 
                                                                  });
                                                                },
                                                              
                                                                style: TextStyle(
                                                                  color: Colors.black87
                                                                ),
                                                                cursorColor: Colors.black26,
                                                                 decoration: InputDecoration(
                                                                   
                                                                    labelText: 'Reason',
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(5.0)
                                                                    )
                                                                  ),
                                                                              
                                                                
                                                               
                                                                enableSuggestions: true,
                                                               ),
                                   ),
                                  
                                
                                  
                              ),             
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                              child: Row(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: <Widget>[
                                          MaterialButton(
                                                         shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                            ),
                                                        color: Colors.green,
                                                       // elevation: 100,
                                                        onPressed:() {
                                                          updatecoinval(0);
                                                        },
                                                        child: Text('Credit')
                                                         
                                                      ),
                                                         MaterialButton(
                                                         shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                            ),
                                                        color: Colors.red,
                                                        elevation: 100,
                                                        onPressed:() {
                                                          _VerifyCoin();
                                                        },
                                                        child: Text('Debit')
                                                         
                                                      ),
                                     ],
                                   ),
                            ),
                                  
                                  
                                   
                                
                                ],
                              
                            ),
                                      ),
                                  ),
                      ),
                    ),
             ),
           )
          ],
        ),
      )
    );
  }
}