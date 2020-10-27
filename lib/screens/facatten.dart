import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Facatten extends StatefulWidget {
  final String name;
  final String sub;
  Facatten({this.name,this.sub});
  
 
  String a;
 

  @override
  _FacattenState createState() => _FacattenState();
}

class _FacattenState extends State<Facatten> {

  
  @override
  



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage attendance'),
        
      ),
      body:  StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("users")
                  .document(widget.name)
                  .collection("attendance_data")
                  // .document(widget.sub)
                  // .collection("history")
                  
                  .snapshots(),
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
    );
  }

  Card buildItem(DocumentSnapshot doc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              '${doc.data['subjectName']}',
              style: TextStyle(fontSize: 24.0),
            ),
           
           
          ],
        ),
      ),
    );
  }
}