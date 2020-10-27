import 'package:flutter/material.dart';
import 'package:giiiii/screens/notification.dart';
import 'package:giiiii/screens/welcome2.dart';
import 'screens/welcome.dart';
import 'screens/account.dart';

class MyStatefulWidget extends StatefulWidget {
  final String userEmail;
  MyStatefulWidget({this.userEmail});

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.userEmail != null) {
      print(widget.userEmail);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: [
          welcome2(
            userEmail: widget.userEmail,
          ),
          notification(),
          Accounts( userEmail: widget.userEmail,)
        ].toList().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Acccount'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
