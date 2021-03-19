import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_helper.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 100.0),
              Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "Enter email"),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Enter password"),
              ),
              const SizedBox(height: 10.0),
              RaisedButton(
                child: Text("Login"),
                onPressed: () async {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    print("Email and password cannot be empty");
                    return;
                  }
                  try {
                    final user = await AuthHelper.signInWithEmail(
                        email: _emailController.text,
                        password: _passwordController.text);
                    if (user != null) {
                      print("login successful");
                    }
                  } on FirebaseAuthException catch (e) {
                    print('Failed with error code: ${e.code}');
                    print(e.message);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
