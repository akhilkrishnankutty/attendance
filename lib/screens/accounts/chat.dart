import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreCRUDPage extends StatefulWidget {
  @override
  _FirestoreCRUDPageState createState() => _FirestoreCRUDPageState();
}

class _FirestoreCRUDPageState extends State<FirestoreCRUDPage> {
  String id;
  String re;
 
 //Timestamp _time=Timestamp.now();

  final _formKey = GlobalKey<FormState>();
  String chat;

  Card buildItem(DocumentSnapshot doc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '${doc.data['chat']}',
              style: TextStyle(fontSize: 24.0),
            ),
           
           
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHAT"),
        backgroundColor: Colors.amber[800],
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Form(
            key: _formKey,
            child: buildTextFormField(),
            
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
             
                onPressed: createData,
                child: Text(
                  'Sent',
                  style: TextStyle(color: Colors.black),
                ),
                color: Colors.amber[800],
              ),
             
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('chat').orderBy('time', descending: false).snapshots(),
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
        ],
      
      
      ),
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Enter the message',
        filled: true,
      ),
      
      validator: (value) => value.isEmpty ? 'Please Enter some Text' : null,
      onSaved: (value) => chat = value,
    );
  }


  void createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String _time= Timestamp.now().millisecondsSinceEpoch.toString();
      DocumentReference ref = await Firestore.instance
          .collection('chat')
          .add({'chat': '$chat ','time':_time});
          
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
  }


 

 
}