import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/controller/providerLogin.dart';

import 'package:untitled4/cutomwidget/customTextFaild.dart';
import 'package:untitled4/data/staticdata.dart';

import 'package:untitled4/functions/mediaquery.dart';
import 'package:untitled4/model/user_model.dart';
import 'package:untitled4/page/home.dart';

import '../data/langaue.dart';

class SignUp extends StatefulWidget {
  const SignUp(
      {super.key,
      required this.user,
      required this.pageController,
      required this.language});
  final User user;
  final PageController pageController;
  final String language;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String userNameLabel = 'UserName';
  String firstNameLabel = 'firstName';
  String secondNameLabel = 'secondName';
  String addressLabel = 'address';
  String passwordLabel = 'password';
  bool _showPassword = false;
  void Function(String?)? onSaved;
  String? Function(String?)? validator;
  // (value) {
  //                           if (value == null || value.isEmpty) {
  //                             return 'Please enter your email';
  //                           }
  //                           return null;
  //                         }

  // (value) {
  //   _password = value!;
  // },
  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getLanguage(context, 'pageSignUp')),
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            user: widget.user,
                            controller: widget.pageController,
                            language: widget.language,
                          )),
                );
              },
              child: Text(getLanguage(context, 'backToHome')))
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
                        CustomSignUpTextFaild(
                            controller: userNameController,
                            nameLabel: getLanguage(context, 'userName'),
                            validator: validator,
                            onSaved: onSaved),
                        SizedBox(height: 20),
                        CustomSignUpTextFaild(
                            controller: firstNameController,
                            nameLabel: getLanguage(context, 'firstName'),
                            validator: validator,
                            onSaved: onSaved),
                        SizedBox(height: 20),
                        CustomSignUpTextFaild(
                            controller: secondNameController,
                            nameLabel: getLanguage(context, 'secondName'),
                            validator: validator,
                            onSaved: onSaved),
                        SizedBox(height: 20),
                        CustomSignUpTextFaild(
                            controller: addressController,
                            nameLabel: getLanguage(context, 'address'),
                            validator: validator,
                            onSaved: onSaved),
                        SizedBox(height: 20),
                        SizedBox(height: 20),
                        TextFormField(
                            controller: passwordController,
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
                              border: OutlineInputBorder(),
                            ),
                            obscureText: _showPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return getLanguage(context, 'password');
                              }
                              return null;
                            },
                            onSaved: onSaved),
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    final ProviderLogin providerLogin =
                                        Provider.of<ProviderLogin>(context,
                                            listen: false);
                                    if (firstNameController.text.toString() !=
                                            "" &&
                                        secondNameController.text.toString() !=
                                            "" &&
                                        userNameController.text.toString() !=
                                            "" &&
                                        addressController.text.toString() !=
                                            "" &&
                                        passwordController.text.toString() !=
                                            "") {
                                      User user = User();
                                      user.firstName =
                                          firstNameController.text.toString();
                                      user.secondName =
                                          secondNameController.text.toString();
                                      user.userName =
                                          userNameController.text.toString();
                                      user.name = user.firstName! +
                                          " " +
                                          user.secondName!;
                                      user.address =
                                          addressController.text.toString();
                                      user.password =
                                          passwordController.text.toString();

                                      var resulte =
                                          await providerLogin.createUser(
                                              StaticData.urlAddUser, user);
                                      user.id = "${resulte!["userId"]}";
                                      if (user.id != null) {
                                        firstNameController.clear();
                                        secondNameController.clear();
                                        userNameController.clear();
                                        addressController.clear();
                                        passwordController.clear();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage(
                                                    user: user,
                                                    controller:
                                                        widget.pageController,
                                                    language: widget.language,
                                                  )),
                                        );
                                      }
                                    } else {
                                      SnackBar snackBar = SnackBar(
                                        content: Center(
                                            child: Text(//messageFaildsEmpty
                                                getLanguage(
                                                    context, 'password'))),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      //print("asdas");
                                    }
                                  } else {
                                    SnackBar snackBar = SnackBar(
                                      content: Center(
                                          child: Text(getLanguage(
                                              context, 'password'))),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                child: Text(
                                    getLanguage(context, 'saveAndLoginByUser')),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    final ProviderLogin providerLogin =
                                        Provider.of<ProviderLogin>(context,
                                            listen: false);
                                    if (firstNameController.text.toString() !=
                                            "" &&
                                        secondNameController.text.toString() !=
                                            "" &&
                                        userNameController.text.toString() !=
                                            "" &&
                                        addressController.text.toString() !=
                                            "" &&
                                        passwordController.text.toString() !=
                                            "") {
                                      User user = User();
                                      user.firstName =
                                          firstNameController.text.toString();
                                      user.secondName =
                                          secondNameController.text.toString();
                                      user.userName =
                                          userNameController.text.toString();
                                      user.name = user.firstName! +
                                          " " +
                                          user.secondName!;
                                      user.address =
                                          addressController.text.toString();
                                      user.password =
                                          passwordController.text.toString();

                                      var resulte =
                                          await providerLogin.createUser(
                                              StaticData.urlAddUser, user);
                                      user.id = "${resulte!["userId"]}";
                                      if (user.id != null) {
                                        firstNameController.clear();
                                        secondNameController.clear();
                                        userNameController.clear();
                                        addressController.clear();
                                        passwordController.clear();

                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage(
                                                    user: widget.user,
                                                    controller:
                                                        widget.pageController,
                                                    language: widget.language,
                                                  )),
                                        );
                                      }
                                    } else {
                                      SnackBar snackBar = SnackBar(
                                        content: Center(
                                            child: Text(getLanguage(context,
                                                'messageFaildsEmpty'))),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      //print("asdas");
                                    }
                                  } else {
                                    SnackBar snackBar = SnackBar(
                                      content: Center(
                                          child: Text(getLanguage(
                                              context, 'messageFaildsEmpty'))),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                child: Text(getLanguage(
                                    context, 'saveAndLoginByAdmin')),
                              ),
                            ),
                          ],
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
