import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutterLogin/enums/auth_result_status.dart';
import 'package:flutterLogin/error/error_handling.dart';
import 'package:flutterLogin/services/auth.dart';
import 'package:flutterLogin/widgets/loading.dart';

import '../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;

  LoginPage({this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final AuthServices _auth = AuthServices();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;
  bool _autovalidate = false;
  bool _errorShow = false;
  bool _isLoading = false;

  String error = "";

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
            //key: _scaffoldKey,
            resizeToAvoidBottomInset: true,
            //backgroundColor: Color(0xFF99ffe4),
            body: ColorfulSafeArea(
              child: Container(
                // decoration: BoxDecoration(
                //     // gradient: LinearGradient(
                //     //     begin: Alignment.topRight,
                //     //     end: Alignment.bottomLeft,
                //     //     colors: [Color(0xFF99ffe4), Color(0xFF4dffcf)])
                //     ),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [verticalText(), textLogin()],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Form(
                            key: _formKey,
                            autovalidate: _autovalidate,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(color: Color(0xFF809fff)),
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                        color: Color(0xFF809fff),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF809fff))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF809fff))),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10.0, 0, 0, 0)),
                                  validator: (value) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);

                                    if (value.isEmpty) {
                                      return 'Please enter the email';
                                    } else if (!regex.hasMatch(value))
                                      return '*Enter a valid email';
                                    else
                                      return null;
                                  },
                                  onSaved: (value) {
                                    _email = value; // or value
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  style: TextStyle(color: Color(0xFF809fff)),
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        color: Color(0xFF809fff),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF809fff))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF809fff))),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10.0, 0, 0, 0)),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return '*Please enter the password';
                                    } else
                                      return null;
                                  },
                                  onSaved: (value) {
                                    _password = value; // or value
                                  },
                                ),
                                SizedBox(height: 20.0),
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Forgot Password?',
                                      style:
                                          TextStyle(color: Color(0xFF809fff)),
                                    ),
                                  ),
                                  onTap: () {
                                    print("forgot password");
                                  },
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                    child: RaisedButton(
                                        padding: EdgeInsets.all(8.0),
                                        color: Color(0xFF809fff),
                                        child: Text(
                                          'Sign In',
                                          style: TextStyle(
                                              //color: Color(0xFF99ffe4),
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            setState(() {
                                              _isLoading = true;
                                            });

                                            final result = await _auth
                                                .signInUser(_email, _password);
                                            //print('The error: $result');

                                            if (result ==
                                                AuthResultStatus.successful) {
                                              // Navigate to success page
                                            } else {
                                              setState(() {
                                                _isLoading = false;
                                                _errorShow = true;
                                                error = AuthExceptionHandler
                                                    .generateExceptionMessage(
                                                        result);
                                              });
                                              //_showAlertDialog(errorMsg);

                                            }
                                            // if (result == null) {
                                            //   setState(() {
                                            //     error =
                                            //         "Cannot login with those credentials";
                                            //   });
                                            // } else {
                                            //   error = result;
                                            // }
                                            _emailController.text = "";
                                            _passwordController.text = "";
                                            //print("Email: " + _email);
                                            //print("Password: " + _password);
                                          } else {
                                            setState(() {
                                              _autovalidate = true;
                                            });
                                          }
                                        })),
                                SizedBox(height: 20.0),
                                Container(
                                    child: Row(children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                        color: Color(0xFFdf9f9f),
                                        fontSize: 16.0),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      child: Text('Sign up',
                                          style: TextStyle(
                                              color: Color(0xFF809fff),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0)),
                                    ),
                                    onTap: () {
                                      widget.toggleView();
                                      // Navigator.of(context).pushReplacement(
                                      //     MaterialPageRoute(
                                      //         builder: (context) => RegisterPage()));
                                    },
                                  )
                                ])),
                                SizedBox(height: 20.0),
                                _errorShow
                                    ? Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.error,
                                              color: Color(0xFFdf9f9f),
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              error,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFFdf9f9f),
                                                  fontSize: 16.0),
                                            )
                                          ],
                                        ),
                                        //IconButton(icon: Icon(Icons.close), onPressed: null)
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
