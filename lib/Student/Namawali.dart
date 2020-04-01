import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:tatvagyankendra/crud.dart';
class Namawali extends StatefulWidget {
  Namawali(this.sid,this.coins);
  final String sid;
  final int coins;
  @override
  _NamawaliState createState() => _NamawaliState(sid,coins);
}

class _NamawaliState extends State<Namawali> {
  String sid;
  int coins;
  bool checkVal=false;
  var data_upload;
  _NamawaliState(this.sid,this.coins);
  int coinearned=0;
  var userData;
  String last;
  //String sid;
  bool _switchValue=false; 
   crudMethods crudObj = new crudMethods();
  List namawalidata;
  var userData_namawali;
  int _state=0;
  List coin=[
    0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0

  ];
  
  @override
  void initState(){
    super.initState();
    print('name :$sid');
    
  }

 void _showCoinDialog(int  coin) {
    // flutter defined function
    setState(() {
      _state=0;
    });
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
        title: Text('Congratulations'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
       content: Container(
         height: 100,
         child : Center(
           child:Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               Text(coin.toString(),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.amber),),
               Text('Points Earned')

             ],
           ),

           
         )
       ),
  //container
    actions: <Widget>[
    MaterialButton(onPressed: (){
          Navigator.of(context).pop();
          Navigator.of(context).pop();

        },
            child: Text('Go Back'))

  ],
);
      },
    );
  }
  void _showDialog(String title,String content,String command) {
    // flutter defined function
    setState(() {
      _state=0;
    });
    showDialog(
      barrierDismissible: false,
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
         // Navigator.of(context).pop();

        },
            child: Text(command))

  ],
);
      },
    );
  }


  Widget setUpButtonChild() {
    if (_state == 0) {
      return Center(
        child: new Text(
          "Submit",
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

 void animateButton() {
    setState(() {
      _state = 1;
    });
  if(checkVal==true){
   Submitnamawali();
  }else{
    _showDialog('Error','Pleace Check T&C','Go Back');
  }
}



  List namawali=[
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List navkar=[
    '12 Navkar',
    'Mata Pita Vadilo ko pranam',
    'Dev Darshan',
    'Guru Vandan',
    'Jinpuja',
    'Chaityavandan',
    'Samayik',
    'Kandmool Ka Tyag',
    'Ratri Bhojan Ka Tyag',
    'Ast Prakari Puja',
    'Pachkan Morning',
    'Pachkan evening',
    'Thali Dhokar Pina',
    'TV Cinema/Mobile Games Tyag',
    'Bread/Butter/Chese/Mayonese Tyag',
  ];  
  List points=[
    10,10,10,10,20,10,10,
    10,20,20,10,10,10,20,10

  ];
  Widget _myListView(BuildContext context) {

      return  
      ListView.builder(
        itemCount: navkar.length,
        
        itemBuilder: (context, index) {
          return Card( //                           <-- Card widget
            elevation: 10,
            margin: EdgeInsets.only(left: 10,right: 10,top:10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(points[index].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.amber),),
                  Text('Points',style: TextStyle(fontSize: 10,color: Colors.amber))
                ],
              ),
              title: Text(navkar[index]),
              trailing: Switch(value: namawali[index],
                        onChanged: (bool value) {
                          setState(() {
                            namawali[index] = value;
                            print(namawali);
                          });
                        },),
            ),
          );
        },
      );
    }
    convert(){
      for (int i=0;i<namawali.length;i++){
        if(navkar[i]=true){
          coin[i]=points[i];
        }else{
          coin[i]=0;
        }
      }

    }
   formatdata(Map userData){
      var now = new DateTime.now();
      var formatter = new DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(now);
    print('inside');
    data_upload={
      'Sid':userData['Sid'],
      'Last Updated' : formattedDate,
      'Points' :coinearned+userData['Points'],
      '0' : userData['0']+coin[0],
      '1' : userData['1']+coin[1],
      '2' : userData['2']+coin[2],
      '3' : userData['3']+coin[3],
      '4' : userData['4']+coin[4],
      '5' : userData['5']+coin[5],
      '6' : userData['6']+coin[6],
      '7' : userData['7']+coin[7],
      '8' : userData['8']+coin[8],
      '9' : userData['9']+coin[9],
      '10' : userData['10']+coin[10],
      '11' : userData['11']+coin[11],
      '12' : userData['12']+coin[12],
      '13' : userData['13']+coin[13],
      '14' : userData['14']+coin[14],
    };
    print(data_upload);
    print('here');
      crudObj.updateNamawaliData(data_upload).then((result){
                                      crudObj.updateCoinData({
                                          'Sid' : this.sid.toUpperCase(),
                                          'Coin' : coinearned,
                                          'Coins' : userData['Points']

                                            }).then((result){
                                                      _showCoinDialog(coinearned);

                                              }).catchError((e){
                                              }
                                                    );
                                          //_showCoinDialog(coinearned);
                                        }).catchError((e){
                                        
                                   });
}
                              
Future Submitnamawali()async{
        for (int i=0;i<15;i++){
          if(namawali[i]==true){
            print(i);
            setState(() {
               coin[i]=1;
               coinearned=coinearned+points[i];
            });
          }else{
            coin[i]=0;
          }
          
        }
        print(coin);
        var now = new DateTime.now();
      var formatter = new DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(now);
      print(formattedDate);
        final snapShot = await Firestore.instance
                  .collection('Namawali')
                  .document(sid.toUpperCase())
                  .get();
                  String snap = snapShot.toString();
                  print(snap);
                  print(snapShot);
                  if (snapShot == null || !snapShot.exists) {
                    //create doc
                    print('not exist');
                            crudObj.addNamawaliData({
                                  'Sid' : this.sid.toUpperCase(),
                                  //'Namawali' : coin,
                                  'Last Updated' : formattedDate,
                                  'Points' : coinearned,
                                    '0' : coin[0],
                                    '1' : coin[1],
                                    '2' : coin[2],
                                    '3' : coin[3],
                                    '4' : coin[4],
                                    '5' : coin[5],
                                    '6' : coin[6],

                                    '7' : coin[7],
                                    '8' : coin[8],
                                    '9' : coin[9],
                                    '10' :coin[10],
                                    '11' : coin[11],
                                    '12' : coin[12],
                                    '13' : coin[13],
                                    '14' : coin[14],
                                    
                                }).then((result){
                                  crudObj.updateCoinData({
                                  'Sid' : this.sid.toUpperCase(),
                                  'Coin' : coinearned,
                                  'Coins' : 0

                                 
                                    }).then((result){

                                              _showCoinDialog(coinearned);

                                      }).catchError((e){
                                      }
                                  );
                                          //_showCoinDialog(coinearned);

                                  }).catchError((e){
                                  }
                                  );
                        }else{
                          //update doc
                          print('in');
                          crudObj.getNamawalidata(this.sid.toUpperCase()).then((docs){
                                setState(() {
                                  userData = docs.documents[0].data;
                                  print(userData);
                                 
                                  last =userData['Last Updated'];
                                  print(last);
                               

                                });

                                   if(last!=formattedDate){
                                         formatdata(userData);
                              //var update;
                            }  else{
                              _showDialog('Error', 'You Already Submitted Namawali', 'Go Back');
                            }
                            
                          });}
                        }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
      elevation: 5,
      backgroundColor: Color.fromRGBO(143, 148, 251, 1),
     title: Text('Niyamawali'),
     
    ),
    floatingActionButton: FloatingActionButton.extended(
      //mini: true,
      isExtended: true,
      onPressed: (){
        //Submitnamawali();
        setState(() {
                                  if (_state == 0) {
                                    animateButton();
                                  }
                                });
      },
      backgroundColor: Color.fromRGBO(143, 148, 251, 1),
      icon: Icon(Icons.send),
      label: setUpButtonChild(),
      //child: setUpButtonChild(),
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

    backgroundColor: Colors.white,
    body: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height-175,
          margin: EdgeInsets.all(0),
              child: _myListView(context),

        ),
        Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Checkbox(
              value: checkVal,
              onChanged: (bool value) {
                  setState(() {
                      checkVal = value;
                  });
              },
              ),
          Expanded(
                      child: Container(
              child: Text('I HERE BY CONFIRM THAT ALL ABOVE THINGS\nARE TRUE IN SPRITUAL PRESENCE OF\nVITRAG PARMAATMA',softWrap: false,overflow: TextOverflow.ellipsis,),
            ),
          )
              ],
            ),
          ),
        )
      ],
    )
    );
  }
}