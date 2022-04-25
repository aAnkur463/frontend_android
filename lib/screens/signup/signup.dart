import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommerce_app/http/httpuser.dart';
import 'package:ecommerce_app/screens/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ecommerce_app/models/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static String routeName = "/signup";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();

  String fullName = '';
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 79, 79),
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  // color: Colors.amberAccent,
                  alignment: Alignment.center,
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 247, 79, 79),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (value) {
                    fullName = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Enter your name',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    email = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter the email',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    password = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: ' Password:',
                    hintText: 'Enter the password',
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.minPositive, 50),
                  ),
                  onPressed: () async {
                    _formkey.currentState!.save();
                    User user = User(
                      fullName: fullName,
                      password: password,
                      email: email,
                    );
                    var value = await HttpConnectUser.registerPost(user);
                    print(value);
                    if (value == true) {
                      // Navigator.pushNamed(context, ProductList.routeName);
                      MotionToast.success(
                              description: const Text('New User Added'))
                          .show(context);
                    } else {
                      MotionToast.error(
                              description: const Text('Failed to add user'))
                          .show(context);
                    }
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.minPositive, 50),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  },
                  child: const Text('Log In'),
                ),
              ],
            )),
      ),
    );
  }
}
