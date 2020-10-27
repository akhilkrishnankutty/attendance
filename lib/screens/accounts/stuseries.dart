import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

class stuseries extends StatefulWidget {
 
   final String userEmail;
  stuseries({this.userEmail});

  @override
  _stuseriesState createState() => _stuseriesState();
}

class _stuseriesState extends State<stuseries> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:Text('Series Marks'),
        backgroundColor: Colors.blueAccent,
      ),
      body:  SingleChildScrollView(
       scrollDirection: Axis.vertical,
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('Seriescse-a').document(widget.userEmail).collection(widget.userEmail).snapshots(),
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
     
    );
  }
}





 Card buildItem(DocumentSnapshot doc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text('subject1:-'
              '${doc.data['mark1']}',
              
              style: TextStyle(fontSize: 24.0),
            ),
             Text('subject2:-'
              '${doc.data['mark2']}',
              
              style: TextStyle(fontSize: 24.0),
            ),
           
             Text('subject3:-'
              '${doc.data['mark3']}',
              
              style: TextStyle(fontSize: 24.0),
            ),
             Text('subject4:-'
              '${doc.data['mark4']}',
              
              style: TextStyle(fontSize: 24.0),
            ),
           
           
          ],
        ),
      ),
    );
  }