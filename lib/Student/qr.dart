import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../crud.dart';

class QR extends StatefulWidget {
  @override
  QR(this.sid);
  final String sid;
  _QRState createState() => _QRState(sid);
}

class _QRState extends State<QR> {
  String sid;
  _QRState(this.sid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 15,
                margin: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(30),
                      child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/test-8b852.appspot.com/o/QR%2F${sid.toUpperCase()}?alt=media',
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            
                          ),
                        );
                      }),
                    ),
                    Container(
                      padding: EdgeInsets.all(30),
                      child: Text('ID : ${sid.toUpperCase()}',style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                    )
                  ],
                ),
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
