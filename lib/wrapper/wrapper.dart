import 'package:flutter/material.dart';
import 'package:flutterLogin/models/userModel.dart';
import 'package:flutterLogin/screens/home.dart';

import 'package:flutterLogin/wrapper/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    if (user == null) {
      return Authenticate();
    } else {
      print(user);
      return HomePage();
    }
  }
}
