import 'package:flutter/material.dart';
import '../sexy_tile.dart';
import 'Sort_Diaplay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance_sort extends StatefulWidget {
  @override
  _Attendance_sortState createState() => _Attendance_sortState();
}


class _Attendance_sortState extends State<Attendance_sort> {
  String name = 'Namawali[0]';
    List<String> itemNames = [
        'Sort By Sutra',
        'Sort By Attendance',
        'Sort By 12 Navkar',
        'Sort By Mata Pita Vadilo ko pranam',
        'Sort By Dev Darshan',
        'Sort By Guru Vandan',
        'Sort By Jinpuja',
        'Sort By Chaityavandan',
        'Sort By Samayik',
        'Sort By Kandmool',
        'Sort By Ratri Bhojan',
        'Sort By Ast Prakari Puja',
        'Sort By Pachkan Morning',
        'Sort By Pachkan evening',
        'Sort By Thali Dhokar Pina',
        'TV Cinema/Mobile Games Tyag',
        'Bread/Butter/Chese/Mayonese Tyag',

    ]; //n
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sort'),
              backgroundColor: Color.fromRGBO(143, 148, 251, 6),

       actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Image.asset('images/logo.png',),
              
              
            )
            
        ],
      

      ),
      body: Container(
        child :Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
            Expanded(
              
              child: GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 5,
                children: List.generate(
                  itemNames.length,
                  (index) {
                    return Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Hero(
                          tag:
                              'tile1$index', 
                          child: Card(
                          
                          margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                                        ),
                                elevation: 5,
                          ),

                        ),
                        Container(
                         // height: 10,
                         // alignment: MainAxisAlignment.center,
                          margin: EdgeInsets.all(15.0),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  
                                  Hero(
                                    
                                    tag: 'title$index',
                                    child: Material(
                                    
                                      color: Colors.transparent,
                                      child: Text(
                                        
                                        '${itemNames[index]}',
                                         style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  //Icon(Icons.navigate_next)
                                ],
                              ),
                              splashColor: Colors.red,
                              borderRadius: BorderRadius.circular(15.0),
                              onTap: (){
                               Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(
                                 builder: (BuildContext context){
                                      if (index == 0) {
                                        return Sort_Display('Sutra', 'Count', 'Gatha');
                                      }
                                      else if (index == 1) {
                                        return Sort_Display('Attendance','Attendance','Days');
                                      }
                                      else if (index == 2) {
                                        return Sort_Display('Namawali','0','Days');
                                      }
                                      else if (index == 3) {
                                        return Sort_Display('Namawali','1','Days');
                                      }
                                      else if (index == 4) {
                                        return Sort_Display('Namawali','2','Days');
                                      }
                                      else if (index == 5) {
                                        return Sort_Display('Namawali','3','Days');
                                      }
                                      else if (index == 6) {
                                        return Sort_Display('Namawali','4','Days');
                                      }
                                      else if (index == 7) {
                                        return Sort_Display('Namawali','5','Days');
                                      }
                                      else if (index == 8) {
                                        return Sort_Display('Namawali','6','Days');
                                      }
                                      else if (index == 9) {
                                        return Sort_Display('Namawali','7','Days');
                                      }
                                      else if (index == 10) {
                                        return Sort_Display('Namawali','8','Days');
                                      }
                                      else if (index == 11) {
                                        return Sort_Display('Namawali','9','Days');
                                      }
                                      else if (index == 12) {
                                        return Sort_Display('Namawali','10','Days');
                                      }
                                      else if (index == 13) {
                                        return Sort_Display('Namawali','11','Days');
                                      }
                                      else if (index == 14) {
                                        return Sort_Display('Namawali','12','Days');
                                      }
                                      else if (index == 15) {
                                        return Sort_Display('Namawali','13','Days');
                                      }
                                      else if (index == 16) {
                                        return Sort_Display('Namawali','14','Days');
                                      }
                                     
                                   

                                 }
                              
                            )
                            
                            )
                            ;
                            }
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ));
           
      }
          }