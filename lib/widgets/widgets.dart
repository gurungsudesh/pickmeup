import 'package:flutter/material.dart';
import 'package:flutterLogin/screens/register.dart';

Widget verticalText() {
  return Padding(
    padding: const EdgeInsets.only(top: 60, left: 10),
    child: RotatedBox(
      quarterTurns: -1,
      child: Text(
        'Sign In',
        style: TextStyle(
            color: Color(0xFF809fff),
            fontSize: 38,
            fontWeight: FontWeight.w800),
      ),
    ),
  );
}

Widget textLogin() {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0, left: 10.0),
    child: Container(
      //color: Colors.green,
      height: 200,
      width: 200,
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
          ),
          Center(
            child: Text(
              "Let's get started with pick me up. ",
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF809fff),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget inputEmail(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
    child: Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            fillColor: Color(0xFF0b665a),
            labelText: 'Name',
            labelStyle: TextStyle(color: Colors.white70),
            focusColor: Colors.white),
      ),
    ),
  );
}

Widget passwordInput(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
    child: Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        obscureText: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Password',
          labelStyle: TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    ),
  );
}

Widget forgotPassword(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 30, left: 50, right: 30),
    child: Container(
      alignment: Alignment.topRight,
      height: 20,
      child: FlatButton(
        onPressed: () {},
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    ),
  );
}

Widget buttonLogin(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 40, right: 30, left: 200),
    child: Container(
      alignment: Alignment.bottomRight,
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFF0b665a),
            blurRadius: 10.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              5.0, // horizontal, move right 10
              5.0, // vertical, move down 10
            ),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: FlatButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'OK',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget firstTime(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 30, left: 30),
    child: Container(
      //alignment: Alignment.topRight,
      //color: Colors.red,
      height: 20,
      child: Row(
        children: <Widget>[
          Text(
            'Your first time?',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          GestureDetector(
            child: Text(
              'Sign up',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              //textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },
          ),
        ],
      ),
    ),
  );
}
