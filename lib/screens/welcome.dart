import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Welcome extends StatefulWidget {
  final String userEmail;
  Welcome({this.userEmail});

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String id;
  final db = Firestore.instance;
  String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
        body:SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:Stack(children: <Widget>[
      Container(
        height: 200,
        width: 500,
        padding: EdgeInsets.only(top: 70, left: 70),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(220)),
            color: Colors.amber[800]),
        child: Text('Welcome!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 70)),
      ),

      Container(
          height: 30000,
          margin: EdgeInsets.only(top: 300),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("users")
                .document(widget.userEmail)
                .collection("data")
                .snapshots(),
            builder: (context, snapshot) {
              print("started");
              if (snapshot.data != null) {
                snapshot.data.documents.forEach((doc) {});
                return DataTable(
                  columns: [
                    DataColumn(label: Text('Period 1')),
                    DataColumn(label: Text('Period 2')),
                    DataColumn(label: Text('Period 3')),
                    DataColumn(label: Text('Period 4'))
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

     
    ])
        ), 
        );
  }
}
