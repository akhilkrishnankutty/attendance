import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'leavehistory.dart';

class Complaints extends StatefulWidget {
  Complaints({Key key}) : super(key: key);

  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  String _issue,_da,_name;

  final formkey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      
       body:ListView(
         children: <Widget>[
             
            Container(
          height: 200,
          width: 500,
          padding: EdgeInsets.only(top: 70, left: 70),
          decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage('images/complaints.jpg',),fit:BoxFit.fitWidth),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
              color: Colors.amber[800]),
         child: Align(
                      child: Text('Complaints',
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.white, fontSize: 50,fontFamily: 'Pacifico')),
                alignment: Alignment(-1, 0),
          ),
        ),
         Card(
         
           child: Form(key: formkey,
         child:
         Column(children: <Widget>[
           TextFormField(
            onSaved: (input)=> _name = input,
              decoration: InputDecoration(
                              labelText: 'Name',)
           ),
           TextFormField(
            onSaved: (input)=> _issue = input,
              decoration: InputDecoration(
                              labelText: 'Issue',)
           ),

            Container(
           child: TextFormField(
             onSaved:(input)=> _da = input,
               decoration: InputDecoration(
                              labelText: 'Date'),
           ),
         ),
         RaisedButton(
                onPressed: createData,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.black),
                ),
                color: Colors.amber[800],
              ),
         ],) ,
         ),),
        
         ],
       )
    );
  }


void createData() async{
  formkey.currentState.save();
  await Firestore.instance
          .collection('Complaints')
          .add({'name':_name,'reason': _issue ,'date':_da});
         

          formkey.currentState.save();
        
}

}

