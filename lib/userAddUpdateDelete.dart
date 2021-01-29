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
//add user to db
  addUser() {
    db
        .collection("users")
        .add({
          "name": "Resad",
          "surname": "Allahverdiyev",
          "mail": "r.allahverdiyev@adycontainer.com",
        })
        .then((receipt) => print(receipt.documentID))
        .catchError((error) {
          print("user not added: $error");
        });
  }

//ad user to db with passport, id
  addUserWithPassport() {
    db
        .collection("users")
        .document("abc")
        .setData(({
          "name": "Resad",
          "surname": "Allahverdiyev",
          "mail": "r.allahverdiyev@adycontainer.com",
        }))
        .then((_) => print("document added"))
        .catchError((error) {
      print("user not added: $error");
    });
  }

//user update from db
  userUpdate() {
    db
        .collection("users")
        .document("abc")
        .updateData({
          "name": "Kisi",
          "surname": "Kisiyev",
          "mail": "k.kisiyev@gmail.com",
        })
        .then((_) => print("document added"))
        .catchError((error) {
          print("some errors : $error");
        });
  }

//delete user from db
  userDelete() {
    db
        .collection("users")
        .document("abc")
        .delete()
        .then((_) => print("document deleted"))
        .catchError((error) {
      print("some errors : $error");
    });
  }

  @override
  void initState() {
    super.initState();
    userDelete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: db.collection("users").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            List<Users> user = snapshot.data.documents
                .map((doc) => Users.madeFromDocument(doc))
                .toList();
            return ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, position) {
                return ListTile(
                  title: Text(user[position].name),
                  subtitle: Text(user[position].mail),
                );
              },
            );
          }),
    );
  }
}
