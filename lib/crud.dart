import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:tatvagyankendra/Student/Namawali.dart';


class crudMethods{

  //final FirebaseAuth _auth = FirebaseAuth.instance;
  //FirebaseUser user;
  String _uid;
  String code;




  Future<void> addData(userData) async{
   
    _uid = userData['Sid'];
 
   Firestore.instance.collection('Student').document(_uid).setData(userData).catchError((error){
     
   });
   var data = {
     'Attendance' : [],
     'Sid' : _uid,
     'Count' :0
   };
   Firestore.instance.collection('Attendance').document(_uid).setData(data);
  }

  Future<void>updateStuData(addData) async{
   _uid=addData['Sid'];
    String url = addData['PhotoUrl'];
   Firestore.instance.collection('Student').document(_uid.toUpperCase()).updateData({'PhotoUrl': '$url'}).catchError((error){
     print(error);
   });
  }
Future<void>postmessage(addData) async{
   //_uid=addData['Sid'];
   String title=addData['Title'];
 
   Firestore.instance.collection('Alerts').document(title.toUpperCase()).setData(addData).catchError((error){
     print(error);
   });
  }
  Future<void>upddatepostmessage(addData) async{
   //_uid=addData['Sid'];
   String title=addData['Title'];
 
   Firestore.instance.collection('Alerts').document(title.toUpperCase()).updateData(addData).catchError((error){
     print(error);
   });
  }
    Future<void>updateTeacherData(addData) async{
   _uid=addData['Tid'];
   print(_uid);
    String url = addData['PhotoUrl'];
    String password = addData['password'];
   Firestore.instance.collection('Teacher').document(_uid.toUpperCase()).updateData({'PhotoUrl': '$url'}).catchError((error){
     print(error);
   });
  }



  Future<void>updateeditData(addData) async{
   _uid=addData['Sid'];
    String url = addData['PhotoUrl'];
   Firestore.instance.collection('Student').document(_uid).updateData(addData).catchError((error){
     print(error);
   });
  }





  


  Future<void> addteacherimage(userData) async{
   
    _uid = userData['Tid'];
  String photourl = userData['PhotoUrl'];
   Firestore.instance.collection('Teacher').document(_uid).updateData({'PhotoUrl' : '$photourl'}).catchError((error){
     
   });
  }

  Future<void> addteacherData(userData) async{
   
    _uid = userData['Tid'];
 
   Firestore.instance.collection('Teacher').document(_uid).setData(userData).catchError((error){
     
   });
    var data = {
     'Attendance' : [],
     'Tid' : _uid
   };
   Firestore.instance.collection('Teacher.Attendance').document(_uid.toUpperCase()).setData(data);
  }
  Future<void> addNamawaliData(userData) async{
   
    _uid = userData['Sid'];
 
   Firestore.instance.collection('Namawali').document(_uid).setData(userData).catchError((error){
     print(error);
   });
  

   print('done');
  }
  Future<void> addSutraData(userData) async{
   
    _uid = userData['Sid'];
 
   Firestore.instance.collection('Sutra').document(_uid).setData(userData).catchError((error){
     print(error);
   });
  

   print('done');
  }
  
  
  Future<void> updateNamawaliData(userData) async{
   print('inside');
    _uid = userData['Sid'];
   
   
  Firestore.instance.collection('Namawali').document(_uid).updateData(userData).catchError((error){
     print(error);
   });
   }
   
   
   Future<void> addCRDBHistoryData(userData) async{
   
    _uid = userData['Sid'];
 
   Firestore.instance.collection('CR.DB').document(_uid).setData(userData).catchError((error){
     print(error);
   });
   }
  
  Future<void> updateCoinData(userData) async{
   
    _uid = userData['Sid'];
    
   Firestore.instance.collection('Student').document(_uid).updateData({'Points' : userData['Coins']+userData['Coin']}).catchError((error){
     print(error);
   });
  
  }
   
