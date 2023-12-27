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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Container(
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
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
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
                                  labelText: 'New Password',
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: rewriteNewPassword,
                                decoration: InputDecoration(
                                  labelText: 'Re-enter New Password',
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
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
                                    User? userAfterChange =
                                        await providerLogin.changeUserPassword(
                                            StaticData.urlChangeUserPassword,
                                            user);
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
    );
  }
}
