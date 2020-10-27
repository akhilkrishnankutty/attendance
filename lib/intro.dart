

import 'package:flutter/material.dart';
import 'package:giiiii/facultylogin.dart';
import 'package:giiiii/home.dart';

class Intro extends StatefulWidget {
  Intro({Key key}) : super(key: key);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Attendance system',
            style: TextStyle(
              fontSize: 45,
              fontFamily: 'pacifico',
              color: Colors.blueGrey[400]
            ),
            ),
            SizedBox(
              height: 45,
            ),
            CircleAvatar(
              child: Image.asset('images/intro.png'),
              radius: 150,
            ),
          SizedBox(height: 30,),
            Card(
              margin: EdgeInsets.all(19),
              color: Colors.blue[700],
                child: ListTile(
                 //contentPadding: EdgeInsets.all(9),
                  leading:Icon(Icons.person_pin_circle,size: 30,),
                  title:Align(
                                      child: Text('Student',style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'pacifico',
                      color: Colors.white
                    ),),
                      alignment: Alignment(-0.3, 0),
                  ),
                  dense: true,
                  onTap: (){
                         Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home(
                                          
                                            )));}
                 
                ),
              ),
               SizedBox(height: 30,),
            Card(
               margin: EdgeInsets.all(19),
              color: Colors.blue[700],
              
                child: ListTile(
                 //contentPadding: EdgeInsets.all(9),
                  leading:Icon(Icons.person,size: 30,),
                  title:Align(
                                      child: Text('Faculty',style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'pacifico',
                      color: Colors.white
                    ),),
                      alignment: Alignment(-0.3, 0),
                  ),
                  dense: true,
                    onTap: (){
                         Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Facultylog(
                                          
                                            )));}
                ),
              ),
            

          ],
        ),
      ),
    );
  }
}