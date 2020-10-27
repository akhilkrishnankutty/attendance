import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class notification extends StatelessWidget {
  List<Widget> hoo(AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((document) {
      return Card(
        child: ListTile(title: Text(document['noti'])),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
        body: Stack(
      children: <Widget>[
        Container(
          height: 200,
          width: 500,
          padding: EdgeInsets.only(top: 70, left: 70),
          decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage('images/noti.jpg',),fit:BoxFit.fitWidth),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
              color: Colors.amber[800]),
          child: Align(
                      child: Text('Notifications',
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.blueAccent[600], fontSize: 50,fontFamily: 'Pacifico')),
                alignment: Alignment(-1, 0),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 250),
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  Firestore.instance.collection("notifications").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return ListView(children: hoo(snapshot));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ],
    ));
  }
}
