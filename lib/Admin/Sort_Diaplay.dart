import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/semantics.dart';

class Sort_Display extends StatefulWidget {
  Sort_Display(this.collection, this.order, this.param);
  final String collection, order, param;
  @override
  _Sort_DisplayState createState() =>
      _Sort_DisplayState(collection, order, param);
}

class _Sort_DisplayState extends State<Sort_Display> {
  String collection, order, param;
  bool isattendance = false;

  _Sort_DisplayState(this.collection, this.order, this.param);

  @override
  void initState() {
    print(collection);
    print(order);
    print(param);
    super.initState();
    if (order == 'Attendance') {
      setState(() {
        isattendance = true;
        this.order = 'Count';
      });
    }
    // updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Students'),
          backgroundColor: Color.fromRGBO(143, 148, 251, 6),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Image.asset(
                'images/logo.png',
              ),
            )
          ],
        ),
        body: Container(

            // padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection(collection)
              .orderBy(order, descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  padding: EdgeInsets.all(20),
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    print(document);
                    return new Card(
                      //margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 15,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                child: Text(
                              document['Sid'].toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                            isattendance
                                ? Container(
                                    child: Text(
                                    '$param : ${document['Attendance'].length}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))
                                : Container(
                                    child: Text(
                                    '$param : ${document[order]}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
            }
          },
        )));
  }
}
