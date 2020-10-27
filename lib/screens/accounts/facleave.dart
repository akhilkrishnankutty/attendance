import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Facleave extends StatefulWidget {
  Facleave({Key key}) : super(key: key);

  @override
  _FacleaveState createState() => _FacleaveState();
}

class _FacleaveState extends State<Facleave> {
  String _re,_da,_name;

  final formkey =GlobalKey<FormState>();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Leave'),
        backgroundColor:Colors.amber[800],
        actions: <Widget>[
         
        ],
      ),
       body:ListView(
         children: <Widget>[
              Container(
          height: 200,
          width: 500,
          padding: EdgeInsets.only(top: 70, left: 70),
          decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage('images/leave.png',),fit:BoxFit.fitWidth),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
              color: Colors.amber[800]),
         
        ),
       
         Card(child: Form(key: formkey,
         child:
         Column(children: <Widget>[
           TextFormField(
            onSaved: (input)=> _name = input,
              decoration: InputDecoration(
                              labelText: 'Name',)
           ),
           TextFormField(
            onSaved: (input)=> _re = input,
              decoration: InputDecoration(
                              labelText: 'Reason',)
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
          .collection('facleave')
          .add({'name':_name,'reason': _re ,'date':_da});
         
          print(_da); 
         
        
}
}





