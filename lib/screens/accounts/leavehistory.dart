import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class History extends StatefulWidget {
  History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title:Text('Manage Leave'),
        backgroundColor: Colors.blueAccent,
      ),
      body:  SingleChildScrollView(
       scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(left:4),
                  child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('Leave').snapshots(),
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
        ),
      ),
     
    );
  }
}


 Card buildItem(DocumentSnapshot doc) {
    return Card(
      //margin: EdgeInsets.only(left: 3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text('Date:- '
              '${doc.data['date']}',
              
              style: TextStyle(fontSize: 24.0),
            ),
             Text('Name:- '
              '${doc.data['name']}',
              
              style: TextStyle(fontSize: 24.0),
            ),
           
             Text('Reason:- '
              '${doc.data['reason']}',
              
              style: TextStyle(fontSize: 24.0),
            ),
           
           
          ],
        ),
      ),
    );
  }