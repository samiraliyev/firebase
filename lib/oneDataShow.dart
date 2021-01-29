import 'package:fireworks/models/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projem',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = Firestore.instance;
  //for data call from databse

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream:
            db.collection("users").document("9ToW7FBCaqttXfSw6kvD").snapshots(),
        builder: (context, snapshot) {
          //data loading animaton
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          Users user = Users.madeFromDocument(snapshot.data);
          return ListTile(
            title: Text(user.name + " " + user.surname),
            subtitle: Text(user.mail),
            leading: Image.network(
              user.avatar,
              width: 50.0,
              height: 50.0,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
