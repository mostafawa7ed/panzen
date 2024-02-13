import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:untitled4/controller/providerLogin.dart';
import 'package:untitled4/data/langaue.dart';
import 'package:untitled4/data/staticdata.dart';
import 'package:untitled4/functions/mediaquery.dart';
import 'package:untitled4/model/user_model.dart';

class ChangePassword extends StatefulWidget {
  @override
  const ChangePassword({super.key, required this.Language, required this.user});
  final String Language;
  final User user;
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _showChangePassword = false;
  bool _showPassword = true;
  final _formKey = GlobalKey<FormState>();
  final PageController controller = PageController();
  late String _password;
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
    return Stack(
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
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              // ElevatedButton(
                              //   onPressed: () {
                              //     setState(() {
                              //       _showChangePassword = true;
                              //     });
                              //   },
                              //   child: Text(
                              //       getLanguage(context, 'changePassword')),
                              // ),
                              // const SizedBox(height: 20),
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
                                  User currentUser = widget.user;

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
                                    user.id = loginUser.id;
                                    user.password = rewriteNewPassword.text;
                                    String? responseUpdate =
                                        await providerLogin.changeUserPassword(
                                            StaticData.urlChangeUserPassword,
                                            user);
                                    setState(() {
                                      _showChangePassword = false;
                                    });
                                    SnackBar snackBar = SnackBar(
                                      content: Center(
                                          child:
                                              Text(responseUpdate ?? "error")),
                                    );
                                    if (responseUpdate ==
                                        "User updated successfully") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  } else {
                                    SnackBar snackBar = SnackBar(
                                      content: Center(child: Text("error")),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                child:
                                    Text(getLanguage(context, 'savepassword')),
                              ),
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
