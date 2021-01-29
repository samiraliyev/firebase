import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireworks/services/myAuthServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forwardingPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<MyAuthService>(
      create: (_) => MyAuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Projem',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: ForwardedPage(),
      ),
    );
  }
}
