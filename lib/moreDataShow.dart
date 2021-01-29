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

  Future<List<Users>> usersBring() async {
    QuerySnapshot snapshot = await db.collection("users").getDocuments();
    List<Users> user =
        snapshot.documents.map((doc) => Users.madeFromDocument(doc)).toList();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Users>>(
          future: usersBring(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, position) {
                return ListTile(
                  title: Text(snapshot.data[position].name),
                  subtitle: Text(snapshot.data[position].mail),
                );
              },
            );
          }),
    );
  }
}
