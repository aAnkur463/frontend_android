import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommerce_app/http/httpuser.dart';
import 'package:ecommerce_app/screens/Admin/admin_view.dart';
import 'package:ecommerce_app/screens/Client/client_view.dart';
import 'package:ecommerce_app/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ecommerce_app/models/user.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static String routeName = "/signin";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 79, 79),
        title: const Text('SignIN'),
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
                    'Log In',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 247, 79, 79),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (value) {
                    email = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
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
                    labelText: 'Password',
                    hintText: 'Enter the password',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.minPositive, 50),
                  ),
                  onPressed: () async {
                    _formkey.currentState!.save();
                    String credEmail = email;

                    String credPassword = password;

                    var res = await HttpConnectUser.loginPosts(
                        credEmail, credPassword);
                        

                    if (res == null) {
                      MotionToast.error(
                              description: const Text('Invalid Username or Password'))
                          .show(context);
                    } else {
                      print(res['user']);
                      if(res['user']['role'] == true){
                      Navigator.pushNamed(context, AdminScreen.routeName);

                      MotionToast.success(description: const Text('Welcome Back'))
                          .show(context);
                      }else{
                         Navigator.pushNamed(context, ClientScreen.routeName);

                      MotionToast.success(description: const Text('Welcome Back'))
                          .show(context);
                      }
                    }
                  },
                  child: const Text('Log In'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.minPositive, 50),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreen.routeName);
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            )),
      ),
    );
  }
}
