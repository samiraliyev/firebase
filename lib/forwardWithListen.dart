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
  bool isAuth = false;
  anonymLogin() async {
    AuthResult authResult = await FirebaseAuth.instance.signInAnonymously();
    print(authResult.user.uid);
    print(authResult.user.email);
    print(authResult.user.displayName);
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
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      if (user != null) {
        print("user login now");
        setState(() {
          isAuth = true;
        });
      } else {
        print("user not login");
        setState(() {
          isAuth = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? homePage() : loginPage();
  }
}
