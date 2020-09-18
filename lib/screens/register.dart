import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutterLogin/enums/auth_result_status.dart';
import 'package:flutterLogin/error/error_handling.dart';
import 'package:flutterLogin/models/userModel.dart';
import 'package:flutterLogin/services/auth.dart';
import 'package:flutterLogin/widgets/loading.dart';
import 'package:intl/intl.dart';

import 'package:date_format/date_format.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;

  RegisterPage({this.toggleView});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthServices _auth = AuthServices();
  final userModel = UserModel();

  final _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _password;
  String _corrPassword;
  String _dob;
  String _address;
  bool _autovalidate = false;
  bool _errorShow = false;
  bool _isLoading = false;
  String _error = '';

  final format = DateFormat("yyyy-MM-dd");

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _corrPassController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            //backgroundColor: Color(0xFF99ffe4),
            body: ColorfulSafeArea(
                child: Container(
              // decoration: BoxDecoration(
              //     // gradient: LinearGradient(
              //     //     begin: Alignment.topRight,
              //     //     end: Alignment.bottomLeft,
              //     //     colors: [Color(0xFF99ffe4), Color(0xFF4dffcf)])
              //         ),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Text('Sign In hurry',
                            style: TextStyle(
                                fontSize: 24.0, fontStyle: FontStyle.italic)),
                        SizedBox(
                          height: 10.0,
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
                                  maxLength: 25,
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Full Name',
                                    icon: Icon(Icons.person),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*Please enter the full name";
                                    } else
                                      return null;
                                  },
                                  onSaved: (value) {
                                    _name = value;
                                  },
                                ),
                                TextFormField(
                                  //obscureText: true,
                                  controller: _passwordController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    icon: Icon(Icons.lock),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*Password field is empty";
                                    } else if (value.length < 6) {
                                      return "*password must be longer than six letters";
                                    } else
                                      return null;
                                  },

                                  onSaved: (value) {
                                    _password = value;
                                  },
                                ),
                                TextFormField(
                                  obscureText: true,
                                  controller: _corrPassController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Correct Password',
                                    icon: Icon(Icons.lock_outline),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*Password field is empty";
                                    } else if (value.length < 6) {
                                      return "*password must be longer than six letters";
                                    } else if (_passwordController.text !=
                                        value) {
                                      return "*passwords donot match";
                                    } else
                                      return null;
                                  },
                                  onSaved: (value) {
                                    _corrPassword = value;
                                  },
                                ),
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    icon: Icon(Icons.mail_outline),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
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
                                DateTimeField(
                                  format: format,
                                  controller: _dobController,
                                  decoration: InputDecoration(
                                    labelText: 'Birth date',
                                    icon: Icon(Icons.calendar_today),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                  },
                                  validator: (currentValue) {
                                    if (currentValue == null) {
                                      return "*choose the date of birth";
                                    } else
                                      return null;
                                  },
                                  onSaved: (currentValue) {
                                    //formatDate(DateTime(1989, 02, 21), [yyyy, '-', mm, '-', dd])
                                    _dob = formatDate(
                                        currentValue, [yyyy, '-', mm, '-', dd]);
                                  },
                                ),
                                // TextFormField(
                                //   controller: _dobController,
                                //   keyboardType: TextInputType.datetime,
                                //   decoration: InputDecoration(
                                //     labelText: 'Birth date',
                                //     icon: Icon(Icons.calendar_today),
                                //     labelStyle: TextStyle(
                                //       color: Color(0xFF809fff),
                                //     ),
                                //   ),
                                //   validator: (value) {
                                //     if (value.isEmpty) {
                                //       return "*Date of birth is empty";
                                //     } else
                                //       return null;
                                //   },
                                //   onSaved: (value) {
                                //     _dob = value;
                                //   },
                                // ),
                                TextFormField(
                                  controller: _addressController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    icon: Icon(Icons.home),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*address is empty";
                                    } else
                                      return null;
                                  },
                                  onSaved: (value) {
                                    _address = value;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                    //padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: RaisedButton(
                                        // padding: EdgeInsets.all(8.0),
                                        color: Color(0xFF809fff),
                                        child: Text(
                                          'Sign Up',
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
                                            print(_passwordController.text);

                                            final result =
                                                await _auth.registerData(
                                                    _email,
                                                    _password,
                                                    _name,
                                                    _address,
                                                    _dob);
                                            //print(result);

                                            if (result ==
                                                AuthResultStatus.successful) {
                                              _nameController.text = "";
                                              _passwordController.text = "";
                                              _corrPassController.text = "";
                                              _emailController.text = "";
                                              _dobController.text = "";
                                              _addressController.text = "";
                                              // Navigate to success page
                                            } else {
                                              setState(() {
                                                _isLoading = false;
                                                _errorShow = true;
                                                _error = AuthExceptionHandler
                                                    .generateExceptionMessage(
                                                        result);
                                              });
                                              _nameController.text = "";
                                              _passwordController.text = "";
                                              _corrPassController.text = "";
                                              _emailController.text = "";
                                              _dobController.text = "";
                                              _addressController.text = "";
                                            }

                                            // if (result == null) {
                                            //   setState(() {
                                            //     _error =
                                            //         "The email has already been used.";
                                            //     _autovalidate = false;
                                            //   });
                                          } else {
                                            setState(() {
                                              _autovalidate = true;
                                            });
                                          }
                                        })),
                                SizedBox(height: 5.0),
                                Container(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      color: Color(0xFF809fff),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Container(
                                  //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: RaisedButton(
                                      // padding: EdgeInsets.all(8.0),
                                      color: Color(0xFF809fff),
                                      child: Text(
                                        'Go to Sign In',
                                        style: TextStyle(
                                            //color: Color(0xFF99ffe4),
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                      onPressed: () {
                                        widget.toggleView();
                                        // Navigator.of(context).pushReplacement(
                                        //     MaterialPageRoute(
                                        //         builder: (context) => LoginPage()));
                                      }),
                                ),
                                SizedBox(height: 5.0),
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
                                              _error,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFFdf9f9f),
                                                  fontSize: 12.0),
                                            )
                                          ],
                                        ),
                                        //IconButton(icon: Icon(Icons.close), onPressed: null)
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          );
  }
}
