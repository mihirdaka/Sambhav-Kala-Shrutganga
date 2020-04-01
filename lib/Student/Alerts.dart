import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Updates_Page extends StatefulWidget {
  @override
  _Updates_PageState createState() => _Updates_PageState();
}


class _Updates_PageState extends State<Updates_Page> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alerts'),
      ),
      body: Container(
        
                  child: Container(
           // padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('Alerts').orderBy('Timestamp',descending: true)
                .snapshots(),
              builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new ListView(
                        padding: EdgeInsets.all(20),
                        children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                            return new Card(
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
                                      child: Image.network(
                                        
                                        document['Image'],
                                        fit: BoxFit.fitHeight,
                                        scale:0.5,
                                        semanticLabel: 'Update Image',
                                        loadingBuilder: (context,child,progress){
                                          return progress == null
                                          ?child
                                          :LinearProgressIndicator(
                                            backgroundColor: Colors.blue,
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: Text(document['Title'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                    Divider(),
                                    Text(document['Message'])

                                  ],
                                ),
                              ),
                             
                            );
                        }).toList(),
                      );
                  }
                },
              )),
        ),
          
     
    );
  }
  
}