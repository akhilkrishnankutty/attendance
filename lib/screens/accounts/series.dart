import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giiiii/screens/accounts/leavehistory.dart';

class Series extends StatefulWidget {
  Series({Key key}) : super(key: key);

  @override
  _SeriesState createState() => _SeriesState();
}

class _SeriesState extends State<Series> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SimpleDialog(
      //backgroundColor: Colors.blueGrey[900],
        title: const Text('Select the class'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => csea())); },
            child: const Text('cse-A-s8'),
          ),
          SimpleDialogOption(
            onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context) => cseb())); },
            child: const Text('cse-b-s8'),
          ),
        ],
      ),
    );
  }

}

class csea extends StatefulWidget {
  csea({Key key}) : super(key: key);

  @override
  _cseaState createState() => _cseaState();
}

class _cseaState extends State<csea> {
   String _email,_mark1,_mark2,_mark3,_mark4;
  final formkey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title:Text('Series Mark'),
        backgroundColor:Colors.amber[800],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history),
            onPressed:(){ Navigator.push(context,MaterialPageRoute(builder: (context) => History()));},
          )
        ],
      ),
       body:ListView(
         children: <Widget>[
             
       
         Card(child: Form(key: formkey,
         child:
         Column(children: <Widget>[
           TextFormField(
            onSaved: (input)=> _email = input,
              decoration: InputDecoration(
                              labelText: 'Email',)
           ),
           TextFormField(
            onSaved: (input)=> _mark1 = input,
              decoration: InputDecoration(
                              labelText: 'Mark1',)
           ),
            TextFormField(
            onSaved: (input)=> _mark2 = input,
              decoration: InputDecoration(
                              labelText: 'Mark2',)
           ),
           TextFormField(
            onSaved: (input)=> _mark3 = input,
              decoration: InputDecoration(
                              labelText: 'Mark3',)
           ),


            Container(
           child: TextFormField(
             onSaved:(input)=> _mark4 = input,
               decoration: InputDecoration(
                              labelText: 'Mark4'),
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
          .collection('Seriescse-a')
          .document(_email)
          .collection(_email)
          .add({'email':_email,'mark1': _mark1 ,'mark2':_mark2,'mark3':_mark3,'mark4':_mark4});

          formkey.currentState.save();
        
}





}




class cseb extends StatefulWidget {
  cseb({Key key}) : super(key: key);

  @override
  _csebState createState() => _csebState();
}

class _csebState extends State<cseb> {
  String _email,_mark1,_mark2,_mark3,_mark4;
    final formkey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title:Text('Series Mark'),
        backgroundColor:Colors.amber[800],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history),
            onPressed:(){ Navigator.push(context,MaterialPageRoute(builder: (context) => History()));},
          )
        ],
      ),
       body:ListView(
         children: <Widget>[
             
       
         Card(child: Form(key: formkey,
         child:
         Column(children: <Widget>[
           TextFormField(
            onSaved: (input)=> _email = input,
              decoration: InputDecoration(
                              labelText: 'Email',)
           ),
           TextFormField(
            onSaved: (input)=> _mark1 = input,
              decoration: InputDecoration(
                              labelText: 'Mark1',)
           ),
            TextFormField(
            onSaved: (input)=> _mark2 = input,
              decoration: InputDecoration(
                              labelText: 'Mark2',)
           ),
           TextFormField(
            onSaved: (input)=> _mark3 = input,
              decoration: InputDecoration(
                              labelText: 'Mark3',)
           ),


            Container(
           child: TextFormField(
             onSaved:(input)=> _mark4 = input,
               decoration: InputDecoration(
                              labelText: 'Mark4'),
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
          .collection('Seriescse-b')
          .document(_email)
          .collection(_email)
          .add({'email':_email,'mark1': _mark1 ,'mark2':_mark2,'mark3':_mark3,'mark4':_mark4});

          formkey.currentState.save();
        
}

}



