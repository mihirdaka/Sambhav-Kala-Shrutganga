import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../crud.dart';
//import 'crud.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TabController _tabController;
  var username;
  int sutralen = 0;
  int sutraindex = 0;
  int gatha = null;
  String selectedSutra = 'NAVKAR';
  bool isconnected = true;
  crudMethods crudObj = new crudMethods();
  var userData;

  String stavan = null, thoy = null, chaityavandan = null;
  List Sutra = [
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

  List limit = [
    1,
    2,
    1,
    1,
    2,
    7,
    1,
    5,
    7,
    1,
    4,
    5,
    1,
    10,
    1,
    1,
    5,
    5,
    3,
    4,
    4,
    4,
    5,
    1,
    1,
    1,
    2,
    8,
    4,
    2,
    2,
    50,
    3,
    3,
    3,
    1,
    1,
    1,
    1,
    1,
    2,
    1,
    19,
    2,
    13,
    5,
    15,
    33,
    14,
    22,
    14,
    24,
    40,
    84,
    44,
    44,
    51,
    60,
    44,
    30,
    63,
    41,
    48,
    61,
    34,
    25,
    70,
    100,
    91,
    104,
    99,
    127,
    188,
    413,
    273,
    16,
    99999999999
  ];
  String barcode;
  int attendanceval = 0;
  var att;
  int _cIndex = 0, index;
  bool isgot = false;

  TextEditingController _myIDField = TextEditingController();
  TextEditingController _myGathaField = TextEditingController();
  TextEditingController _stavan = TextEditingController();
  TextEditingController _thoy = TextEditingController();
  TextEditingController _chaityavandan = TextEditingController();

  String _email, _password, _name, _phone, _sage, _sid, _study;
  String _photourl =
      "https://firebasestorage.googleapis.com/v0/b/test-8b852.appspot.com/o/user.png?alt=media&token=fc2e9d77-c9c9-4621-b781-44371cb4c4ff";

  @override
  void initState() {
    //_tabController = new TabController(length: 2,);
    super.initState();
  }

  void MessageBox(String title, String content, String command) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          content: Text(content),
          //container
          actions: <Widget>[
            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(command))
          ],
        );
      },
    );
  }

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget SutraUpdate() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 15,
      margin: EdgeInsets.all(20),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Container(
                  child: isgot
                      ? Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Student Name : ${username['Name']}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Update Sutra & Gatha',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Text('Select Sutra : '),
                                    ),
                                    Container(
                                        child: DropdownButton<String>(
                                      value: selectedSutra,
                                      items: Sutra.map((value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String Value) {
                                        setState(() {
                                          this.selectedSutra = Value;
                                          print(selectedSutra);
                                        });
                                      },
                                    )),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                                child: TextField(
                                  controller: _myGathaField,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      this.gatha = int.parse(value);
                                    });
                                  },
                                  style: TextStyle(color: Colors.black87),
                                  cursorColor: Colors.black26,
                                  decoration: InputDecoration(
                                      labelText: 'Gatha NO',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  enableSuggestions: true,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Date : '),
                                  Text("${selectedDate.toLocal()}".split(' ')[0]),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                
                                color: Colors.grey,
                                onPressed: () => _selectDate(context),
                                child: 
                                    Text('Select date'),
                                
                              ),
                              MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  color: Colors.blue,
                                  //elevation: 100,
                                  onPressed: () {
                                    updateSutra();
                                  },
                                  child: Text('Update')),
                            ],
                          ),
                        )
                      : Text('Enter ID To continue')),
            ]),
      ),
    );
  }

  Widget StavanUpdate() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 15,
      margin: EdgeInsets.all(20),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Container(
                  child: isgot
                      ? Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Student Name : ${username['Name']}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Update Stavan & Gatha',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
                                child: TextField(
                                  controller: _stavan,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    setState(() {
                                      this.stavan = value;
                                    });
                                  },
                                  style: TextStyle(color: Colors.black87),
                                  cursorColor: Colors.black26,
                                  decoration: InputDecoration(
                                      labelText: 'Stavan Name',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  enableSuggestions: true,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: TextField(
                                  controller: _myGathaField,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      this.gatha = int.parse(value);
                                    });
                                  },
                                  style: TextStyle(color: Colors.black87),
                                  cursorColor: Colors.black26,
                                  decoration: InputDecoration(
                                      labelText: 'Gatha NO',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  enableSuggestions: true,
                                ),
                              ),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Date : '),
                                  Text("${selectedDate.toLocal()}".split(' ')[0]),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                
                                color: Colors.grey,
                                onPressed: () => _selectDate(context),
                                child: 
                                    Text('Select date'),
                                
                              ),
                              MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  color: Colors.blue,
                                  elevation: 100,
                                  onPressed: () {
                                    updateStavan();
                                  },
                                  child: Text('Update')),
                            ],
                          ),
                        )
                      : Text('Enter ID To continue')),
            ]),
      ),
    );
  }

  Widget ThoyUpdate() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 15,
      margin: EdgeInsets.all(20),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Container(
                  child: isgot
                      ? Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Student Name : ${username['Name']}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Update Thoy & Gatha',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
                                child: TextField(
                                  controller: _thoy,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    setState(() {
                                      this.thoy = value;
                                    });
                                  },
                                  style: TextStyle(color: Colors.black87),
                                  cursorColor: Colors.black26,
                                  decoration: InputDecoration(
                                      labelText: 'Thoy Name',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  enableSuggestions: true,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: TextField(
                                  controller: _myGathaField,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      this.gatha = int.parse(value);
                                    });
                                  },
                                  style: TextStyle(color: Colors.black87),
                                  cursorColor: Colors.black26,
                                  decoration: InputDecoration(
                                      labelText: 'Gatha NO',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  enableSuggestions: true,
                                ),
                              ),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Date : '),
                                  Text("${selectedDate.toLocal()}".split(' ')[0]),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                
                                color: Colors.grey,
                                onPressed: () => _selectDate(context),
                                child: 
                                    Text('Select date'),
                                
                              ),
                              MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  color: Colors.blue,
                                  elevation: 100,
                                  onPressed: () {
                                    updateThoy();
                                  },
                                  child: Text('Update')),
                            ],
                          ),
                        )
                      : Text('Enter ID To continue')),
            ]),
      ),
    );
  }

  Widget ChaityavandanUpdate() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 15,
      margin: EdgeInsets.all(20),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Container(
                  child: isgot
                      ? Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Student Name : ${username['Name']}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Update Chaityavandan & Gatha',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
                                child: TextField(
                                  controller: _chaityavandan,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    setState(() {
                                      this.chaityavandan = value;
                                    });
                                  },
                                  style: TextStyle(color: Colors.black87),
                                  cursorColor: Colors.black26,
                                  decoration: InputDecoration(
                                      labelText: 'Chaityavandan Name',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  enableSuggestions: true,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: TextField(
                                  controller: _myGathaField,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      this.gatha = int.parse(value);
                                    });
                                  },
                                  style: TextStyle(color: Colors.black87),
                                  cursorColor: Colors.black26,
                                  decoration: InputDecoration(
                                      labelText: 'Gatha NO',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  enableSuggestions: true,
                                ),
                              ),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Date : '),
                                  Text("${selectedDate.toLocal()}".split(' ')[0]),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                
                                color: Colors.grey,
                                onPressed: () => _selectDate(context),
                                child: 
                                    Text('Select date'),
                                
                              ),
                              MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  color: Colors.blue,
                                  elevation: 100,
                                  onPressed: () {
                                    updateChi();
                                  },
                                  child: Text('Update')),
                            ],
                          ),
                        )
                      : Text('Enter ID To continue')),
            ]),
      ),
    );
  }

  Future _checkid() async {
    if (_sid.isNotEmpty) {
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
      } else {
        print(_sid);

        crudObj.getStudentdata(this._sid.toUpperCase()).then((docs) {
          setState(() {
            username = docs.documents[0].data;
            //print(userData);
            //var attendance = userData['Attendance'];
            print(username);
            isgot = true;
            //print(attendanceval);
          });
        });
        //print(attendanceval);
      }
    } else {
      MessageBox('Error', 'Enter ID', 'Try again');
    }
  }

  Future updateSutra() async {
    print('inside');
    if (this._sid == null) {
      MessageBox('Error', 'Enter Student ID', 'Try Again');
    } else {
      if (this.gatha == null || this.gatha == 0) {
        MessageBox('Error', 'Enter Correct Gatha', 'Try Again');
      } else {
        //update
        for (int i = 0; i < Sutra.length; i++) {
          if (Sutra[i] == selectedSutra) {
            setState(() {
              this.sutraindex = i;
              print(i);
            });
          }
        }
        var now = new DateTime.now();
        var formatter = new DateFormat('H:m');
        String formattedDate = formatter.format(now);
        print(formattedDate);
        if (_myGathaField.text != null) {
          if (gatha <= limit[sutraindex]) {
            final snapShot = await Firestore.instance
                .collection('Sutra')
                .document(_sid.toUpperCase())
                .get();
            String snap = snapShot.toString();
            print(snap);
            print(snapShot);
            if (snapShot == null || !snapShot.exists) {
              //create doc
              print('not exist');
              crudObj.addSutraData({
                'Sid': this._sid.toUpperCase(),
                //'Namawali' : coin,
                'Sutra': [
                  {
                    'Date': "${selectedDate.toLocal()}".split(' ')[0]+'/$formattedDate',
                    'Gatha': int.parse(_myGathaField.text),
                    'Sutrano': sutraindex
                  }
                ],
                'Count': 1
              }).then((result) {
                MessageBox('Done', 'Updated Successfully', 'Ok');
              });
              //_showCoinDialog(coinearned);

            } else {
              //update doc
              print('in');
              crudObj.updateSutraData({
                'Sid': this._sid.toUpperCase(),
                //'Namawali' : coin,
                'Sutra': [
                  {
                    'Date': "${selectedDate.toLocal()}".split(' ')[0]+'/$formattedDate',
                    'Gatha': int.parse(_myGathaField.text),
                    'Sutrano': sutraindex
                  }
                ],
                'Count': 1
              }).then((result) {
                MessageBox('Done', 'Updated Successfully', 'Ok');
              });
            }
          } else {
            MessageBox('Error', 'Enter Correct Gatha No', 'Try Again');
          }
        } else {
          MessageBox('Error', 'Enter Gatha No', 'try again');
        }

        //    formatdata(userData);
        //var update;

      }
    }
  }

  Future updateStavan() async {
    print('here');
    if (this._sid == null) {
      MessageBox('Error', 'Enter Student ID', 'Try Again');
    } else {
      if (this.stavan == null || this.stavan == '') {
        MessageBox('Error', 'Enter Correct Stavan Name', 'Try Again');
      } else {
        //update

        var now = new DateTime.now();
        var formatter = new DateFormat('H:m');

        String formattedDate = formatter.format(now);
        print(formattedDate);
        if (_myGathaField.text != null && this.gatha != 0) {
          final snapShot = await Firestore.instance
              .collection('Stavan')
              .document(_sid.toUpperCase())
              .get();
          String snap = snapShot.toString();
          print(snap);
          print(snapShot);
          if (snapShot == null || !snapShot.exists) {
            //create doc
            print('not exist');
            crudObj.addStavanData({
              'Sid': this._sid.toUpperCase(),
              //'Namawali' : coin,
              'Stavan': [
                {
                  'Date': "${selectedDate.toLocal()}".split(' ')[0]+'/$formattedDate',
                  
                  'Stavan': stavan,
                  'Gatha': gatha,
                  'Type': 0
                }
              ],
              'Count': 1
            }).then((result) {
              MessageBox('Done', 'Updated Successfully', 'Ok');
            });
            //_showCoinDialog(coinearned);

          } else {
            //update doc
            print('in');
            crudObj.updateStavanData({
              'Sid': this._sid.toUpperCase(),
              //'Namawali' : coin,
              'Stavan': [
                {
                  'Date': "${selectedDate.toLocal()}".split(' ')[0]+'/$formattedDate',
                  
                  'Stavan': stavan,
                  'Gatha': gatha,
                  'Type': 0
                }
              ]
            }).then((result) {
              MessageBox('Done', 'Updated Successfully', 'Ok');
            });
          }
        } else {
          MessageBox('Error', 'Enter Gatha No', 'try again');
        }

        //    formatdata(userData);
        //var update;

      }
    }
  }

  Future updateThoy() async {
    print('here');
    if (this._sid == null) {
      MessageBox('Error', 'Enter Student ID', 'Try Again');
    } else {
      if (this.thoy == null || this.thoy == '') {
        MessageBox('Error', 'Enter Correct Thoy Name', 'Try Again');
      } else {
        //update

        var now = new DateTime.now();
        var formatter = new DateFormat('H:m');

        String formattedDate = formatter.format(now);
        print(formattedDate);
        if (_myGathaField.text != null && this.gatha != 0) {
          final snapShot = await Firestore.instance
              .collection('Stavan')
              .document(_sid.toUpperCase())
              .get();
          String snap = snapShot.toString();
          print(snap);
          print(snapShot);
          if (snapShot == null || !snapShot.exists) {
            //create doc
            print('not exist');
            crudObj.addStavanData({
              'Sid': this._sid.toUpperCase(),
              //'Namawali' : coin,
              'Stavan': [
                {
                  'Date': "${selectedDate.toLocal()}".split(' ')[0]+'/$formattedDate',
                  
                  'Stavan': thoy,
                  'Gatha': gatha,
                  'Type': 1
                }
              ],
              'Count': 1
            }).then((result) {
              MessageBox('Done', 'Updated Successfully', 'Ok');
            });
            //_showCoinDialog(coinearned);

          } else {
            //update doc
            print('in');
            crudObj.updateStavanData({
              'Sid': this._sid.toUpperCase(),
              //'Namawali' : coin,
              'Stavan': [
                {
                                      'Date': "${selectedDate.toLocal()}".split(' ')[0]+'/$formattedDate',

                  'Stavan': thoy,
                  'Gatha': gatha,
                  'Type': 1
                }
              ],
              'Count': 1
            }).then((result) {
              MessageBox('Done', 'Updated Successfully', 'Ok');
            });
          }
        } else {
          MessageBox('Error', 'Enter Gatha No', 'try again');
        }

        //    formatdata(userData);
        //var update;

      }
    }
  }

  Future updateChi() async {
    print('here');
    if (this._sid == null) {
      MessageBox('Error', 'Enter Student ID', 'Try Again');
    } else {
      if (this.chaityavandan == null || this.chaityavandan == '') {
        MessageBox('Error', 'Enter Correct Chaityavandan Name', 'Try Again');
      } else {
        //update

        var now = new DateTime.now();
        var formatter = new DateFormat('H:m');

        String formattedDate = formatter.format(now);
        print(formattedDate);
        if (_myGathaField.text != null && this.gatha != 0) {
          final snapShot = await Firestore.instance
              .collection('Stavan')
              .document(_sid.toUpperCase())
              .get();
          String snap = snapShot.toString();
          print(snap);
          print(snapShot);
          if (snapShot == null || !snapShot.exists) {
            //create doc
            print('not exist');
            crudObj.addStavanData({
              'Sid': this._sid.toUpperCase(),
              //'Namawali' : coin,
              'Stavan': [
                {
                                      'Date': "${selectedDate.toLocal()}".split(' ')[0]+'/$formattedDate',

                  'Stavan': chaityavandan,
                  'Gatha': gatha,
                  'Type': 2
                }
              ],
              'Count': 1
            }).then((result) {
              MessageBox('Done', 'Updated Successfully', 'Ok');
            });
            //_showCoinDialog(coinearned);

          } else {
            //update doc
            print('in');
            crudObj.updateStavanData({
              'Sid': this._sid.toUpperCase(),
              //'Namawali' : coin,
              'Stavan': [
                {
                  'Date': "${selectedDate.toLocal()}".split(' ')[0]+'/$formattedDate',

                  'Stavan': chaityavandan,
                  'Gatha': gatha,
                  'Type': 2
                }
              ]
            }).then((result) {
              MessageBox('Done', 'Updated Successfully', 'Ok');
            });
          }
        } else {
          MessageBox('Error', 'Enter Gatha No', 'try again');
        }

        //    formatdata(userData);
        //var update;

      }
    }
  }

  Future scan() async {
    String _sid = await scanner.scan();
    setState(() => this._sid = _sid);
    print(_sid);
    setState(() {
      this._myIDField.text = _sid;
    });
    _checkid();
  }

  Widget callPages(int _page) {
    switch (_cIndex) {
      case 0:
        return Container(child: SutraUpdate());
        break;
      case 1:
        return Container(child: StavanUpdate());
      case 2:
        return Container(child: ThoyUpdate());
      case 3:
        return Container(child: ChaityavandanUpdate());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Color.fromRGBO(143, 148, 251, 6),
        currentIndex: _cIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.toc), title: Text('Gatha')),
          BottomNavigationBarItem(icon: Icon(Icons.toc), title: Text('Stavan')),
          BottomNavigationBarItem(icon: Icon(Icons.toc), title: Text('Thoy')),
          BottomNavigationBarItem(
              icon: Icon(Icons.toc), title: Text('Chaityavandan'))
        ],
        onTap: (index) {
          setState(() {
            _cIndex = index;
          });
        },
        //controller: _tabController,
      ),
      appBar: AppBar(
        title: Text('Update Sutra'),
        backgroundColor: Color.fromRGBO(143, 148, 251, 6),
        actions: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: IconButton(icon: Icon(Icons.scanner), onPressed: scan))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(25, 20, 25, 0),
              child: TextField(
                controller: _myIDField,
                onChanged: (value) {
                  setState(() {
                    this._sid = value;
                  });
                },
                style: TextStyle(color: Colors.black87),
                cursorColor: Colors.black26,
                decoration: InputDecoration(
                    labelText: 'Student ID',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                enableSuggestions: true,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 25, 0),

              //height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.blue,
                  elevation: 100,
                  onPressed: () {
                    _checkid();
                  },
                  child: Text('Search')),

              /*Center(
	                            child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15),),
                                 )*/
            ),
            callPages(_cIndex),
          ],
        ),
      ),
    );
  }
}
