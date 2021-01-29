import 'package:fireworks/homePage.dart';
import 'package:fireworks/loginPage.dart';
import 'package:fireworks/models/user.dart';
import 'package:fireworks/services/myAuthServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForwardedPage extends StatefulWidget {
  @override
  _ForwardedPageState createState() => _ForwardedPageState();
}

class _ForwardedPageState extends State<ForwardedPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<MyAuthService>(context, listen: false).statusFollower,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          Users activeUser = snapshot.data;
          print(activeUser.id);
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
