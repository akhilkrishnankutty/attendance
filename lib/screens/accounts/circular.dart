import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Circular extends StatefulWidget {
  Circular({Key key}) : super(key: key);

  @override
  _CircularState createState() => _CircularState();
}

class _CircularState extends State<Circular> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.yellow,
       appBar: AppBar(
        title:Text('E-Circular'),
        backgroundColor: Colors.amber[800],
      ),
      body:   StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('circular').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    children: snapshot.data.documents
                        .map((doc) => buildItem(doc))
                        .toList());
              } else {
                return SizedBox();
              }
            },
          ),
     
    );
  }
}



 Card buildItem(DocumentSnapshot doc) {
    return Card(
     
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text('date:-'
              '${doc.data['date']}',
              
              style: TextStyle(fontSize: 24.0),
            ),
            Text("cicular:-"
              '${doc.data['circular']}',
              
              style: TextStyle(fontSize: 24.0),
            ),
            
           
           
          ],
        ),
      ),
    );
  }