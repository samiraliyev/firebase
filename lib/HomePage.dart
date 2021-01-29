import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireworks/services/myAuthServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  goOut(BuildContext context) {
    var _myAuthService = Provider.of<MyAuthService>(context, listen: false);
    _myAuthService.logOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 80.0,
          width: 120.0,
          color: Colors.grey,
          child: InkWell(
            onTap: () => goOut(context),
            child: Center(
              child: Text("go out"),
            ),
          ),
        ),
      ),
    );
  }
}
