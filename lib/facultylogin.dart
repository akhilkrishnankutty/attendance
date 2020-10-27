import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:giiiii/screens/facwel.dart';

class Facultylog extends StatefulWidget {
  Facultylog({Key key}) : super(key: key);

  @override
  _FacultylogState createState() => _FacultylogState();
}

class _FacultylogState extends State<Facultylog> {
 
 String email;
  String password;
   GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
        body: SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            height: 330,
            decoration: BoxDecoration(
              image: DecorationImage(image:AssetImage('images/faclogin.jpg'),fit: BoxFit.fitHeight),
                borderRadius: BorderRadius.only(
                  
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(50)),
                color: Colors.amber[800]),
          ),
          Container(
            padding: EdgeInsets.only(top: 80, left: 7),
            child: Text(
              'FACULTY',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 70,
                  //fontFamily: 'Pacifico',
                  color: Colors.blue[700]),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 165, left: 7),
            child: Text(
              'LOGIN',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                  fontFamily: 'Montserrat',
                  color: Colors.white),
            ),
          ),
          Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                      padding:
                          EdgeInsets.only(top: 400.0, left: 20.0, right: 20.0),
                      child: Column(children: <Widget>[
                        TextFormField(
                          
                          onSaved: (save) {
                            this.email = save;
                          },
                          validator: (String input) {
                            if (input.isEmpty) {
                              return 'email cannot be empty';
                            } else if ((!input.contains("@ncerc")) &&
                                (!input.contains("ncerc")) && (!input.contains("."))) {
                              return "please type a valid email";
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          onSaved: (save) {
                            this.password = save;
                          },
                          validator: (input) {
                            if (input.isEmpty) {
                              return "please type a valid passowrd";
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          obscureText: true,
                        )
                      ])),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () async {
                        
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          
                          if (email != null && password != null) {
                          
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password)
                                .then((result) {
                             
                              if (result.user != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Facwel(
                                               userEmail: this.email,
                                            )));
                              }
                            }).catchError((e) {
                              print(e);
                            });
                          }
                        }
                      },
                      child: Text(
                        'SignIn',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber[800],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ],
              ))
        ],
      ),
    ));

    
  }
}