import 'package:flutter/material.dart';
import 'package:giiiii/home1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giiiii/screens/accounts/chat.dart';
import 'package:giiiii/screens/accounts/circular.dart';
import 'package:giiiii/screens/accounts/facleave.dart';
import 'package:giiiii/screens/accounts/leavehistory.dart';
import 'package:giiiii/screens/accounts/series.dart';
import 'package:giiiii/screens/facatten.dart';
import 'package:giiiii/screens/notification.dart';
import 'package:giiiii/screens/realtime.dart';
import 'package:giiiii/screens/welcome.dart';
import 'package:giiiii/screens/welcome2.dart';

class Facwel extends StatefulWidget {
  final String userEmail;
  Facwel({this.userEmail});

  @override
  _FacwelState createState() => _FacwelState();
}

class _FacwelState extends State<Facwel> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('Welcome!'),
        backgroundColor: Colors.amber[800],
      ),
      drawer: Drawer(
        
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(widget.userEmail,style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'pacifico'),), accountEmail:null ,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/fac.jpg'))
              ),
              ),
          ListTile(
            title: Text('chat'),
            trailing: Icon(Icons.chat),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FirestoreCRUDPage()));
            },
          ),
          ListTile(
            title: Text('Apply leave'),
            trailing: Icon(Icons.credit_card),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Facleave()));
            },
          ),
          ListTile(
            title: Text('Manage leave'),
            trailing: Icon(Icons.credit_card),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => History()));
            },
          ),
           ListTile(
            title: Text('Manage Attendance'),
            trailing: Icon(Icons.credit_card),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Facset()));
            },
          ),
          ListTile(
            title: Text('Enter Series marks'),
            trailing: Icon(Icons.present_to_all),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Series()));
            },
          ),
          ListTile(
            title: Text('Current Attendance'),
            trailing: Icon(Icons.queue),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Realtime()));
            },
          ),
          ListTile(
            title: Text('Notifications'),
            trailing: Icon(Icons.slideshow),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => notification()));
            },
          ),
          ListTile(
            title: Text('Cicular'),
            trailing: Icon(Icons.pages),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Circular()));
            },
          ),
          
        ],
      )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Stack(
            children: <Widget>[
              Container(
                  //height: 30000,
                  margin: EdgeInsets.only(top: 300),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection("faculty")
                        .document(widget.userEmail)
                        .collection("data")
                        .snapshots(),
                    builder: (context, snapshot) {
                      print("started");
                      if (snapshot.data != null) {
                        snapshot.data.documents.forEach((doc) {});
                        return DataTable(
                          columns: [
                            DataColumn(label: Text('Hour 1')),
                            DataColumn(label: Text('Hour 2')),
                            DataColumn(label: Text('Hour 3')),
                            DataColumn(label: Text('Hour 4')),
                            DataColumn(label: Text('Hour 5')),
                            DataColumn(label: Text('Hour 6')),
                          ],
                          rows: snapshot.data.documents.map((doc) {
                            if (doc != null) {
                              doc.data.remove("email");
                              print(doc.data);
                            }
                            return DataRow(
                              cells: doc.data.entries.map((cell) {
                                return DataCell(Text(cell.value));
                              }).toList(),
                            );
                          }).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class Facset extends StatefulWidget {
  Facset({Key key}) : super(key: key);

  @override
  _FacsetState createState() => _FacsetState();
}

class _FacsetState extends State<Facset> {
   final formkey =GlobalKey<FormState>();
   String _name;
   String _sub;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage attendance'),

      ),
      body: Column(
        children: [
          Form(key: formkey,
         child:
         Column(children: <Widget>[
           TextFormField(
            onSaved: (input)=> _name = input,
            
              decoration: InputDecoration(
                              labelText: 'Email',)
           ),
           TextFormField(
            onSaved: (input)=> _sub = input,
            
              decoration: InputDecoration(
                              labelText: 'Subject',)
           ),
           ])),
           
           
           RaisedButton(
             child: Text('next'),
             
             onPressed: Data6,
           )
        ],
      )
    );
  }
  void Data6(){
    formkey.currentState.save();
    Navigator.push(context, MaterialPageRoute(builder: (context) => welcome2(
      userEmail : this._name,
      
      
    )));
    print(_name);
  }
}