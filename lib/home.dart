import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giiiii/facultylogin.dart';
import 'home1.dart';
import 'screens/welcome.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/stulogin.jpg'),fit: BoxFit.fitHeight),
                borderRadius: BorderRadius.only(
                  
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(50)),
                color: Colors.blue[900]),
          ),
          Container(
            padding: EdgeInsets.only(top: 80, left: 7),
            child: Text(
              'STUDENT',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                  
                  fontFamily: 'Pacifico',
                  color: Colors.blue[900]),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 160, left: 7),
            child: Text(
              'LOGIN',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                  fontFamily: 'Montserrat',
                  color: Colors.blue[900]),
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
                          style: TextStyle(
                            color: Colors.orange
                          ),
                          onSaved: (save) {
                            this.email = save;
                            
                          },
                          validator: (input) {
                            if (input.isEmpty) {
                              return "email cannot be empty";
                            } else if ((!input.contains("@")) &&
                                (!input.contains("."))) {
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
                           style: TextStyle(
                            color: Colors.orange
                          ),
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
                                        builder: (context) => MyStatefulWidget(
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
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top:55),
                  //   padding: EdgeInsets.all(10),
                  //   child:InkWell(
                  //     onTap: (){
                  //        Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                       builder: (context) => Facultylog(
                                          
                  //                           )));
                  //     },
                  //     child: Text(
                  //       'Faculty',
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontFamily: 'Montserrat',
                  //           fontSize: 30,
                  //           color: Colors.white),
                  //     ),
                  //   ),
                  //    decoration: BoxDecoration(
                  //     color: Colors.amber[800],
                  //     borderRadius: BorderRadius.all(Radius.circular(20)),
                  //   ),
                  // )
                ],
              ))
        ],
      ),
    ));
  }
}
