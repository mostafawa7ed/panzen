import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/controller/providerLogin.dart';
import 'package:untitled4/data/langaue.dart';
import 'package:untitled4/data/staticdata.dart';
import 'package:untitled4/functions/mediaquery.dart';
import 'package:untitled4/model/user_model.dart';
import 'package:untitled4/page/home.dart';
import 'package:untitled4/main.dart' as mainApp;

class LoginPage extends StatefulWidget {
  @override
  const LoginPage({super.key, required this.Language});
  final String Language;
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showChangePassword = false;
  bool _showPassword = true;
  final _formKey = GlobalKey<FormState>();
  final PageController controller = PageController();
  late String _email;
  late String _password;
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController rewriteNewPassword = TextEditingController();
  // Initial time in seconds

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              if (widget.Language == 'ar') {
                prefs.setString('language', 'en');
              } else {
                prefs.setString('language', 'ar');
              }
              mainApp.main();
            },
            child: widget.Language == 'ar'
                ? Text("Change To English")
                : Text("تغير إلي العربي"),
          ),
        ],
        title: Text(getLanguage(context, 'pageLogin')),
        centerTitle: true,
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
                padding: const EdgeInsets.all(16.0),
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
                            labelText: getLanguage(context, 'userName'),
                            border: const OutlineInputBorder(),
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
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: _togglePasswordVisibility,
                              child: Icon(
                                !_showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            fillColor: Colors.white38,
                            filled: true,
                            labelText: getLanguage(context, 'password'),
                            border: const OutlineInputBorder(),
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
                        const SizedBox(height: 20),
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                            user: loginUser,
                                            controller: controller,
                                            language: widget.Language,
                                          )),
                                );
                              } else {
                                print('Faild login');
                              }
                            }
                          },
                          child: Text(getLanguage(context, 'login')),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showChangePassword = true;
                                    });
                                  },
                                  child: Text(
                                      getLanguage(context, 'changePassword')),
                                ),
                                const SizedBox(height: 20),
                                if (_showChangePassword) ...[
                                  TextFormField(
                                    controller: newPassword,
                                    decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: _togglePasswordVisibility,
                                        child: Icon(
                                          !_showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                      labelText:
                                          getLanguage(context, 'newPassword'),
                                      border: const OutlineInputBorder(),
                                    ),
                                    obscureText: _showPassword,
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: rewriteNewPassword,
                                    decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: _togglePasswordVisibility,
                                        child: Icon(
                                          !_showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                      labelText:
                                          getLanguage(context, 'renewPassword'),
                                      border: const OutlineInputBorder(),
                                    ),
                                    obscureText: _showPassword,
                                  ),
                                  const SizedBox(height: 20),
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
                                        setState(() {
                                          _showChangePassword = false;
                                        });
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
                                    child: Text(
                                        getLanguage(context, 'savepassword')),
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
