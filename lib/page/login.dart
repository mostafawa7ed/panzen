import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/controller/providerLogin.dart';
import 'package:untitled4/data/staticdata.dart';
import 'package:untitled4/functions/mediaquery.dart';
import 'package:untitled4/model/user_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showChangePassword = false;
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController rewriteNewPassword = TextEditingController();
  late Timer _timer;
  int _seconds = 60; // Initial time in seconds
  bool _showPassword = false;
  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_seconds == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _seconds--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    Timer.periodic(Duration(hours: 2), (timer) {
      print(DateTime.now());
    });
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Time Left: $_seconds seconds',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              padding: const EdgeInsets.only(bottom: 450),
              color: Colors.blue.withOpacity(.8),
              height: 220,
              alignment: Alignment.center,
            ),
          ),
          ClipPath(
            clipper: WaveClipper(waveDeep: 0, waveDeep2: 100),
            child: Container(
              padding: const EdgeInsets.only(bottom: 50),
              color: Colors.blue.withOpacity(.3),
              height: 180,
              alignment: Alignment.center,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  width: getSizePage(context, 1, 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          controller: userName,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            fillColor: Colors.white38,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value!;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: _togglePasswordVisibility,
                              child: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            fillColor: Colors.white38,
                            filled: true,
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: _showPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              final ProviderLogin providerLogin =
                                  Provider.of<ProviderLogin>(context,
                                      listen: false);
                              User user = User();
                              user.userName = _email;
                              user.password = _password;
                              User? loginUser = await providerLogin.login(
                                  StaticData.urlLogin, user);
                              if (loginUser != null) {
                                print('Email: $_email');
                                print('Password: $_password');
                              } else {
                                print('Faild login');
                              }
                            }
                          },
                          child: Text('Login'),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showChangePassword = true;
                                    });
                                  },
                                  child: Text('Change Password'),
                                ),
                                SizedBox(height: 20),
                                if (_showChangePassword) ...[
                                  TextFormField(
                                    controller: newPassword,
                                    decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: _togglePasswordVisibility,
                                        child: Icon(
                                          _showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                      labelText: 'New Password',
                                      border: OutlineInputBorder(),
                                    ),
                                    obscureText: _showPassword,
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: rewriteNewPassword,
                                    decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: _togglePasswordVisibility,
                                        child: Icon(
                                          _showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                      labelText: 'Re-enter New Password',
                                      border: OutlineInputBorder(),
                                    ),
                                    obscureText: _showPassword,
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () async {
                                      User user = User();
                                      User currentUser = User();
                                      currentUser.userName = userName.text;
                                      currentUser.password = password.text;
                                      final ProviderLogin providerLogin =
                                          Provider.of<ProviderLogin>(context,
                                              listen: false);
                                      User? loginUser = User();
                                      loginUser = await providerLogin.login(
                                          StaticData.urlLogin, currentUser);
                                      if (loginUser != null &&
                                          newPassword.text ==
                                              rewriteNewPassword.text) {
                                        user.userName = userName.text;
                                        user.id = loginUser.id;
                                        user.password = rewriteNewPassword.text;
                                        String? responseUpdate =
                                            await providerLogin
                                                .changeUserPassword(
                                                    StaticData
                                                        .urlChangeUserPassword,
                                                    user);
                                        SnackBar snackBar = SnackBar(
                                          content: Center(
                                              child: Text(
                                                  responseUpdate ?? "error")),
                                        );
                                        if (responseUpdate ==
                                            "User updated successfully") {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }
                                    },
                                    child: Text('Save'),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double waveDeep;
  final double waveDeep2;

  WaveClipper({this.waveDeep = 100, this.waveDeep2 = 0});
  @override
  Path getClip(Size size) {
    final double sw = size.width;
    final double sh = size.height;

    final Offset controlPoint1 = Offset(sw * .25, sh - waveDeep2 * 2);
    final Offset destinationPoint1 = Offset(sw * .5, sh - waveDeep - waveDeep2);

    final Offset controlPoint2 = Offset(sw * .75, sh - waveDeep * 2);
    final Offset destinationPoint2 = Offset(sw, sh - waveDeep);

    final Path path = Path()
      ..lineTo(0, size.height - waveDeep2)
      ..quadraticBezierTo(controlPoint1.dx, controlPoint1.dy,
          destinationPoint1.dx, destinationPoint1.dy)
      ..quadraticBezierTo(controlPoint2.dx, controlPoint2.dy,
          destinationPoint2.dx, destinationPoint2.dy)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
