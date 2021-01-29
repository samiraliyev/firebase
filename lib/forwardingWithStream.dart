import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      home: ForwardedPage(),
    );
  }
}

class ForwardedPage extends StatefulWidget {
  @override
  _ForwardedPageState createState() => _ForwardedPageState();
}

class _ForwardedPageState extends State<ForwardedPage> {
  anonymLogin() async {
    AuthResult authResult = await FirebaseAuth.instance.signInAnonymously();
    // print(authResult.user.uid);
    // print(authResult.user.email);
    // print(authResult.user.displayName);
  }

  Widget loginPage() {
    return Scaffold(
      body: Center(
        child: Container(
          height: 80.0,
          width: 120.0,
          color: Colors.grey,
          child: Center(
              child: InkWell(onTap: () => anonymLogin(), child: Text("login"))),
        ),
      ),
    );
  }

  goOut() {
    FirebaseAuth.instance.signOut();
  }

  Widget homePage() {
    return Scaffold(
      body: Center(child: InkWell(onTap: () => goOut(), child: Text("go out"))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          FirebaseUser activeUser = snapshot.data;
          print(activeUser.uid);
          return homePage();
        } else {
          return loginPage();
        }
      },
    );
  }
}
