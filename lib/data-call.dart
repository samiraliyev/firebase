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
  void usersBring() async {
    var snapshot = await db.collection("users").getDocuments();
    snapshot.documents.forEach((doc) {
      print(doc.data["mail"]);
    });
  }

  void usersBringWithPassport() async {
    //document for only one docoument call
    var doc =
        await db.collection("users").document("l0UhfgnS2dLDft6r8yVF").get();

    if (doc.exists) {
      print(doc.data);
    } else {
      print("Document not found:");
    }
  }

  void userSort() async {
    //for sort by user age
    var snapshot = await db.collection("users").orderBy("age").getDocuments();
    snapshot.documents.forEach((doc) {
      print(doc.data);
    });
  }

  void userRequester() async {
    //for user call with request
    var snapshot = await db
        .collection("users")
        .where("age", isLessThan: 35)
        .getDocuments();
    snapshot.documents.forEach((doc) {
      print(doc.data);
    });
  }

  void userMoreRequester() async {
    //for user call with lot of request
    var snapshot = await db
        .collection("users")
        .where("surname", isEqualTo: "Aliyev")
        .where("age", isGreaterThan: 15)
        .limit(1)
        .getDocuments();
    snapshot.documents.forEach((DocumentSnapshot doc) {
      print(doc.data);
    });
  }

//for user create
  void userCreate() async {
    var doc =
        await db.collection("users").document("9ToW7FBCaqttXfSw6kvD").get();
    Users user1 = Users.madeFromDocument(doc);

    print(user1.id);
    print(user1.name);
    print(user1.surname);
    print(user1.mail);
    print(user1.avatar);
  }

  @override
  void initState() {
    super.initState();
    userCreate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}
