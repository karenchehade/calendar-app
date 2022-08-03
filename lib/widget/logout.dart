import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogOut extends StatelessWidget {
  const LogOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ElevatedButton.icon(
    //     onPressed: signOut,
    //     icon: const Icon(Icons.arrow_back),
    //     label: const Text('SignOut' , style: TextStyle(fontSize: 20),));
    return IconButton(onPressed: signOut, icon: const Icon(Icons.logout));
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
