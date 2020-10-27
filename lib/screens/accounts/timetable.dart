import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Timetable extends StatefulWidget {
  Timetable({Key key}) : super(key: key);

  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.blueGrey[900],
      body:  Column(
        
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
             height: 200,
          width: 500,
          padding: EdgeInsets.only(top: 70, left: 70),
          decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage('images/timetable.jpg',),fit:BoxFit.fitHeight),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
              color: Colors.amber[800]),
          child: Align(
                      child: Text('Time table',
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.blueAccent[600], fontSize: 50,fontFamily: 'Pacifico')),
                alignment: Alignment(-1, 0),
          ),
        ),
          SingleChildScrollView(
       scrollDirection: Axis.vertical,
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('time table').orderBy('Day').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: snapshot.data.documents
                        .map((doc) => buildItem(doc))
                        .toList());
              } else {
                return SizedBox();
              }
            },
          ),
      ),
     
        ],
      )
    );
  }
}


 Card buildItem(DocumentSnapshot doc) {
    return Card(
     // shape: BorderRadius.circular(3),
      margin: EdgeInsets.all(10),
      color: Colors.pink,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Day:-     '
              '${doc.data['Day']}',
              
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 5,),
             Text('Period 1:-'
              '${doc.data['p1']}',
              
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 5,),
             Text('period 2:-'
              '${doc.data['p2']}',
              
              style: TextStyle(fontSize: 24.0),
            ),
             SizedBox(height: 5,),
            Text('period 3:-'
              '${doc.data['p3']}',
              
              style: TextStyle(fontSize: 24.0),
            ),
             SizedBox(height: 5,),
            Text('period 4:-'
              '${doc.data['p4']}',
              
              style: TextStyle(fontSize: 24.0),
            ),
           
           
          ],
        ),
      ),
    );
  }
  
