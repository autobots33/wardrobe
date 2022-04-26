import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  late final TextEditingController _firstname;
  late final TextEditingController _lastname;
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _firstname = TextEditingController();
    _lastname = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstname.dispose();
    _lastname.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Register '),
      ),
      body: Column(
        children: [
          TextField(
            controller: _firstname,
            decoration:
                const InputDecoration(hintText: 'Enter your first name here'),
          ),
          TextField(
            controller: _lastname,
            decoration:
                const InputDecoration(hintText: 'Enter your last name here'),
          ),
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: 'Enter your email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
                const InputDecoration(hintText: 'Enter your password here'),
          ),
          TextButton(
              onPressed: () async {
                final firstname = _firstname.text;
                final lastname = _lastname.text;
                final password = _password.text;
                final email = _email.text;

                try {
                  final userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _email.toString(),
                          password: _password.toString());
                  print(userCredential);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('Weak Password');
                  } else if (e.code == 'email-already-in-use') {
                    print('Email Already in use');
                  } else if (e.code == 'invalid-email') {
                    print('Invalid Email entered');
                  }
                }
              },
              child: const Text(' Register ')),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/login/',
                (route) => false,
              );
            },
            child: const Text(' Already Registered?   Login here! '),
          )
        ],
      ),
    );
  }
}
