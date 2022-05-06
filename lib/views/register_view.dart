import 'package:flutter/material.dart';
import 'package:practise/constants/routes.dart';
import 'package:practise/services/auth_service.dart';
import '../services/auth/auth_exceptions.dart';
import '../utilities/dialog/error_dialog.dart';

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
            decoration: const InputDecoration(
              hintText: 'Enter your first name here',
            ),
          ),
          TextField(
            controller: _lastname,
            decoration: const InputDecoration(
              hintText: 'Enter your last name here',
            ),
          ),
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your email here',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your password here',
            ),
          ),
          TextButton(
              onPressed: () async {
                final firstname = _firstname.text;
                final lastname = _lastname.text;
                final email = _email.text;
                final password = _password.text;
                try {
                await  AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  AuthService.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                } on WeakPasswordAuthException {
                  await showErrorDialog(
                      context,
                      'Weak Password');
                } on EmailAlreadyInUseAuthException {
                  await showErrorDialog(
                      context,
                      'Email is already in use');
                } on InvalidEmailAuthException {
                  await showErrorDialog(
                      context,
                      'This is an invalid-email address');
                } on GenericAuthException {
                  await showErrorDialog(
                    context,
                    'Failed to Register',
                  );
                }
              },
              child: const Text(' Register ')),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
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
