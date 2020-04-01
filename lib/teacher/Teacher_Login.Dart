import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tatvagyankendra/Admin/admin_home.dart';
import '../crud.dart';
import 'Teacher_home.dart';


class Teacher_Login extends StatefulWidget {
  @override
  _Teacher_LoginState createState() => _Teacher_LoginState();
}

class _Teacher_LoginState extends State<Teacher_Login> {
  String username,password='';
 crudMethods crudObj = new crudMethods();

  var userData;
  String real_password=null;
  void _onLoading()  {

GetData();
 showCupertinoDialog<dynamic>(
   
                                    context: context,
                                    
                                    builder: (BuildContext context) => CupertinoAlertDialog(
                                      
                                      title: Text('Loading'),
                                      
                                      content: Container(
                                        margin: EdgeInsets.all(20),
                                        
                                        child:CupertinoActivityIndicator(animating: true,radius: 30,),
                                      )
                                      

            )
            );

  
  
}


  void GetData()async{
    crudObj.getTeacherdata(this.username.toUpperCase()).then((docs){
      setState(() {
        userData = docs.documents[0].data;
        //print(userData)
        this.real_password = userData['password'];
        print(real_password);
        this.validate();
      });
    });
    }
    void validate()async{
     if(real_password==password){
                                    Navigator.pop(context);
                                    Navigator.push(context,  
                                    CupertinoPageRoute(
                                    builder: (_) => Teacher_Home(tid: this.username,)));
            }
            
            
            else{
                                    //Navigator.pop(context);

                                    showCupertinoDialog<dynamic>(
                                    context: context,
                                    builder: (BuildContext context) => CupertinoAlertDialog(

                                      title: Text('Error'),
                                      content: Text('Username or Password is incorrect'),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                            child: const Text('Try again!'),
                                            onPressed: (){

                                               Navigator.pop(context,'Try Again!'); 
                                            }
                                         )
                                      ],
                                      

                                    )
                                  );
  }
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
       navigationBar: CupertinoNavigationBar(
       
      middle:
      Text('Login'),
      previousPageTitle: 'Home',
     
    ),
    backgroundColor: Colors.white,
    child: 
      Container(
        
        margin: EdgeInsets.fromLTRB(30, 90, 30, 30),
        //padding: EdgeInsets.fromLTRB(0, 60, 0, 60),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            style: BorderStyle.solid
  )
            
          ),
          child: Container(
            
            child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                   Center(
                    child: Container(
                      width: 130.0,
                      height: 130.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("images.png")
                          
                        )
                      ),
                    ),
                  ),
                  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          
                          children: <Widget>[
                            
                             Text('Username : '),
                             
                             Container(
                                 //padding: EdgeInsets.all(30),
                                 
                                width: 200,
                                 child: 
                                 CupertinoTextField(
                                   onChanged: (value){
                                    setState(() {
                                    username = value; 
                                    });
                                  },
                                  style: TextStyle(
                                    color: Colors.black87
                                  ),
                                  cursorColor: Colors.black26,
                                  placeholder: 'Username',
                              
                                  
                                  placeholderStyle: TextStyle(
                                    color: Colors.black26
                                  ),
                                  enableSuggestions: true,
                                  clearButtonMode: OverlayVisibilityMode.editing,
                                  decoration: BoxDecoration(
                                    color: Colors.white30,
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                 ),
                               ),
                                
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          
                          children: <Widget>[
                            
                             Text('Password : '),
                             
                             Container(
                                 //padding: EdgeInsets.all(30),
                                 
                                width: 200,
                                 child: 
                                 CupertinoTextField(
                                   onChanged: (value){
                                    setState(() {
                                    password = value; 
                                    });
                                  },
                                  style: TextStyle(
                                    color: Colors.black87
                                  ),
                                  cursorColor: Colors.black26,
                                  placeholder: 'Password',
                              
                                  
                                  placeholderStyle: TextStyle(
                                    color: Colors.black26
                                  ),
                                  enableSuggestions: true,
                                  clearButtonMode: OverlayVisibilityMode.editing,
                                  decoration: BoxDecoration(
                                    color: Colors.white30,
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                 ),
                               ),
                          ]
                        ),
                                 CupertinoButton.filled(
                                 child: Text('Login'),
                                  

                                
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                                ), 
                                onPressed: (){
                                  _onLoading();
                               }
                                
 
              )]
              )
            
          )
      ),
      );
  }
}