  Future<void> updateCoinCRDBData(userData) async{
   
    _uid = userData['Sid'];
    
   Firestore.instance.collection('Student').document(_uid).updateData({'Coins' : userData['Coins']}).catchError((error){
     print(error);
   });
  
  }
  Future<void>updateCRDBData(data) async{

      String uid = data['Sid'];
     //return Firestore.instance.collection('Attendance').;
     
   Firestore.instance.collection('CR.DB').document(uid).updateData({'History' : FieldValue.arrayUnion(data['History'])}).catchError((error){
     print(error);
   });
  }
Future<void>updateSutraData(data) async{

      String uid = data['Sid'];
     //return Firestore.instance.collection('Attendance').;
     
   Firestore.instance.collection('Sutra').document(uid).updateData({'Sutra' : FieldValue.arrayUnion(data['Sutra'])}).then((value){
      Firestore.instance.collection('Sutra').document(uid).updateData({'Count' : FieldValue.increment(1)}).catchError((error){
     print(error);
   });
   }).catchError((error){
     print(error);
   });
  
  }

  Future<void> addStavanData(userData) async{
   
    _uid = userData['Sid'];
  print('here');
   Firestore.instance.collection('Stavan').document(_uid).setData(userData).catchError((error){
     print(error);
   });
  

   print('done');
  }
  Future<void>updateStavanData(data) async{

      String uid = data['Sid'];
     //return Firestore.instance.collection('Attendance').;
     
   Firestore.instance.collection('Stavan').document(uid).updateData({'Stavan' : FieldValue.arrayUnion(data['Stavan'])}).then((value) {
      Firestore.instance.collection('Stavan').document(uid).updateData({'Count' : FieldValue.increment(1)}).catchError((error){
     print(error);
   });
   }).catchError((error){
     
     print(error);
   });
  }



getTeacherdata(String tid) async{

    return Firestore.instance.collection('Teacher').where('Tid', isEqualTo: tid).getDocuments();
  }


getStudentdata(String tid) async{

    return Firestore.instance.collection('Student').where('Sid', isEqualTo: tid).getDocuments();
}

getAttendancedata(String tid) async{

    return Firestore.instance.collection('Attendance').where('Sid',isEqualTo : tid).getDocuments();
}
getSutradata(String tid) async{

    return Firestore.instance.collection('Sutra').where('Sid',isEqualTo : tid).getDocuments();
}
getStavandata(String tid) async{

    return Firestore.instance.collection('Stavan').where('Sid',isEqualTo : tid).getDocuments();
}
getTeacherAttendancedata(String tid) async{

    return Firestore.instance.collection('Teacher.Attendance').where('Tid',isEqualTo : tid).getDocuments();
}

getNamawalidata(String tid) async{

    return Firestore.instance.collection('Namawali').where('Sid',isEqualTo : tid).getDocuments();
}


getCRDBdata(String sid)async{
  return Firestore.instance.collection('CR.DB').where('Sid',isEqualTo : sid).getDocuments();
}
Future<void>attendanceData(String uid,data) async{
   //var datato;
  print(uid);
      var now = new DateTime.now();
      var formatter = new DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(now);
      print(formattedDate);
     //return Firestore.instance.collection('Attendance').;
     
   Firestore.instance.collection('Attendance').document(uid).updateData({'Attendance' : FieldValue.arrayUnion([formattedDate])}).then((value) {
     Firestore.instance.collection('Attendance').document(uid).updateData({'Count' : FieldValue.increment(1)}).catchError((error){
     print(error);
   });
   }).catchError((error){
     print(error);
   });
  }

Future<void>teacherattendanceData(data) async{
   //var datato;
     // print(uid);
      var now = new DateTime.now();
      var formatter = new DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(now);
      print(formattedDate);
      String tid=data['Tid'];
     //return Firestore.instance.collection('Attendance').;
     
   Firestore.instance.collection('Teacher.Attendance').document(tid.toUpperCase()).updateData({'Attendance' : FieldValue.arrayUnion([formattedDate])}).catchError((error){
     print(error);
   });
  }
















}