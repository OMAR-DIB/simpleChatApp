import 'dart:math';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var _isLogin = true;

  var _enteredEmail = '';
  var _enteredPass = '';

  void submit() async {
    final valid = _formkey.currentState!.validate();

    if (!valid) {
      return;
      // _formkey.currentState!.save();
      // print('hi $_enteredEmail');
      // print('hi $_enteredPass');
    }
    if (_isLogin) {
    } else {
      try {
        final UserCredential userCredential =
            await _firebase.createUserWithEmailAndPassword(
                email: _enteredEmail, password: _enteredPass);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Authentication Faild!'))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
              width: 200,
              child: Image.asset('images/profile.png'),
            ),
            Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                        ),
                        onSaved: (newValue) => _enteredEmail = newValue!,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return 'enter an email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        onSaved: (value) => _enteredPass = value!,
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return 'enter a strong pass';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: submit,
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: Text(_isLogin ? 'login' : 'sign in'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child:
                            Text(_isLogin ? 'create acc' : 'already have an acc'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
