
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practise/views/login_view.dart';

import 'firebase_options.dart';

//Future<void> main() async {
// WidgetsFlutterBinding.ensureInitialized();
//}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'SignUp Page',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const Homepage(),
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final user = FirebaseAuth.instance.currentUser;
                if(user?.emailVerified??false){
                  print('You are a verified user');
                }else{
                  print('You need to verify your email');
                }
          return const Text('Done');
              default:
                return const Text('Loading....');
            }
          }),
    );
  }
}



