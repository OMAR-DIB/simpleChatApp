import 'dart:io';

import 'package:chat_new/widgets/user_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  var _enteredEmail = '';
  var _enteredPass = '';
  File? _selectedImage;

  void submit() async {
    final valid = _formKey.currentState!.validate();
    if (!valid) return;
    if (!_isLogin) return;

    _formKey.currentState!.save(); // Save the form before using the values

    try {
      if (_isLogin) {
        final UserCredential userCredential =
            await _firebase.signInWithEmailAndPassword(
                email: _enteredEmail.trim(), password: _enteredPass.trim());
      } else {
        final UserCredential userCredential =
            await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail.trim(),
          password: _enteredPass.trim(),
        );
        // final Reference storageRef = FirebaseStorage.instance
        //     .ref()
        //     .child('user_images')
        //     .child('${userCredential.user!.uid}.jpg');
        // await storageRef.putFile(_selectedImage!);
        // final imageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid).set({
              'username' : '...',
              'email' : _enteredEmail,
              // 'image_url' : imageUrl,
            });
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Authentication Failed!')),
      );
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
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              width: 200,
              child: Image.asset('images/profile.png'),
            ),
            Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // if (!_isLogin)
                      //   UserImagePicker(
                      //     pickedImage: (File pickedImage) {
                      //       _selectedImage = pickedImage;
                      //     },
                      //   ),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                        ),
                        onSaved: (newValue) => _enteredEmail = newValue!,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter an email.';
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                              .hasMatch(value)) {
                            return 'Please enter a valid email address.';
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
                            return 'Password must be at least 6 characters long.';
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
                        child: Text(_isLogin ? 'Login' : 'Sign Up'),
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
                        child: Text(_isLogin
                            ? 'Create Account'
                            : 'Already have an account?'),
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
