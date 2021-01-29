import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireworks/models/user.dart';
import 'package:fireworks/services/myAuthServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  anonymLogin(BuildContext context) async {
    var _myAuthService = Provider.of<MyAuthService>(context, listen: false);
    Users users = await _myAuthService.anonymLogin();
    // return users.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 80.0,
          width: 120.0,
          color: Colors.grey,
          child: Center(
            child: InkWell(
              onTap: () => anonymLogin(context),
              child: Text("login"),
            ),
          ),
        ),
      ),
    );
  }
}
