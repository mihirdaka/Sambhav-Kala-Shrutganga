import 'package:flutter/material.dart';
import '../crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Coin_History extends StatefulWidget {
   Coin_History(this.sid,this.coins);
  final String sid;
  final int coins;
  @override
  _Coin_HistoryState createState() => _Coin_HistoryState(sid,coins);
}

class _Coin_HistoryState extends State<Coin_History> {
  String sid;
  int coins;
  var userData;
  bool isgot = false;

  var History;
  //var data_upload;
  _Coin_HistoryState(this.sid,this.coins);
   crudMethods crudObj = new crudMethods();

  @override
 void initState() {
    // TODO: implement initState
    super.initState();
    print(sid);
    getData();
     
    
  }
  getData(){
    crudObj.getCRDBdata(this.sid.toUpperCase()).then((docs){
                                setState(() {
                                  userData = docs.documents[0].data;
                                  print(userData);
                                  this.History = userData['History'];
                                  print(History);
                                  this.isgot=true;
                                });
  });}
  Widget _myListView(BuildContext context) {
      return ListView.builder(
        itemCount: History.length,
        itemBuilder: (context, index) {
          if (History[History.length-index-1]['CR/DB']==0) {
            //Credit
             return Card(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              
               elevation: 10,
                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
             child: ListTile(
             
              leading: Icon(Icons.add,color: Colors.green,size: 35,),
              title: Text('Credited',style: TextStyle(
                fontSize: 18,fontWeight: FontWeight.bold
              ),),
              trailing: Text(History[History.length-index-1]['Coins'].toString(),style: TextStyle(
                fontSize: 25,fontWeight: FontWeight.bold,color: Colors.amber
              ),),
              isThreeLine: true,
              subtitle: Text('${History[History.length-index-1]['Reason']}',style: TextStyle(
                fontSize: 15
              ),),

            ),
          );
          }else{
             return Card(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
               elevation: 10,
                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
             child: ListTile(
             
              leading: Icon(Icons.minimize,color: Colors.red,size: 35,),
              title: Text('Debited',style: TextStyle(
                fontSize: 18,fontWeight: FontWeight.bold
              ),),
              trailing: Text(History[History.length-index-1]['Coins'].toString(),style: TextStyle(
                fontSize: 25,fontWeight: FontWeight.bold,color: Colors.redAccent
              ),),
              isThreeLine: true,
              subtitle: Text('${History[History.length-index-1]['Reason']}',style: TextStyle(
                fontSize: 15
              ),),

            ),
          );
          }
         
        },
        
      );
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin History'),
      ),
      body: 
      isgot ?
      Container(
        
                  child: _myListView(context)
        )
      :Container(
        child: Center(child: Text('Loading..'),),
      )
    );
  }
}